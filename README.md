# brew_crew

![View](assets/screen.PNG)
Получить значения виджета из state
```
   widget.toggleView();
```


```
//Задать уникальный идентификтор форме.
final _formKey = GlobalKey<FormState>();

привязываем идентификаторв к форме
child: Form(
    key: _formKey,
    ...
    )

//каждому полю присвоить проверку, если true, то ошибка есть, если null, то все ok.
validator: (val) => val.isEmpty ? 'Enter an email' : null,

//в кнопку submit добавить вызов всех валидаций
if (_formKey.currentState.validate())
```

Многие классы содержат полезный метод: copyWith. Который позоволяет добавлять свойста объекту
```
kTextInputDecoration.copyWith(hintText: 'Password')
```