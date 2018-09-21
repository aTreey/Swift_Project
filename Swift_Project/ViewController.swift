//
//  ViewController.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/9/21.
//  Copyright © 2018 HongpengYu. All rights reserved.
//

import UIKit

import UIKit
import SnapKit
import Moya
import SwiftyJSON


// MARK: - Swift中自定义类型
// MARK: - 1. 枚举
// MARk: - 2. 枚举原始值
// 定义 rawValue 为 Int 类型，初始值为1，
enum Month: Int {
    case January = 1
    case February
    case March
    case April
    case May
    case June
    case July
    case August
    case September
    case October
    case November
    case December
}

// rawValue 的整型值可以不连续
enum Season: Int {
    case Spring = 1
    case Summer = 5
    case Autumn = 10
    case Winter = 40
}

/// 枚举可以是字符串
// 字符串是变量名和 rawValue 的值相等
enum ProgrammerLanguae: String {
    case Swift
    case OC = "Objective-C"
    case C = "语言"
    case RN = "React-Native"
    case Java
}

// 使用rawValue
func residueNewYear(month: Month) -> Int {
    return 12 - month.rawValue
}
// 调用枚举的Moth的构造函数生成一个Month
let month = Month(rawValue: 5)

let swift = ProgrammerLanguae.Swift.rawValue
let oc = ProgrammerLanguae.OC
let RN = ProgrammerLanguae.RN.rawValue


//MARK: - 3. 枚举关联值 associate value
enum Status {
    case success(Int)
    case fail(String)
    case null // 未关联值
}

func associateValueTest(isSuccess: Bool) -> Status {
    if isSuccess {
        return .success(200)
    }
    return .fail("失败")
}


//MARK: 4. 枚举associateValue多个值
// 本质是关联了一个元祖(value0, value1, value2...)
enum Shape {
    case Square(width: Double)
    case Reactangle(width: Double, height: Double)
    case Circle(x: Double, y: Double, radius: Double)
    case Point
}

let square = Shape.Square(width: 20)
let reactangle = Shape.Reactangle(width: 10, height: 20)
let circle = Shape.Circle(x: 10, y: 10, radius: 20)
let point = Shape.Point

private func area(shape: Shape) -> Double {
    switch shape {
    case let .Square(width):
        return width * width
    case let .Reactangle(width, height):
        return width * height
    case let .Circle(_, _, radius):
        return radius * radius * Double.pi
    case .Point:
        return 0
    }
}


//MARK: - 5. 递归枚举
// 定义一个递归算术表达式
// 使用 indirect 来修饰
indirect enum ArithmeticalExpression {
    case Number(Int)
    case Addition(ArithmeticalExpression, ArithmeticalExpression) // + 时两边也是一个表达式
    case Multiplication(ArithmeticalExpression, ArithmeticalExpression) // * 时两边也是一个表达式
    
    //    indirect case Addition(ArithmeticalExpression, ArithmeticalExpression) // + 时两边也是一个表达式
    //    indirect case Multiplication(ArithmeticalExpression, ArithmeticalExpression) // * 时两边也是一个表达式
}

// 递归表达式使用 (2+3) * 4
let two = ArithmeticalExpression.Number(2)
let one = ArithmeticalExpression.Number(3)
let sum = ArithmeticalExpression.Addition(two, one)
let indirectEnumResult = ArithmeticalExpression.Multiplication(sum, ArithmeticalExpression.Number(4))

// 计算表达式值的函数
private func calculate(expression: ArithmeticalExpression) -> Int {
    switch expression {
    case let .Number(value):
        return value
    case let .Addition(left, right):
        return calculate(expression: left) + calculate(expression: right)
    case let .Multiplication(left, right):
        return calculate(expression: left) * calculate(expression: right)
    }
}


// MARK: - 7. 结构体

struct Location {
    var latitude: Double?
    var longitude: Double?
    var placeName: String?
}

// 默认构造函数
// 结构体中的属性值没有初始化时必须使用构造函数来初始化
let location1 = Location(latitude: 37.3230, longitude: -122.0322, placeName: "测试")
var location23 = Location(latitude: 9.0, longitude: 10.56, placeName: "eet")

// 结构体中属性如果都赋了初始值
struct Location2 {
    var latitude: Double = 0
    var longitude: Double = 0
}

let location2 = Location2()

struct Location3 {
    // 如果未指定初始值，swift 就不会默认初始化为0，也就是不会初始化
    // let 只有一次赋值机会
    let latitude: Double
    let longtitude: Double
    
    // 当属性值为可选值时，允许不通过构造函数来初始化赋值
    var placeName: String?
    
    init(coordinateString: String) {
        let index = coordinateString.index(of: ",")
        let index1 = coordinateString.index(after: index!)
        
        // 方法3.0 之后弃用
        //        let firstElement = coordinateString.substring(to: index!)
        //        let endElement = coordinateString.substring(from: index1)
        
        
        // 取直到某个下标的前缀
        let test_1 = coordinateString.prefix(upTo: index!)
        // 取从某个下标起的后缀
        let test_2 = coordinateString.suffix(from: index1)
        
        latitude = Double(test_1)!
        longtitude = Double(test_2)!
    }
    
    // MARK: - 不管是类还是结构体都应该提供一个全参数的构造函数
    
    init(latitude: Double, longitude: Double, placeName: String?) {
        self.latitude = latitude
        self.longtitude = longitude
        self.placeName = placeName
    }
}


let test3 = Location3(coordinateString: "12,45")



// MARK: - 类型和属性




// MARK: - Swift中自定义类型=======END===========







//1. 隐式可选行
// 初始化 Country 时 需要调用self也就是当前的自己,
// 要使用self必须要等到Country初始化完成后再使用
// 使用隐式可选 ！解决

class Country {
    
    let name: String
    var capital: City! // 暂时是nil，使用之前会初始化
    
    init(countryName: String, capitalName: String) {
        name = countryName
        capital = City(name: countryName, country: self) // 此时再去初始化city
    }
    
    func showCountryInfo() {
        print("this is \(name)")
        print("the capital is \(capital)")
    }
}

class City {
    let cityName: String
    var country: Country
    init(name: String, country: Country) {
        self.cityName = name
        self.country = country
    }
}



class ViewController: UIViewController {
    
    let provider = MoyaProvider<PublicCourseAPI>()
    
    var leftButton: UIButton!
    var rightButton: UIButton!
    
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        self.navigationController?.pushViewController(FBOfflineTrainClenderController(), animated: true)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        layoutGuideTest()
        createSubview()
        
        stringSlicingTest()
        
        testPageController()
        
        
        // ---第二季---
        let temp = residueNewYear(month: .June)
        print(temp)
        print(swift,oc,RN)
        
        let associateValueResult = associateValueTest(isSuccess: true)
        switch associateValueResult {
        // 使用let 解析出和success相关联的值
        case let .success(code):
            print(code)
        case let .fail(error):
            print(error)
        case .null: // 未关联任何值
            print("等待中。。。")
        }
        
        print(area(shape: square))
        
        print(calculate(expression: indirectEnumResult))
        
        
        print(test3)
        
        
        /*
         let testView = UIView(frame: .zero)
         view.addSubview(testView)
         testView.backgroundColor = UIColor.orange
         
         let testButton = UIButton(type: .custom)
         testButton.frame = CGRect(x: 0, y: 100, width: 100, height: 44)
         testButton.setTitle("测试", for: .normal)
         testButton.backgroundColor = .blue
         
         testView.addSubview(testButton)
         
         let testArray: [String] = [String]()
         if testArray.isEmpty {
         print("空数组")
         } else {
         print("数组有值")
         }
         
         let china = Country(countryName: "中国🇨🇳", capitalName: "北京")
         china.showCountryInfo()
         
         //        swift_array()
         //        swity_Dict()
         swift_Tuples()
         
         let numbers = [123, 45, 67, 8, 0, 78, 30]
         let rest = findMaxAndMin(numbers: numbers)
         print(rest?.max, rest?.min)
         
         
         // 函数参数
         let sayHellow = sayHelloWorldTo(name: "swift", withGreeting: "I LOVE YOU")
         print(sayHellow)
         let _ = sayHelloWorldTo2("OC", "I LOVE YOU TOO")
         let function2 = sayHelloWorldTo2("哈哈")
         print(function2)
         
         // 可变参数
         changeableParameters(numbers: 1,2,3,4,5,6)
         
         // 元祖/交换两个数，或者修改两个数
         var a = 1
         var b = 2
         swapTowNum(&a, &b) // 按内存中地址引用传入，而不是拷贝一份儿原来的数据按值传入
         
         
         // 函数类型的变量
         let add2: (Int, Int) -> Int = add
         let result = add2(3,4)
         print(result)
         
         let sayHello2: (String, String) -> String = sayHelloWorldTo2
         let functionVar = sayHello2("hellow", "b")
         print(functionVar)
         // sorted 使用, 不会修改原来的数组，返回一个已经排序的数组
         var tempArray = [123, 45, 67, 8, 0, 78, 30]
         let sortArray = tempArray.sorted { (a, b) -> Bool in
         return a > b
         }
         print(sortArray)
         
         // 传入一个函数类型进行排序
         // 字符串/元祖/数组/都可以实现排序自定义排序规则
         tempArray.sort(by: biggerNumber(a:b:))
         let resultSorted = tempArray.sorted(by: biggerNumber)
         print(resultSorted)
         
         // 改变原来的数组，返回值为空
         tempArray.sort { (a, b) -> Bool in
         return a < b
         }
         print(tempArray)
         
         // 传入一个函数类型作为参数
         print(tempArray.sort(by: biggerNumber))
         let sortResult = tempArray.sorted()
         print(tempArray.sort())
         print(sortResult)
         
         
         // 函数式编程
         var scores = [99, 67, 40, 60, 59, 87,63,33]
         changeScores(scores: &scores, by: generateScore)
         //map 函数
         let changeScore = scores.map(generateScore)
         print(changeScore)
         //filter 函数
         let isFail = scores.filter(isPass)
         print(isFail)
         //reduce函数
         let scoreSum = scores.filter(isPass).reduce(0, +)
         print(scoreSum)
         
         
         
         
         //MARK: 7 闭包
         // 闭包 == 函数,他们都是引用类型
         var courseArray = [1, 5, 8, 3, 6]
         // 尾随闭包需要省略括号
         courseArray.sort{(a:Int, b:Int) -> Bool in
         return a > b
         }
         // 简化1 只有一行
         courseArray.sort{(a:Int, b:Int) -> Bool in return a > b}
         // 简化2 typeInference可自动推导类型
         courseArray.sort{a, b in return a > b}
         // 简化3 一定有返回值省略可return
         courseArray.sort{a, b in a > b}
         // 简化4 可使用默认默认命名
         courseArray.sort{$0 > $1}
         // 使用 swift 中运算符，运算符也是一种函数
         courseArray.sort(by: >)
         courseArray.sort(by: <)
         
         
         
         
         // MARK: 8闭包内容捕获
         let number = 500
         courseArray.sort{ a, b in
         return abs(a - number) > abs(b - number)
         }
         courseArray.sort{ abs($0 - number) > abs($1 - number) }
         */
        
        
        
        // MARK: - Login
        
        //        login()
        //        fetchseriseCourseList()
        
        //        var parameters: [String: Any] = [:]
        //        parameters["app_guid"] = kapp_guid
        //        parameters["version_code"] = kversion_code
        //        parameters["device_uuid"] = kdevice_uuid
        //        parameters["dev_type"] = kdev_type
        //        parameters["app_type"] = kapp_type
        //        parameters["channel_code"] = kchannel_code
        //        parameters["version"] = kversion
        //        parameters["push_channel"] = kpush_channel
        //        parameters["client_id"] = kclient_id
        //        parameters["user_token"] = kuser_token
        //
        //        let par = ["password": "e10adc3949ba59abbe56e057f20f883e",
        //                   "phoneNumber": "18899990015"]
        //        parameters.updateValue(par, forKey: "data")
        //
        //        loginRequest(param: parameters as [String : AnyObject])
    }
    
    
    @objc func login() {
        let request = PublicCourseAPI.login(param: ["name": "123"])
        provider.request(request) { (result) in
            switch result {
            case .success(let respon):
                let resp = JSON(respon.data)
                print(resp)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @objc func fetchseriseCourseList() {
        let request = PublicCourseAPI.getHomeSeriesCourseList(pageNum: 0)
        provider.request(request) { (result) in
            switch result {
            case .success(let response):
                let result = JSON(response.data)
                
                if let datas = result["data"].array {
                    print(datas)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    
    
    
    // MARk: 1. 枚举
    private func season(month: Month) -> String {
        let _ = Month.April
        let _ : Month = .April
        switch month {
        case .December, .January, .February:
            return "Winter"
        case .March, .April, .May:
            return "Autumn"
        case .June, .July, .August:
            return "Summer"
        case .September, .October, .November:
            return "Winter"
        }
    }
    
    private func season2(month: Month) -> Season {
        let _ = Month.April
        let _ : Month = .April
        switch month {
        case .December, .January, .February:
            return .Spring
        case .March, .April, .May:
            return .Autumn
        case .June, .July, .August:
            return .Summer
        case .September, .October, .November:
            return .Winter
        }
    }
    
    
    
    
    // MARK: -
    // MARK: - ===========Swift 数据类型==============
    // MARK: 6 /嵌套使用
    private func freeByWeight(weight: Float) -> Float {
        return 1 * weight
    }
    
    private func freeByWeight2(weight: Float) -> Float {
        return 3 * weight
    }
    
    // 总费用=邮费+商品价格
    private func calculatePrice(weight: Float, price: Float) -> Float {
        // 函数型变量作为返回值
        func choosePriceRank(of weight: Float) -> (Float) -> Float {
            return weight <= 10 ? freeByWeight : freeByWeight2
        }
        
        let mailFee = choosePriceRank(of: weight) // 变量存放的是一个函数类型
        return mailFee(weight) + price * weight
    }
    
    
    // MARK: 5 函数式编程及高阶函数map, reduce, filer用法
    func changeScores(scores: inout [Int], by changeScore: (Int) -> Int) {
        for (index, score) in scores.enumerated() {
            scores[index] = changeScore(score)
        }
    }
    
    private func generateScore(score: Int) -> Int {
        return score + 10
    }
    
    private func isPass(score: Int) -> Bool {
        return score < 60
    }
    
    
    
    // MARK: - 4.2 排序
    private func biggerNumber(a: Int, b: Int) -> Bool {
        return a > b
    }
    
    // MARK: - 4.1. 函数参数
    private func sayHelloWorldTo(name: String, withGreeting greeting: String) -> String {
        return "\(name), \(greeting)!"
    }
    // 省略函数参数名
    private func sayHelloWorldTo2( _ name: String, _ greeting: String = "payth") -> String {
        return "\(name), \(greeting)!"
    }
    // 参数长度可变
    private func changeableParameters(numbers: Int...) {
        for number in numbers {
            print(number)
        }
    }
    
    // 函数参数默认是let，不可改变, 使用inout 修饰按引用传参数
    private func toBinary( num: inout Int) -> String {
        var result = ""
        repeat {
            result = "\(num % 2)" + result
            num /= 2
        } while(num != 0)
        
        return result
    }
    
    
    // 函数类型的变脸
    private func add(a: Int, b: Int) -> Int {
        return a + b
    }
    
    
    // MARK: - 4. 使用元祖返回多个函数值
    private func findMaxAndMin(numbers: [Int]) -> (max: Int, min: Int)? {
        guard numbers.isEmpty else {
            return nil
        }
        //        if numbers.isEmpty {
        //            return nil
        //        }
        
        var maxValue = numbers[0]
        var minValue = numbers[0]
        for number in numbers {
            maxValue = maxValue > number ? maxValue : number
            minValue = minValue < number ? minValue : number
        }
        return (maxValue, minValue)
    }
    
    
    // MARK: - 3. 元祖
    // 将多个不同的值集合成一个数据，类型可不同，数量不限
    private func swift_Tuples() {
        let registResult: (Bool, String, Int) = (true, "swift", 01010)
        let networkError = (code: 404, msg: "Not found!") // 起别名
        let (isSuccess, _, _) = registResult
        if isSuccess {
            print(isSuccess)
        }
        
        print(registResult.0, registResult.1)
        print(networkError.code, networkError.msg)
        //        // 不能同时指定类型起别名
        //        let networkError1: (Int, String) = (code: 404, msg: "Not found!") // 起别名
        //        print(networkError1.code) //Value of tuple type '(Int, String)' has no member 'code'
        
    }
    
    // 元祖交换两个数
    private func swapTowNum(_ a: inout Int, _ b: inout Int) {
        (a,b) = (b,a)
    }
    
    // MARK: - 2. 初始化Array
    private func swift_array() {
        let boolArray = [Bool](repeating: false, count: 6)
        var intArray = [1,2,3,4,5,0]
        
        // 数组判空
        if boolArray.isEmpty {
            print("boolArray.isEmpty")
        } else {
            // last.first 为可选值，空数组没有值
            print(boolArray)
            print("last = \(boolArray.last!)")  // 最后一个
            print("first = \(boolArray.first!)") // 第一个
            print(intArray.min() ?? -1) //最小值
            print(intArray.max() ?? -1) // 最大值
            print(intArray.contains(0)) // 是否包含
            print(intArray.index(of: 1) ?? -1) // 元素下标
            print(intArray[1..<2])      // 子数组
            print(intArray[1...2])      // 子数组
            
            // 遍历数组
            for (index, item) in intArray.enumerated() {
                print(index,item)
            }
            
            // 区间修改数组
            intArray.removeSubrange(3..<5)
            print(intArray)
            intArray[0..<2] = [-1]
            print(intArray)
            
            intArray.replaceSubrange((1..<2), with: [4])
            print(intArray)
        }
    }
    
    
    // MARK: - 1. Dictory
    
    private func swity_Dict() {
        var dict = ["swift": "Apple",
                    "java": "orgle",
                    "python": "XXX"]
        if dict.isEmpty {
            print(dict.count)
        } else {
            let keys = dict.keys
            let keysArray = Array(dict.keys)
            
            print(dict.count)
            print(dict.keys)
            print(dict.values)
            print(Array(dict.keys))
            print(dict["java"] ?? "")
            // 增
            dict["js"] = "前端"
            print(dict)
            // 改
            print(dict.updateValue("脚本语言", forKey: "python") ?? "") // 返回的是旧值
            // 删
            dict["java"] = nil
            print(dict) // 设置nil
            dict.removeValue(forKey: "swift")
            dict.removeAll()
        }
    }
    
    
    private func layoutGuideTest() {
        // 创建LayoutGuide
        let layoutGuideA = UILayoutGuide()
        let layoutGuideB = UILayoutGuide()
        
        // 添加到View上
        let view: UIView = UIView(frame: CGRect(x: 0, y: 64, width: 200, height: 80))
        view.addLayoutGuide(layoutGuideA)
        view.addLayoutGuide(layoutGuideB)
        
        // 用UILayoutGuide来添加布局约束
        layoutGuideA.heightAnchor.constraint(equalTo: layoutGuideB.heightAnchor, constant: 0).isActive = true
        
        // 设置Identifier，为了方便DEBUG
        layoutGuideA.identifier = "layoutGuideA"
        layoutGuideB.identifier = "layoutGuideB"
        
        // ...然后看看他们的Frame吧
        print("layoutGuideA.layoutFrame -> \(layoutGuideA.layoutFrame)")
    }
    
    
    private func createSubview() {
        let topOffset = 70
        
        titleView.backgroundColor = UIColor.cyan
        self.view.addSubview(titleView)
        titleView.didClickClosure = { [weak self] in
            guard let strongSelf = self else { return }
            let react = CGRect(x: 0, y: $0.frame.maxY, width: strongSelf.view.frame.width, height: strongSelf.view.frame.width)
            strongSelf.filterMenu.show(in: strongSelf.view, react: react)
        }
        
        filterMenu.didSelectItemClosure = {
            self.titleView.title = $0.title
            self.titleView.rotateIconView()
            self.filterMenu.hiddenView()
        }
        
        
        
        self.leftButton = UIButton()
        self.leftButton.setTitle("Left Button", for: .normal)
        self.leftButton.backgroundColor = UIColor.orange
        self.view.addSubview(self.leftButton)
        self.leftButton.snp.makeConstraints { (maker) in
            maker.width.equalTo(110)
            maker.height.equalTo(40)
            if #available(iOS 11.0, *) {
                maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            } else {
                // Fallback on earlier versions
                maker.top.equalTo(topOffset)
            }
        }
        leftButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        self.rightButton = UIButton()
        self.rightButton.setTitle("Right Button", for: .normal)
        self.rightButton.backgroundColor = UIColor.purple
        self.view.addSubview(self.rightButton)
        self.rightButton.snp.makeConstraints { (maker) in
            maker.width.equalTo(self.leftButton)
            maker.height.equalTo(self.leftButton)
            maker.top.equalTo(topOffset)
        }
        
        rightButton.addTarget(self, action: #selector(fetchseriseCourseList), for: .touchUpInside)
        
        if #available(iOS 9.0, *) {
            let leadingMargin = UILayoutGuide()
            self.view.addLayoutGuide(leadingMargin)
            leadingMargin.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            leadingMargin.rightAnchor.constraint(equalTo: self.leftButton.leftAnchor).isActive = true
            
            let middleMargin = UILayoutGuide()
            self.view.addLayoutGuide(middleMargin)
            middleMargin.leftAnchor.constraint(equalTo: self.leftButton.rightAnchor).isActive = true
            middleMargin.rightAnchor.constraint(equalTo: self.rightButton.leftAnchor).isActive = true
            middleMargin.widthAnchor.constraint(equalTo: leadingMargin.widthAnchor).isActive = true
            
            let trailingMargin = UILayoutGuide()
            self.view.addLayoutGuide(trailingMargin)
            trailingMargin.leftAnchor.constraint(equalTo: self.rightButton.rightAnchor).isActive = true
            trailingMargin.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            trailingMargin.widthAnchor.constraint(equalTo: leadingMargin.widthAnchor).isActive = true
            
            print(leadingMargin.layoutFrame)
            print(middleMargin.layoutFrame)
            print(trailingMargin.layoutFrame)
            
            
        } else {
            // Create UIView for iOS 8 to implement the same feature.
        }
    }
    
    
    // MARK: - Lazy
    
    
    
    
    private lazy var filterMenu: DropDownFilterMenu = {
        
        let item0 = DropDownItem(title: "测试0", itemId: 100)
        let item1 = DropDownItem(title: "测试1", itemId: 101)
        let item2 = DropDownItem(title: "测试2", itemId: 102)
        let item3 = DropDownItem(title: "测试3", itemId: 103)
        let item4 = DropDownItem(title: "测试4", itemId: 104)
        let items = [item0, item1, item2, item3, item4]
        
        var config = DropDownFilterConfig()
        config.cellTextAlignment = .center
        
        let filterMenu = DropDownFilterMenu(items: items, config: config)
        return filterMenu
    }()
    
    private lazy var titleView = DropDrownTitleView(frame: CGRect(x: 10, y: 200, width: 300, height: 50), title: "全部")
    
    func setupFilter() {
        
    }
}

extension ViewController {
    private func loginRequest(param: [String: AnyObject]) {
        let list = NSMutableArray()
        let url = URL(string: "https://app-lbb.lebanban.com/app/user/login.json")!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for subDic in param {
            let tmpStr = "\(subDic.0)=\(subDic.1)"
            list.add(tmpStr)
        }
        
        //拆分字典,subDic是其中一项，将key与value变成字符串
        //用&拼接变成字符串的字典各项
        let paramStr = list.componentsJoined(by: "&")
        //UTF8转码，防止汉字符号引起的非法网址
        let paraData = paramStr.data(using: .utf8)
        //设置请求体
        request.httpBody = paraData
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { (data, respon, error) in
            
            if error != nil {
                print("error")
            }
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Post result \(responseString)")
        }
        task.resume()
    }
}

extension ViewController {
    private func stringSlicingTest() {
        let str = "123,435"
        let index = str.index(of: ",")!
        let subStr = str[..<index]
        print("[..<index] ---subStr = \(subStr)")
        let subStr1 = str[...index]
        print("[..<index] ---subStr2 = \(subStr1)")
        
        let subStr3 = str[index...]
        print("[index...] ---subStr3 = \(subStr3)")
        let subStr4 = str[index...]
        print("[index...] ---subStr4 = \(subStr4)")
        
        let subStr5 = str.prefix(upTo: index)
        print("prefix(upTo: index) ---subStr5 = \(subStr5)")
        
        let subStr6 = str.suffix(from: index)
        print("suffix(from: index) ---subStr6 = \(subStr6)")
        
        let index2 = str.index(after: index)
        let subStr7 = str.suffix(from: index2)
        print(index2)
        print(subStr7)
        
        let maxLimit = 5
        let limitStr = String(subStr.prefix(maxLimit))
        print(limitStr)
        
        
        let url = "https://m.lebanban.com/app/c/course/playerMp3Player/?test=lbb://ImageTextH5Courseware?/src=https://voddymj6stf.vod.126.net/voddymj6stf/6e325c6f-72b4-44b7-bf6b-38a5fffa2632.mp3?"
        if let range = url.range(of: "lbb://ImageTextH5Courseware?") {
            let subStr = url[range.upperBound...]
            print(subStr)
        }
        
        
        var text: String? = "102344234.5678"
        if let tempText = text {
            var changeText = tempText
            var frontText = tempText
            let pointRange:Range? = tempText.range(of: ".")
            if let pRange = pointRange {
                
                let pointBankText = String(changeText[pRange.upperBound..<changeText.endIndex])
                if pointBankText.count > 2 {
                    let endIndex = changeText.index(changeText.endIndex, offsetBy: -1)
                    changeText = String(changeText[..<endIndex])
                }
                frontText = String(changeText[..<pRange.lowerBound])
            }
        }
        
    }
}

