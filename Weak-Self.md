code: auto(42), Source Code Pro

# iOS Memory Management
## Automatic Reference Counting (ARC)

---

## Strong Reference Cycles Between Class Instances

---

```swift
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
```
---

```swift
var john: Person? = Person(name: "John Appleseed")
var unit4A: Apartment? = Apartment(unit: "4A")
```

![inline](https://docs.swift.org/swift-book/_images/referenceCycle01_2x.png)

---
```swift
john!.apartment = unit4A
unit4A!.tenant = john
```

![inline](https://docs.swift.org/swift-book/_images/referenceCycle02_2x.png)

---
```swift
john = nil
unit4A = nil
```
![inline](https://docs.swift.org/swift-book/_images/referenceCycle03_2x.png)

---
## Resolving Strong Reference Cycles Between Class Instances

---
### Weak References
[.code-highlight: 11]
```swift
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
```
---
### Weak References

![inline](https://docs.swift.org/swift-book/_images/weakReference01_2x.png)

---
### Weak References
[.code-highlight: 1-2]
[.code-highlight: 4-5]
[.code-highlight: all]

```swift
john = nil
// Prints "John Appleseed is being deinitialized"

unit4A = nil
// Prints "Apartment 4A is being deinitialized"
```

![inline](https://docs.swift.org/swift-book/_images/weakReference03_2x.png)

---
## Unowned References

---
### Unowned References
> Use an unowned reference only when you are sure that the reference always refers to an instance that hasn’t been deallocated.

### Weak References
> Use a weak reference when the other instance has a shorter lifetime—that is, when the other instance can be deallocated first. 

---
```swift
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}
```

---
## Strong Reference Cycles for Closures

---

## Strong Reference Cycles for Closures

> Just like strong references between objects, a retain cycle can occur between a closure and an instance capturing that closure.

---

# Let's have a demo

### https://github.com/pkurzok/Cyclic-Closure-Sample