import Foundation
var age:Int?
let g:Double = 9.8

var rfm:Int = 25

switch rfm {
case 0...20:
    print("You are Underfat")
case 21...35:
    print("You are Healthy")
case 36...42:
    print("You are Overfat")
default:
    print("You are Obese")
}

var s:String = "Hello"

var result1 = ""
for i in stride(from: s.count-1, through: 0, by: -1){
    var n = (s[s.index(s.startIndex, offsetBy: i)])
    result1 += String(n)
}
print(result1)

var s2:String = "Hello from Arizona"
let components = s2.components(separatedBy: " ")
var result:String = ""
for i in stride(from: 0, through: components.count-1, by: 1){
    var s = components[i]
    for i in stride(from: s.count-1, through: 0, by: -1){
        var n = s[s.index(s.startIndex, offsetBy: i)]
        result += String(n)
    }
    result += " "
}
print(result)

var nums = [6, 4, 8, 5, 3, 2]

func evenOdd(array: [Int]) -> (even: Int, odd: Int){
    var evenSum = 0
    var oddSum = 0
    for num in array {
        if (num % 2 == 0){
            evenSum += num
        }
        else {
            oddSum += num
        }
    }
    return(evenSum, oddSum)
}

print("\(evenOdd(array: nums))")

var strings = ["Clean", "Guy", "Apple", "Banana", "Maroon"]

func longShort(array: [String]) -> (shortest: Int, longest: Int) {
    var currentMin = array[0].count
    var currentMax = array[0].count
    for str in array {
        if(str.count < currentMin){
            currentMin = str.count
        }
        else if (str.count > currentMax){
            currentMax = str.count
        }
    }
    return(currentMin, currentMax)
}

print("\(longShort(array: strings))")

class cityStatistics {
    var cityName:String?
    var population:Int?
    var latitude:Double?
    var longitude:Double?
    init(name:String, pop:Int, lat:Double, long:Double){
        self.cityName = name
        self.population = pop
        self.latitude = lat
        self.longitude = long
    }
    func getPopulation() -> Int
    {
        return(self.population!)
    }
    func getLatitude() -> Double{
        return(self.latitude!)
    }
}

var cities: [String:cityStatistics] = [:]

cities["Paris"] = cityStatistics(name: "Paris", pop: 2160000, lat: 48.85, long: 2.35)

cities["Chicago"] = cityStatistics(name: "Chicago", pop: 2697000, lat: 41.88, long: -87.63)
cities["Moscow"] = cityStatistics(name: "Moscow", pop: 11980000, lat: 55.75, long: 37.62)
cities["Sydney"] = cityStatistics(name: "Sydney", pop: 5312000, lat: -37.87, long: 151.21)
cities["Amsterdam"] = cityStatistics(name: "Amsterdam", pop: 821752, lat: 52.37, long: 4.91)

var currentMax = 0
var currentCity = "none"
for (key, value) in cities {
    if(value.getPopulation() > currentMax){
        currentMax = value.getPopulation()
        currentCity = key
    }
}
print("\(currentCity): \(currentMax)")

var currentNorth:Double = -180.0
var currentCity2 = "none"
for (key, value) in cities {
    if(value.getLatitude() > currentNorth){
        currentNorth = value.getLatitude()
        currentCity2 = key
    }
}
print("\(currentCity2), latitude: \(currentNorth)")

var students : [[String:Any]] =
[[ "firstName": "John", "lastName": "Wilson", "gpa": 2.4 ], [
"firstName": "Nancy", "lastName": "Smith", "gpa": 3.5 ], [
"firstName": "Michael", "lastName": "Liu", "gpa": 3.1 ]]

var currentMax2:Double = 0.0
var currentName = "none"
for dict in students {
  if (dict["gpa"] as! Double > currentMax2) {
    currentMax2 = dict["gpa"] as! Double
    currentName = "\(dict["firstName"] as! String) \(dict["lastName"] as! String)"
  }
}
print(currentName)
