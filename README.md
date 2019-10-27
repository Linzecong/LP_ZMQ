# LP_ZMQ


**LP_ZMQ** is a [0mq](http://zeromq.org/) binding for **Swift 5.1**.

Reference : [https://github.com/goloveychuk/ZeroMQ](https://github.com/goloveychuk/ZeroMQ)

## Features

- [x] Context
- [x] Socket
- [x] Message
- [x] Poller
- [x] Proxy

## Example

```swift
import LP_ZMQ

let context = try Context()

let inbound = try context.socket(.pull)
try inbound.bind("tcp://127.0.0.1:5555")

let outbound = try context.socket(.push)
try outbound.connect("tcp://127.0.0.1:5555")

try outbound.send("Hello World!")
try outbound.send("Bye!")

while let data = try inbound.receive() {
    print(data) // "Hello World!"
}
```

## Installation

Install ZeroMQ system library

```sh
./setup_env.sh
```

Add `LP_ZMQ` to `Package.swift`

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .package(url: "https://github.com/Linzecong/LP_ZMQ.git", .branch("master")),
    ]
)
```
