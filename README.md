# LP_ZMQ


**LP_ZMQ** is a [0mq](http://zeromq.org/) binding for **Swift 5.1**.

Reference : [https://github.com/goloveychuk/ZeroMQ](https://github.com/goloveychuk/ZeroMQ)

## Installation

Do the following step
```sh
sudo apt-get update
sudo apt-get install build-essential pkg-config
cd /tmp/
sudo curl -L -O https://github.com/zeromq/zeromq4-1/releases/download/v4.1.4/zeromq-4.1.4.tar.gz
sudo tar xf /tmp/zeromq-4.1.4.tar.gz
cd /tmp/zeromq-4.1.4
sudo ./configure --without-libsodium
sudo make
sudo make install
```

add the **dependencies in Package.swift**

```swift
dependencies: [
        ...
        .package(url: "https://github.com/Linzecong/LP_ZMQ.git", .branch("master"))
],
```

## Example

### REQ --- REP 

*client*
```swift
import LP_ZMQ
let context = try Context()
let clientsock = try context.socket(.req)
try clientsock.connect("tcp://127.0.0.1:5558")
try clientsock.send("hello")
var data = try clientsock.receive()
print(data)
try clientsock.send("hello")
data = try clientsock.receive()
print(data)
```

*server*
```swift
import LP_ZMQ

let context = try Context()
let serversock = try context.socket(.rep)
try serversock.bind("tcp://*:5558")
while true{
    let data = try serversock.receive()
    print(data)
    try serversock.send("world")
} 
```

## PUSH --- PULL 


*client*
```swift
import LP_ZMQ
let context = try Context()
let clientsock = try context.socket(.push)
try clientsock.connect("tcp://127.0.0.1:5558")
try clientsock.send("hello")
try clientsock.send("hello")
try clientsock.send("hello")
```

*server*
```swift
import LP_ZMQ

let context = try Context()
let serversock = try context.socket(.pull)
try serversock.bind("tcp://*:5558")
while true{
    let data = try serversock.receive()
    print(data)
} 
```

## PUB --- SUB


*client*
```swift
import LP_ZMQ
let context = try Context()
let clientsock = try context.socket(.sub)
try clientsock.connect("tcp://127.0.0.1:5558")
try clientsock.setSubscribe(Data("A".utf8)) // filter
while true{
    let data = try clientsock.receive()
    print(data)
}
```

*server*
```swift
import LP_ZMQ
import Foundation
let context = try Context()
let serversock = try context.socket(.pub)
try serversock.bind("tcp://*:5558")
while true{
    Thread.sleep(forTimeInterval: 1)
    //try serversock.send("A",mode:[SendMode.SendMore])
    try serversock.send(String("A123"))
} 
```

## ROUTER --- DEALER


*clientA*
```swift
import LP_ZMQ
let context = try Context()
let clientsock = try context.socket(.dealer)
try clientsock.setIdentity("A") 
try clientsock.connect("tcp://127.0.0.1:5558")
while true{
    let data = try clientsock.receive()
    print("A", data)
}
```

*clientB*
```swift
import LP_ZMQ
let context = try Context()
let clientsock = try context.socket(.dealer)
try clientsock.setIdentity("B") 
try clientsock.connect("tcp://127.0.0.1:5558")
while true{
    let data = try clientsock.receive()
    print("B", data)
}
```

*server*
```swift
import LP_ZMQ
import Foundation
let context = try Context()
let serversock = try context.socket(.router)
try serversock.bind("tcp://*:5558")
while true{
    Thread.sleep(forTimeInterval: 1)
    try serversock.send("A",mode:[SendMode.SendMore]) //to A
    try serversock.send(String("to A"))

    try serversock.send("B",mode:[SendMode.SendMore]) //to B
    try serversock.send(String("to B"))
} 
```


