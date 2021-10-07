# TurbineFun

This is not but a simple to-do app, so I can focus in understating concepts of Functional Reactive Programming and very poor documented [@funkia/turbine](https://github.com/funkia/turbine). You can see it working [here](https://turbine-fun.vercel.app).

#### Disclaimer

This project is incomplete. Not that I didn't want to complete it, but [@funkia](https://github.com/funkia) packages are not maintained and unusable as it is.

## Functional Reactive Programming

**Note**: I'll be using CoffeeScript 2 across this explanation. I'll try to keep its craziness to a minimal.

I started this project due to curiosity about Functional Programming. How can one create an app in FP, maintaining both **immutability** and **purity**, if it needs to have data that reacts to the user input. Here enters Functional Reactive Programming. The idea is, instead of defining what your elements do, you define how they react to the changing data, without the data itself, and then you can restrain down your **impure** functions to only one.

To do this, instead of working with the data itself, we work with the idea of a data. For instance, a `input` element can have any value depending on the user interaction, but it always has a string value, so you can say that its behavior is to have a value of string. Turbine defines this as having a `value` of type `Behavior<string>` that can be accessed using `.use someUsefulName: 'value'`. This means that a function that returns the value of `input` will always return the same `Behavior<string>`, since it's agnostic of the actual inputted value, staying **pure** while dealing with ever-changing data. You could pass this Behavior to another element at its content, and only once in your application you convert your Behaviors to values, keeping your **impurity** to a minimal.

```coffeescript
go ->
  { valueBehavior } = yield input().use valueBehavior: value
  yield span ['The inputed value is: ', valueBehavior]
```

The `go` function chains the yielded component and pipe its captured data back to the function.

This idea also extends to information that is not always present. For instance, a button will have information about the click event only when it's pressed. Turbine represents this as having a `click` of type `Stream<MouseEvent>`. A `Stream` is very similar to a `EventEmiter` as you can subscribe to it, running a callback every time it has value. But different from a `EventEmiter` and similar to a `Behavior`, you can manipulate it without accessing its value.

```coffeescript
go ->
  { valueBehavior } = yield input().use valueBehavior: value
  { clickStream } = yield (button 'OK').use clickStream: 'click'

  return valueStream: snapshot valueBehavior, clickStream
```

This `snapshot` function creates a new `Stream<string>` picking the value of `valueBehavior` every time `clickStream`. So we created an element chain that has captured a `Stream` representing the value that is being submitted, when it's being submitted. To allow for other components to use this information, we need to use the `component` function.

```coffeescript
component (state) ->
  elementChain = go ->
    { valueBehavior } = yield input().use valueBehavior: value
    { clickStream } = yield (button 'OK').use clickStream: 'click'

    return valueStream: snapshot valueBehavior, clickStream
  return elementChain.output submit: state.valueStream
```
