# Storybook for iOS

Storybook for iOS is a library to gains the speed of UI development.<br>
It brings us to preview the component independently each state that UI can display.

This library enables us to develop the UI without many times to rebuild in a big application and we could build them fully without missing an exception case.

<sub>✨This library is inspired by [Storybook](https://storybook.js.org/) for Web application development.<sub>

## Features

## Basic Usage

*Setting up your book**

Use this example component `MyComponent` for demo.
It's just a box that filled with purple color.

```swift
public final class MyComponent: UIView {

  public override func layoutSubviews() {
    super.layoutSubviews()

    backgroundColor = .systemPurple
  }

  public override var intrinsicContentSize: CGSize {
    .init(width: 60, height: 60)
  }
}
```

`Book` indicates a root of Storybook.<br>
Book can have a name describes itself, and we can declare the contents inside trailing closure.

```swift
let myBook = Book(title: "MyBook") {
  ...
}
```

For now we put a preview of `MyComponent` with `BookPreview`.

```swift
let myBook = Book(title: "MyBook") {
  BookPreview {
    let myComponent = MyComponent()
    return MyComponent()
  }
}
```

To display this book, present StorybookViewController on any view controller.

```swift
let controller = StorybookViewController(book: myBook) {
  $0.dismiss(animated: true, completion: nil)
}

present(controller, animated: true, completion: nil)
```

<img width=320 src="https://user-images.githubusercontent.com/1888355/82445841-7ab11980-9ae0-11ea-91f0-3ff2974d25cc.png" />


**Adding the name of the component**

`BookPreview` can have the name label with like this.

```swift
BookPreview {
  let component = MyComponent()
  return component
}
.title("MyComponent")
```

<img width=320 src="https://user-images.githubusercontent.com/1888355/82446390-88b36a00-9ae1-11ea-9e3f-a6bc66231f01.png" />

**List the state of the component**

A UI component would have several states depends on something.
We can list that components each state with following.

```swift
let myBook = Book(title: "MyBook") {
  BookPreview {
    let button = UISwitch()
    button.isOn = true
    return button
  }
  .title("UISwitch on")

  BookPreview {
    let button = UISwitch()
    button.isOn = false
    return button
  }
  .title("UISwitch off")
}
```

<img width=320 src="https://user-images.githubusercontent.com/1888355/82446756-34f55080-9ae2-11ea-8aff-31acf5993638.png" />

Of course, you can interact with these components.

**Update a state of the components dynamically**

UI Components should have a responsibility that updates themselves correctly with the new state.<br>
For example, resizing itself according to the content.

In order to check this behavior, `BookPreview` can have the button to update something of the component.

```swift
BookPreview<UILabel> {
  let label = UILabel()
  label.text = "Initial Value"
  return label
}
.addButton("short text") { (label) in
  label.text = "Hello"
}
.addButton("long text") { (label) in
  label.text = "Hello, Hello,"
}
```

<img width=320 src="https://user-images.githubusercontent.com/1888355/82447850-d16c2280-9ae3-11ea-9186-bb1c1509a94d.gif" />

## Advanced Usage

**Creating a link to another pages for organizing**

Increasing the number of the components, the page would have long vertical scrolling.<br>
In this case, Storybook offers you to use `BookNavigationLink` to create another page.

```swift
let myBook = Book(title: "MyBook") {
  BookNavigationLink(title: "UISwitch") {
    BookPreview {
      let button = UISwitch()
      button.isOn = true
      return button
    }
    .title("UISwitch on")

    BookPreview {
      let button = UISwitch()
      button.isOn = false
      return button
    }
    .title("UISwitch off")
  }
}
```

<img width=320 src="https://user-images.githubusercontent.com/1888355/82448459-b3eb8880-9ae4-11ea-80f3-e663339ad5e6.gif" />

## Requirements

- iOS 10.0+
- Xcode 11.4+
- Swift 5.2+

## Installation

**CocoaPods** 

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Alamofire into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
pod 'StorybookKit'
```

```ruby
pod 'StorybookUI'
```

## License

Storybook-ios is released under the MIT license.


