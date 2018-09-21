//
//  SwiftLearning.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/28.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//  SwiftLearningController

import UIKit

class SwiftLearningController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swift Learning"
        view.backgroundColor = .cyan
        self.structIndex()
        mutableStructIndex()
        overrideOperator()
        extensionFunc()
        extensionFoundation()
        genericStack()
        protocolTest()
        
//        gcdSemaphore()
        
//        operation()
        swiftPOP()
        
        turnGameTest()
        
//        strongRetain()
        
        unownedTest()
        
        typeCheck()
        
        anyAndAnyObject()
    }
    
    
    
    private func operation() {
        let queue = OperationQueue.main
        let operatin1 = BlockOperation {
            
            for i in 0...300 {
                print("request -- 1")
            }
        }
        
        let operatin2 = BlockOperation {
            for i in 0...200 {
                print("request -- 2")
            }
        }
        
        let operatin3 = BlockOperation {
            for i in 0...160 {
                print("request -- 3")
            }
        }
        
        operatin3.addDependency(operatin1)
        operatin3.addDependency(operatin2)
        queue.addOperations([operatin1, operatin2, operatin3], waitUntilFinished: true)
        
    }
    
    // MARK: - GCD
    private func gcdSemaphore() {
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            for i in 0...300 {
                print("request -- 1")
            }
            semaphore.signal()
        }
        
        DispatchQueue.global().async {
            semaphore.wait()
            for i in 0...200 {
                print("request -- 2")
            }
            semaphore.signal()
        }
        
        
        DispatchQueue.global().async {
            semaphore.wait()
            for i in 0...160 {
                print("request -- 3")
            }
        }
    }
    
    private func structIndex() {
        var v = Vector_3(x: 1, y: 2, z: 3)
        // 结构体使用下标获取值
        print(v[0], v[1], v[2], v[3], v[100]) // Optional(1.0) Optional(2.0) Optional(3.0) nil nil
        print(v["x"], v["y"], v["z"], v["i"]) // Optional(1.0) Optional(2.0) Optional(3.0) nil
        print("============")
        
        // 结构体使用下标修改值
        v[0] = 101
        v[1] = 202
        v[2] = 303
        v[3] = 400
        v[100] = 51
        print(v[0], v[1], v[2], v[3], v[100]) // Optional(101.0) Optional(202.0) Optional(303.0) nil nil
        
        v["x"] = 100
        v["y"] = 200
        v["z"] = 300
        v["i"] = 50
        print(v["x"], v["y"], v["z"], v["i"]) // Optional(100.0) Optional(200.0) Optional(300.0) nil
    }
    
    private func mutableStructIndex() {
        var matrix = Matrix(row: 2, column: 3)
        print(matrix[0,0])
        print(matrix[0][1])
        
        matrix[0,0] = 100.0
        print(matrix[0,0])
        
        matrix[1][1] = 200.0
        print(matrix[1][1])
        print(matrix[1,1])
        
    }
    
    
    private func overrideOperator() {
        var v1 = Vector_3(x: 1, y: 2, z: 3)
        var v2 = Vector_3(x: 2, y: 4, z: 6)
        let v3 = v1 + v2
        print(v1 + v2)
        print(v2 - v1)
        print(v1 * v2)
        print(-v3)
        
        print(+++v1)
        print(v2+++)
    }
    
    
    // extension
    func extensionFunc() {
        var rect = Rectangle(origin: Point(), size: Size(height: 20, width: 20))
        rect.translate(x: 20, y: 20)
        
        print(rect.origin)
        print(rect.center)
        rect.center = Point(x: 200, y: 200)
        
        let rect2 = Rectangle(center: Point(x: -10, y: -10), size: Size(height: 30, width: 30))
        print(rect2)
        
        print(rect.point(of: Rectangle.Vertex.right_top))
    }
    
    // 扩展标准库
    func extensionFoundation() {
        print(2.square)
        print(3.cube)
        print(4.inRange(clousedLeft: 0, openRight: 4))
        4.repeatitions {
            print("extension")
        }
        
        
        // 使用变长函数
        4.stride(from: 0, to: 8, by: 4) {
            print("stride")
        }
    }
    
    // 协议实现栈数据结构
    func genericStack() {
        var stack = Stack<Int>()
        stack.push(3)
        stack.push(4)
        stack.push(5)
        print(stack)
        print(stack.bottom())
        print(stack.top())
        print(stack.pop())
    }
    
    // 协议
    private func protocolTest() {
        var coder = Programmer(name: "小王")
        coder.old = 30
        var iOSCoder: Person = coder // 可以当作类型
        print(coder)
        print(iOSCoder)
    }
    
    // 面向协议编程
    private func swiftPOP() {
        let basketRecord = BasketballRecord(wins: 8, losses: 2)
        let total = basketRecord.totalGames
        let winPercent = basketRecord.winningPerent()
        print(winPercent, total)
        
        let footableBallRecord = FootableRecord(wins: 7, losses: 2, ties: 1)
        let playGames = footableBallRecord.totalGames
        let footBallWinPercent = footableBallRecord.winningPerent()

        print(playGames, footBallWinPercent)
        award(basketRecord)
        award(footableBallRecord)
        
        
        
        let student = Student(name: "小明", score: 70)
        award(student)
        award2(student)
        award2(basketRecord)
        award2(footableBallRecord)
        
        
        
        let studentA = Student(name: "A", score: 60)
        let studentB = Student(name: "B", score: 80)
        let studentC = Student(name: "C", score: 90)
        let studentD = Student(name: "D", score: 40)
        let studentE = Student(name: "E", score: 59)
        
        let studens = [studentA, studentB, studentC, studentD, studentE]
        let maxStudent = maxScore1(seq: studens)
        print(maxStudent.name)
        
        let numbers = [2,5,8,0,1,5,7,4]
        print(maxScore1(seq: numbers))

        let strings = ["OC","swift","RN"]
        print(maxScore1(seq: strings))
        print(topPrizable(seq: studens)?.name)
    }
    
    
    // 协议编程练习
    func turnGameTest() {
        let numberGame = RollNumberGame()
        numberGame.play()
        
        let rockPaperScissorsGame = RockPaperScissorsGame()
        rockPaperScissorsGame.play()
    }
    
    /// 错误处理
    func swiftErrorTest() {
        
    }
    
    
    /// swift强引用循环 weak 关键字使用
    func strongRetain() {
        var landlord: Landlord? = Landlord(name: "老李")
        var house: House? = House(person: "望京府邸")
        // 房东有个房子
        landlord?.house = house
        // 房子有个主人
        house?.landlord = landlord
        
        landlord = nil
        house = nil
    }
    
    /// swift强引用循环 unowned 关键字
    func unownedTest() {
        var person: Landlord? = Landlord(name: "老王")
        var id: ID? = ID(person: person!, number: "10010")
        
        person?.id = id
        
        // 提前释放 person 内存
        person = nil
        
        // 获取身份证对应的人
//        print(id?.person)
//        let owner = id?.person
        id = nil
        
        print(id?.person)
        let owner = id?.person
    }
    
    
    /// 类型检查
    func typeCheck() {
        let dev = Coder(name: "老李-Java")
        let iosDev = iOSDeveloper(name: "小黄")
        let programmer = Programmer(name: "老张-php")
        
        if dev is iOSDeveloper {
            print("iOS 开发者")
        } else {
            print("其他开发者")
        }
        
        if programmer is Coder {
            print("老张-php是一农个码农")
        } else {
            print("")
        }
    }
    
    
    /// 类型检查
    func anyAndAnyObject() {
        print(anyObjectArray)
        
        anyArray.append({ (a: Int) -> (Int) in return a * a })
        
        print(anyArray)
    }
}


// MARK: - 一. Swift 下标
// 1.数组/字典下标
var array = [1,2,3,4,5,6]
let temp = array[0]
let temp2 = array[2]

var dict = ["key1": 1, "key2": 2, "key3": 3]
let temp3 = dict["key1"]

// 三维向量的结构体
struct Vector_3 {
    var x = 0.0
    var y = 0.0
    var z = 0.0
    
    // 1. 直接使用下标获取属性值报错： Type 'Vector_3' has no subscript members
    // 2. 增加下标成员函数,可以理解为一个特殊的函数，需要传入参数和返回值，
    //
    subscript(index: Int) -> Double? {
        
        // 重写了get方法 实现通过下标获取属性值
        get {
            switch index {
            case 0: return x
            case 1: return y
            case 2: return z
            default: return nil
            }
        }
        
        // 重写 set 方法，实现g通过下标设置属性值，使用系统默认的newValue
        set {
            guard let newValue = newValue else {return}
            switch index {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            default: return
            }
        }
    }
    
    // 3. 可以增加第二种下标--根据坐标轴获取属性值
    subscript(axis: String) -> Double? {
        
        get {
            switch axis {
            case "X", "x": return x
            case "Y", "y": return y
            case "Z", "z": return z
            default: return nil
            }
        }
        
        set {
            guard let newValue = newValue else {return}
            switch axis {
            case "X", "x": x = newValue
            case "Y", "y": y = newValue
            case "Z", "z": z = newValue
            default: return
            }
        }
    }
    
    // 4. 使用下标修改属性值，重写 subscript 的 set 方法，获取的

}

// MARK: - 二. 多维下标
// 矩阵结构体
struct Matrix {
    var data: [[Double]]
    let row: Int
    let column: Int
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
        data = [[Double]]()
        for _ in 0..<row {
            let aRow = Array(repeating: 1.0, count: column)
            data.append(aRow)
        }
    }
    
    // 通过下标 [row,column] 方式访问
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(row >= 0 && row < self.row && column >= 0 && column < self.column, "下标不合法")
            return data[row][column]
        }
        
        set {
            assert(row >= 0 && row < self.row && column >= 0 && column < self.column, "下标不合法")
            data[row][column] = newValue
        }
    }
    
    // 通过下标 [row][column] 方式访问
    subscript(row: Int) -> [Double] {
        get {
            assert(row >= 0 && row < self.row, "下标不合法")
            // 直接返回数组，数组本身有下标
            return data[row]
        }
        
        set {
            assert(newValue.count == column, "下标不合法")
            data[row] = newValue
        }
    }
}

// MARK: - 三. 重载运算符， `=` 赋值运算符不可以重载

// 重载 + 运算符
func +(one: Vector_3, other: Vector_3) -> Vector_3 {
    return Vector_3(x: one[0]! + other[0]!, y: one[1]! + other[1]!, z: one[2]! + other[2]!)
    
//    return Vector_3(x: one.x + other.x, y: one.y + other.y, z: one.z + other.z)
}

// 两个参数时相减
func -(one: Vector_3, other: Vector_3) -> Vector_3 {
    return Vector_3(x: one.x - other.x, y: one.y - other.y, z: one.z - other.z)
}
// 一个参数时去反, 需要 prefix 修饰
prefix func -(a: Vector_3) -> Vector_3 {
    return Vector_3(x: -a.x, y: -a.y, z: -a.z)
}

// 向量相乘/向量和常量相乘
func *(one: Vector_3, other: Vector_3) -> Double {
    return (one.x * other.x) + (one.y * other.y) + (one.z * other.z)
}
// 两个参数不能交换，需要重载两次 *
func *(one: Vector_3, a: Double) -> Vector_3 {
    return Vector_3(x: a * one.x, y: a * one.y, z: a * one.z)
}

func *(a: Double, one: Vector_3) -> Vector_3 {
    return one * a
//    return Vector_3(x: a * one.x, y: a * one.y, z: a * one.z)
}

// 修改自身参数，不需要返回值
func +=(one: inout Vector_3, other: Vector_3) {
    // 已经重载过 + 运算符，可以直接调用
    one = one + other
}

func ==(one: Vector_3, other: Vector_3) -> Bool {
    return one.x == other.x &&
            one.y == other.y &&
            one.z == other.z
}

func !=(one: Vector_3, other: Vector_3) -> Bool {
    return !(one == other)
    return one.x != other.x ||
            one.y != other.y ||
            one.z != other.z
}

func <(one: Vector_3, other: Vector_3) -> Bool {
    if one.x != other.x {return one.x < other.x}
    if one.y != other.y {return one.y < other.y}
    if one.z != other.z {return one.z < other.z}
    return false
}

func <=(one: Vector_3, other: Vector_3) -> Bool {
    return one < other || one == other
    
    return one.x > other.x &&
            one.y > other.x &&
            one.z > other.z
}

func >(one: Vector_3, other: Vector_3) -> Bool {
    return (one <= other)
}

// 自定义操作符 a+++, +++a
// 声明后置操作符
postfix operator +++
// 定义
postfix func +++(vector: inout Vector_3) -> Vector_3 {
    vector += Vector_3(x: 1.0, y: 1.0, z: 1.0)
    return vector
}

prefix operator +++
prefix func +++(vector: inout Vector_3) -> Vector_3 {
    let temp = vector
    vector += Vector_3(x: 1.0, y: 1.0, z: 1.0)
    return temp
}


// MARK: - 四. 嵌套类型，例如String.Index
// 嵌套定义在某个类型里面的类型
class MyApp {
    enum Theme {
        case day
        case night
    }
    
    var fontColor: UIColor!
    var backgroundColor: UIColor!
    var themMode: Theme = .day {
        didSet {
            switch themMode {
            case .day:
                fontColor = .black
                backgroundColor = .white
                
            case .night:
                fontColor = .white
                backgroundColor = .black
            }
        }
    }
    
    init(theme: Theme) {
        self.themMode = theme
    }
}

// 调用时需要使用 MyApp.Theme 调用
let app = MyApp(theme: MyApp.Theme.day)

// MARK: - 五. 扩展
struct Point {
    var x = 0.0
    var y = 0.0
    
}

struct Size {
    var height = 0.0
    var width = 0.0
}

struct Rectangle {
    var origin = Point()
    var size = Size()
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
}

extension Rectangle {
    // 1.扩展方法
    mutating func translate(x: Double, y: Double) {
        self.origin.x += x
        self.origin.y += y
    }
    
    // 2.只能扩展计算型的属性，不能扩展存储型属性, 存储型属性需要在定义类或者结构体时声明
    var center: Point {
        get {
            let center_x = origin.x + size.width / 2.0
            let center_y = origin.y + size.height / 2.0
            return Point(x: center_x, y: center_y)
        }
        
        set {
            origin.x = newValue.x - size.width / 2.0
            origin.y = newValue.y - size.height / 2.0
        }
    }
    
    // 3. 扩展 构造方法
    // 类中不能扩展指定构造方法，只能在结构体中扩展
    // 结构体中不能扩展便利构造方法m，只能在类中扩展
    
    init(center: Point, size: Size) {
        let origin_x = center.x - size.width / 2.0
        let origin_y = center.y - size.height / 2.0
        self.origin = Point(x: origin_x, y: origin_y)
        self.size = size
    }
    
    // 结构体中不能扩展便利构造函数 Delegating initializers in structs are not marked with 'convenience'
//    convenience init(center: Point, size: Size) {
//        let origin_x = center.x - size.width / 2.0
//        let origin_y = center.y - size.height / 2.0
//        self.origin = Point(x: origin_x, y: origin_y)
//        self.size = size
//    }
    
    
    // 4. 扩展嵌套类型
    enum Vertex: Int {
        case left_top
        case left_bottom
        case right_bottom
        case right_top
    }
    
    // 获取某一个顶点坐标
    func point(of vertex: Vertex) -> Point {
        switch vertex {
        case .left_top:
            return origin
        case .left_bottom:
            return Point(x: origin.x, y: origin.y + size.height)
        case .right_bottom:
            return Point(x: origin.x + size.width, y: origin.y + size.height)
        case .right_top:
            return Point(x: origin.x + size.width, y: origin.y)
        }
    }
    
    
    // 5.扩展下标,根据传入的索引获取对应顶点坐标
    subscript(index: Int) -> Point? {
        assert(0 <= index && index < 4, "传入值非法")
        return point(of: Vertex(rawValue: index)!)
    }
}


// MARK: - 六 扩展系统中标准库
extension Int {
    /// 平方
    var square: Int {
        return self * self
    }
    
    /// 立方
    var cube: Int {
        return self * self * self
    }
    
    /// 判断数组是否在某一个范围内
    func inRange(clousedLeft left: Int, openRight right: Int) -> Bool {
        return self >= left && self > right
    }
    
    /// 重复执行操作
    func repeatitions(task: () -> ()) {
        for _ in 0..<self {
            task()
        }
    }
    
    /// 变长函数
    func stride(from: Int, to: Int, by: Int, task: () -> ()) {
        // 系统变长函数
        for i in Swift.stride(from: 0, to: 21, by: 3) {
            print(i)
        }
        
        for _ in Swift.stride(from: from, to: to, by: by) {
            task()
        }
    }
}

// MARK: - 七 Generic 泛型
// 使用泛型实现栈解构

struct Stack<T> {
    var items = [T]()
    
    // 判断是否为空
    func isEmpty() -> Bool {
        return items.count == 0
    }
    
    // 入栈
    mutating func push(_ item: T) {
        items.append(item)
    }
    
    // 出栈
    mutating func pop() -> T? {
        guard !self.isEmpty() else { return nil  }
        return items.removeLast()
    }
}

// 扩展 Stack
extension Stack {
    func top() -> T? {
        return items.last
    }
    
    func bottom() -> T? {
        return items.first
    }
}


// MARK: - 八 协议
// 面向对象:
// 协议：某些属性的集合，可以有多个协议组成

// 特点
// 1. 可以声明函数，但是不能实现，由实现这协议的具体结构或者类来实现
// 2. 声明的函数如果有参数也不能设置参数的默认值， 默认参数被认为也是函数的一种实现
// 3. 可以声明属性，必须是计算型属性 只能使用var 修饰，不能是存储型属性，必须在 {} 中明确指出属性的读取类型 例如 {get set}
// 4. 遵守协议的类可选择存储型属性或者计算型属性来实现协议中定义的属性
// 5. protocol Person: class { } 表示此协议只能被类来遵守，结构体不能遵守
// 6. 协议可以看着是一种类型，如果协议中的属性是只读的，如果是协议类型只能访问get 方法， 但是遵守协议的具体类或者结构可以设置属性的读和写

//```
//var coder = Programmer()
//coder.old = 30
//var iOSCoder: Person = coder //
//iOSCoder.old = 26 // 报错 Cannot assign to property: 'old' is a get-only property

//```

protocol Person {
    var name: String { get set }
    var old: Int { get }
    
    func eat()
    func eat(food: String)
    func run(distance: Double) -> Double
    // 修改解构体自身的namex属性
    mutating func changeName(name: String)
    
    // 增加构造函数
    init(name: String)
}

// 遵守协议
struct Programmer: Person {
    init(name: String) {
        self.name = name
    }
    
    
    // 第4条
//    private var programmerName: String = "小明"
//    private var programmerOld: Int = 24
//    // 使用计算型属性实现 name 的set get 方法
//    var name: String {
//        get {
//            return programmerName
//        }
//
//        set {
//            programmerName = newValue
//        }
//    }
//    // 使用计算型属性实现 old 的只读方法
//    var old: Int {
//        get {
//            return programmerOld
//        }
//    }
    
    
    // 直接使用存储型属性name 实现协议中的name，因为存储型属性本身具有可读可写的能力，可以采用以下声明方式
    var name: String = "小明"
    // old 因为是只读类型，所以使用let 声明时直接赋值
    var old = 22
    
    func eat() {
        print("eat")
    }
    func eat(food: String = "香蕉") {
        print(food)
    }
    
    func run(distance: Double = 5.0) -> Double {
        return distance
    }
    
    mutating func changeName(name: String) {
        self.name = name
    }
}


// 7. 协议中的构造函数
// 如果父类中遵守了协议中的构造函数，子类中必须重写父类中的构造函数并且使用require修饰构造函数，表示继承此类的子类也必须实现该构造函数
// 如果class 使用了final 修饰，表示不能被继承，此时不需要 require 关键词修饰

class Coder: Person {
    // 直接使用存储型属性name 实现协议中的name，因为存储型属性本身具有可读可写的能力，可以采用以下声明方式
    var name: String = "小明"
    // old 因为是只读类型，所以使用let 声明时直接赋值
    var old = 22
    
    required init(name: String) {
        self.name = name
    }
    func eat() {
        print("eat")
    }
    func eat(food: String = "香蕉") {
        print(food)
    }
    
    func run(distance: Double = 5.0) -> Double {
        return distance
    }
    
    func changeName(name: String) {
        self.name = name
    }
}

class iOSDeveloper: Coder {
    required init(name: String) {
        super.init(name: name)
        self.name = name
    }
}

// MARK: - 九 类型别名

// 1. 定义别名， 扩展
typealias Length = Double

extension Double {
    var km: Length {return self * 1_000.0}
    var m: Length {return self * 100.0}
    var cm: Length {return self / 10.0}
    /// 英尺
    var ft: Length { return self / 3.28084}
}

let distance: Length = 10.5.km

// 2. 定义别名防止硬编码
// 音频采样率
typealias AudioSample = UInt64

// 3. 协议中 typealias
// 协议中定义一个属性，该属性的类型根据不同的情况返回不同的类型（我理解为类似泛型），具体的类型由遵守此协议的类或者结构指定

protocol WeightCalculable {
    // 属性重量根据不同体积返回的可能是Int，可以可能是double类型，所以使用别名, 协议中使用associatedtype关键词，
    associatedtype WeightType
    var weight: WeightType {  get  }
}

// 遵守协议的结构指定真正类型
class iPhone: WeightCalculable {
    typealias WeightType = Double
    var weight: WeightType {
        return 0.5
    }
}

class Car: WeightCalculable {
    typealias WeightType = Int
    let weight: WeightType
    
    init(weight: Int) {
        self.weight = weight
    }
}

// 扩展 Int 中的吨单位
extension Int {
    typealias Weight = Int
    var t: Weight {return self * 1_000}
}


let bigCar = Car(weight: 8_000.t) // 8 吨


// MARK: - 十 标准库协议

// Equatable 协议 - 相等比较 重载==
// Comparable 协议 - 是否可比较 ，重载<, 可直接调用sort()函数
// CustomStringConvertible 协议 - 打印信息，重写description
// BooleanLiteralType 协议


//extension Int: BooleanLiteralType {
//    public var boolValue: Bool {
//        return self != 0
//    }
//}

// MARK: - 面向协议编程

// MARK: - 比赛协议，具有 赢。输。总场次。胜率 特性
protocol Recordable: CustomStringConvertible {
    var wins: Int { get }
    var losses: Int { get }
    
    func winningPerent() -> Double
}

extension Recordable {
    var description: String {
        return String(format: "WINS: %d---LOSSES: %d", [wins, losses])
    }
    
    // 默认实现总场数计算型属性
    var totalGames: Int {
        return wins + losses
    }
    
    // 默认实现胜率
    func winningPerent() -> Double {
        return (Double(wins) / Double(totalGames))
    }
    
    // 默认实现的方法
    func shoutWins() {
        print("come on", wins, "times!")
    }
}


// MARK: - 可支持平局的协议

protocol Tieable {
    /// 平局，可读写
    var ties: Int { get set }
    
}

struct BasketballRecord: Recordable {
    var wins: Int
    var losses: Int
    
//    func winningPerent() -> Double {
//        return (Double(wins) / Double(totalGames))
//    }
}

// MARK: - 篮球比赛
// 篮球比赛， 没有平局 ，只需要遵守 Recordable协议
struct Competition: Equatable, Comparable, CustomStringConvertible, Recordable {
    var wins: Int
    var losses: Int
    
    /// 在具体定义的类型中实现 协议中的属性或者方法就会覆盖协议中的
    var totalGames: Int = 200
    
    var description: String {
        return "本次比赛胜: " + String(wins) + "负" + "\(losses)"
    }
    
    
    // swift4.1 后，不需要再重写此方法，swift 会自动合成，如果不想让某一个属性参与比较，就需要重写该方法
    static func == (lhs: Competition, rhs: Competition) -> Bool {
        return lhs.wins == rhs.wins && lhs.losses == rhs.losses
    }
    
    // Comparable
    static func < (lhs: Competition, rhs: Competition) -> Bool {
        if lhs.wins != rhs.wins {
            return lhs.wins < rhs.wins
        }
        return lhs.losses > rhs.losses
    }
    
    
//    func winningPerent() -> Double {
//        return Double(wins / totalGames)
//    }
}


// MARK: - 足球比赛有平局， 遵守 Recordable 和 Tieable协议

// MARK: - 扩展遵守了Reocord协议的类型，前提条件是：这个类型遵守了 Tieable 同时也遵守了 Reocord协议，x可以理解为如果该类型遵守了 Tieable 协议之后，Record 协议中的 totalGames 属性实现是另一种方式了，不在是以前的

/// ` var totalGames: Int {
///     return wins + losses
/// }

// 这种形式

extension Recordable where Self: Tieable {
    var totalGames: Int {
        return wins + losses + ties
    }
}


struct FootableRecord: Recordable, Tieable {
    var wins: Int
    var losses: Int
    var ties: Int
    
    // 移到协议默认实现中
    /// 所有有平局的比赛计算总场次的逻辑都是如下，为了解决每次都需要重写这个属性，应该在扩展中有个默认的实现
//    var totalGames: Int {
//        return wins + losses + ties
//    }
    
    var description: String {
        return "本次比赛胜: " + String(wins) + "负" + "\(losses)"
    }
    
//    func winningPerent() -> Double {
//        return Double(wins / totalGames)
//    }
}


// MARK: -
// MARK: - 协议聚合

// MARK: - 定义奖赏的协议
protocol Prizable: CustomStringConvertible {
    func isPrizable() -> Bool
}

//extension Prizable {
//    var description: String {
//        return "小学生获得了奖赏"
//    }
//}

// 篮球比赛奖赏
extension BasketballRecord: Prizable {
    func isPrizable() -> Bool {
        return totalGames > 10 && winningPerent() > 0.5
    }
}
// 足球比赛奖赏
extension FootableRecord: Prizable {
    func isPrizable() -> Bool {
        return wins > 1
    }
}

// 定义奖赏方法, 参数是 Prizable 类型
private func award(_ one: Prizable) {
    if one.isPrizable() {
        print(one)
        print("恭喜获得奖励")
    } else {
        print(one)
        print("很遗憾")
    }
}

// 限制 one 参数的类型
// student 类遵守了Prizable 之后 使用print(one) 打印的结果是'Student(name: "小明", score: 70)',
// 不希望打出奖励语句是这个样子，所以还需要 遵守CustomStringConvertible 协议，所以对参数要求限制必须遵守两个协议才可以
// swift 3 写法： protocol<A, B>
// swift 4 写法： A & B
private func award2(_ one: Prizable & CustomStringConvertible) {
    if one.isPrizable() {
        print(one)
        print("恭喜获得奖励")
    } else {
        print(one)
        print("很遗憾")
    }
}

struct Student: Prizable {
    var name: String
    var score: Int
    
    func isPrizable() -> Bool {
        return score >= 60
    }
}

private func award3(_ one: Prizable) {
    if one.isPrizable() {
        print(one)
        print("恭喜获得奖励")
    } else {
        print(one)
        print("很遗憾")
    }
}


extension Student: CustomStringConvertible {
    var description: String {
        return name
    }
}



// MARK: -
// MARK: - 泛型约束
// Student 遵守了 Comparable, Equatable 可以进行比较

extension Student: Comparable, Equatable {
    // Comparable
    static func < (lhs: Student, rhs: Student) -> Bool {
        return lhs.score < rhs.score
    }
    
    // Equatable
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.score == rhs.score
    }
}


// 1. 定义一个函数，找出一个学生数组中分数最大的
// 参数：一个学生数组，都遵守了 Comparable 的类型
// 返回值：某个遵守了 Comparable 的类型实例
// 此时函数报错 `Protocol 'Comparable' can only be used as a generic constraint because it has Self or associated type requirements`, 因为 Comparable 协议中定义的方法  public static func < (lhs: Self, rhs: Self) -> Bool 的参数类型是Self，是具体的某个类型
/*
func maxScore(seq: [Comparable]) -> Comparable { }
 */
 

// 解决办法：使用泛型
func maxScore1<T: Comparable>(seq: [T]) -> T {
    assert(seq.count > 0, "传入数组不能为空")
    return seq.reduce(seq[0]) {
        max($0, $1)
    }
}

// 2. 如果需要定义一个函数实现在一个数组中找出需要奖励的人的名字该如何实现呢
// 参数：遵守两个协议 Comparable 和 Prizable 协议, 并且使用泛型
// 返回值：返回值是可选值，有可能没有任何奖励的对象
//

func topPrizable<T: Comparable & Prizable>(seq: [T]) -> T? {
    return seq.reduce(nil) { (tempTop: T?, condender: T) in
        guard condender.isPrizable() else { return tempTop }
        // 解包 condender 失败, 上一层验证了他必须是奖励的那个
        guard let tempTop = tempTop else { return condender }
        return max(tempTop, condender)
    }
}


/// 协议练习

// 回合制游戏协议
protocol TurnBaseGame {
    /// 回合数
    var turn: Int { get set }
    
    ///
    func play()
    
}


protocol SinglePlayerGameDelegate {
    /// 开始
    func gameStart()
    /// 玩家动作
    func playerAction()
    /// 结束
    func gameEnd()
    /// 回合结束
    func gameOver() -> Bool
    
    //TODO: 可选协议 需要加 @objc关键字
//    optional func turnEnd()
}
/// 单人回合制游戏
/// 此类中不进行具体的游戏内容设置，应该使用委托的方式来实现游戏内容
class SinglePlayerGame: TurnBaseGame {
    
    /// 回合数
    var turn: Int = 0
    
    var delegate: SinglePlayerGameDelegate!
    
    func play() {
        delegate.gameStart()
        while !delegate.gameOver() {
            delegate.playerAction()
            turn += 1
        }
        delegate.gameEnd()
    }
}

/// 1. 掷骰子游戏
class RollNumberGame: SinglePlayerGame {
    
    /// 分数
    var score = 0
    
    override init() {
        super.init()
        delegate = self
    }
    
}

extension RollNumberGame: SinglePlayerGameDelegate {
    func gameStart() {
        score = 0
        turn = 0
        print("游戏开始")
    }
    
    func playerAction() {
        let number = Int(arc4random() % 6 + 1) // 1～6 的随机数
        score += number
        print(number, score)
    }
    
    func gameEnd() {
        print(turn)
    }
    
    func gameOver() -> Bool {
        return score >= 100
    }
}


/// 2. 石头剪刀布游戏
class RockPaperScissorsGame: SinglePlayerGame {
    enum Shape: Int, CustomStringConvertible {
        case rock
        case scissors
        case paper
        
        func beat(shape: Shape) -> Bool {
            // 后一个可以打败前一个
            return (self.rawValue + 1) % 3 == shape.rawValue
        }
        
        var description: String {
            switch self {
            case .rock:
                return "✊"
            case .scissors:
                return "✂️"
            case .paper:
                return "📄"
            }
        }

    }
    
    
    var wins = 0
    
    override init() {
        super.init()
        delegate = self
    }
    
    static func action() -> Shape {
        return Shape(rawValue: Int(arc4random()) % 3)!
    }
    
    func show(hand: Shape) -> String {
        switch hand {
        case .rock:
            return "✊"
        case .scissors:
            return "✂️"
        case .paper:
            return "📄"
        }
    }
}


/// 错误处理之断言
extension RockPaperScissorsGame: SinglePlayerGameDelegate {
    func gameStart() {
        wins = 0
        print("===RockPaperScissorsGame开始=== ")
    }
    
    func playerAction() {
        let yourShape = RockPaperScissorsGame.action()
        let otherShape = RockPaperScissorsGame.action()
        
        print(show(hand:yourShape), show(hand:otherShape))
        
        print("你的手势是\(yourShape), 别人的手势是\(otherShape)")
        
        if yourShape.beat(shape: otherShape) {
            wins += 1
        } else {
            print("你输了")
        }
    }
    
    func gameEnd() {
        if wins >= 2 {
            print("游戏结束-- 你赢了--共\(turn), win=\(wins)")
        } else {
            
            assert(1 > 0)
//            assertionFailure()
//            assertionFailure("严重错误")
            precondition(1 > 0)
            print("游戏结 束-你输了-共\(turn), win=\(wins)")
        }
    }
    
    func gameOver() -> Bool {
        return turn >= 3
    }
    
    func test() {
        
    }
}


// MARK: -
// MARK: - 错误处理
// 定义可以抛出异常的方法
// assert
// assertionFailure()
// assertionFailure("严重错误")
// precondition(1 > 0)
// defer

func testThrows(name: String?, old: Int) throws -> Int {
    
    guard let _ = name else {
        return 0
    }
    guard old == 18 else {
        return 18
    }
    
    guard old < 18 else {
        return 12
    }
    
    return old
}

/// 错误类型
enum MyError: Error, CustomStringConvertible {
    
    case error1
    case error2
    case error3(Int) // 设置关联值
    
    var description: String {
        switch self {
        case .error1:
            return "名字为nil"
            
        case .error2:
            return "年龄18岁"
            
        case .error3:
            return "🔞--小于18岁"
        }
    }
}

// 以上方法可以写成这样
func testThrows2(name: String?, old: Int) throws -> Int {
    /// 表示延后执行，当函数作用域快要退出的时候就会执行，有return 就会这return 之后执行
    /// 此函数可以用在文件处理，完毕后关闭文件夹
    /// 可以写多个 defer ，按照倒叙执行，先定义的最后再执行
    defer {
        print("函数马上就要退出")
    }
    
    
    
    guard let _ = name else {
        // 抛出异常
        throw MyError.error1
    }
    guard old == 18 else {
        throw MyError.error2
    }
    
    guard old < 18 else {
        return 12
    }
    
    return old
}

/// 调用

//do {
//    try testThrows2(name: nil, old: 19)
//} catch MyError.error1 {
//    print(MyError.error1)
//} catch MyError.error2 {
//    print(MyError.error2)
//} catch MyError.error3(let old) {
//    print(MyError.error3)
//    print("输入的年龄是\(old)")
//} catch { // 前三种类型都不是
//    print("超出已经定义的错误类型之外")
//}


//do {
//    try testThrows2(name: nil, old: 19)
//} catch let error as MyError {
//    /// 处理error 的错误逻辑
//    print(error)
//}


// MARK: -
// MARK: - 强引用循环

// 房东
class Landlord {
    var name: String
    var house: House?
    /// 身份证可以为nil，
    var id: ID?
    
    var myId: ID!
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, id: ID) {
        self.name = name
        self.myId = ID(person: self, number: "3333")
    }
    
    deinit {
        print("Landlord内存释放")
    }
}

class House {
    var name: String
    weak var landlord: Landlord?
    
    init(person: String) {
        self.name = person
    }
    
    deinit {
        print("House内存释放")
    }
}

/// 每张身份证肯定对应一个人
class ID {
    var number: String
    unowned let person: Landlord
    
    init(person: Landlord, number: String) {
        self.person = person
        self.number = number
    }
    
    deinit {
        print("ID内存释放")
    }
}

/// 虽然 landlord = nil 和 house = nil，但是 Landlord 和 House 内存空间并没有释放 （并未执行 deinit 函数）
/// 因为两个内存空间相互引用，引用计数不为0，形成了强循环引用

/// 解决办法：
/// 使用weak 关键字来修饰两者中其中一个变量

func strongRetain() {
    var landlord: Landlord? = Landlord(name: "老李")
    let id = ID(person: landlord!, number: "4444")
    var house: House? = House(person: "望京府邸")
    // 房东有个房子
    landlord?.house = house
    // 房子有个主人
    house?.landlord = landlord
    
    landlord = nil
    house = nil
}


//let landlord: Landlord? = Landlord(name: "老李")
//let house: House? = House(person: "望京府邸")
//// 房东有个房子
//landlord?.house = house
//// 房子有个主人
//house?.landlord = landlord


/// swift强引用循环 unowned 关键字使用
/// person 和 id 之间有强引用关系
/// 每个id必须有一个对应的人并且是固定的只能使用let 修饰，不能为nil, 而id可以为空，

// 解决方法：
/// 此时设置可以通过使用weak 修饰id 的方式
/// let 修饰并且不能为nil 这种情况可以使用 unowned 修饰解决


func unownedTest() {
    var person: Landlord? = Landlord(name: "老王")
    var id: ID? = ID(person: person!, number: "10010")
    
    person?.id = id
    person = nil
    print(id?.person)
    let owner = id?.person
    id = nil
}


// MARK: -
// MARK: - 闭包中循环引用

class Closure {
    var closure: ((Int) -> Void)?
    
    init() {
        closure = { [unowned self] index in
            print(self)
            print(index)
        }
        
        closure = { [weak self] index in
            // 解包
            if let `self` = self {
                print(self)
                print(index)
            }
        }
        
        closure = { [weak self] index in
            // 强制解包
            print(self!)
            print(index)
        }
    }
}


// MARK: -
// MARK: - Swift类型检查
let dev = Coder(name: "老李-Java")
let iosDev = iOSDeveloper(name: "小黄")
func typeCheck() {
    let programmer = Programmer(name: "老张-php")
    
    // 是否是 iOSDeveloper 类型
    if dev is iOSDeveloper {
        print("iOS 开发者")
    } else {
        print("其他开发者")
    }
    
    if programmer is Coder {
        print("老张-php是一农个码农")
    } else {
        print("")
    }
    
    
    let ios = iosDev as? Programmer
    let ios2 = iosDev as Coder
    
    // 是否遵守了 Person 协议
    if iosDev is Person {
        print("遵守了Person协议")
    }
    
    
    let devs = [dev, iosDev, programmer] as [Any]
    
    for dev in devs {
        if let dev = dev as? Person {
            print(dev)
            print("遵守Person协议")
        } else {
            print("未遵守Person协议")
        }
    }
}


let iOSODev = iOSDeveloper(name: "小黄")

// 声明数组类型为 AnyObject

var anyObjectArray: [AnyObject] = [CGFloat(0.5) as AnyObject,
                             1 as AnyObject,
                             "string" as AnyObject,
                         iOSODev,
                            ]

// swift 支持面向函数编程，函数是一等公民, 函数表达的是一个过程，不是一个名词或者物体

var anyArray: [Any] = [CGFloat(0.5),
                                   1,
                                   "string",
                                   iOSODev]

//anyArray.append({ (a: Int) -> (Int) in return a * a })

