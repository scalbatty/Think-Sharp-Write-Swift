//: # Think Sharp, Write Swift


/*: 
 This is the C# iterative version of the fibonacci sequence
 
    static int fib(int n)
    {
      int fib0 = 0, fib1 = 1;
      for (int i = 2; i <= n; i++)
      {
        int tmp = fib0;
        fib0 = fib1;
        fib1 = tmp + fib1;
      }
      return (n > 0 ? fib1 : 0);
    }

*/

//: Warnings left intentionally

func fib(n: Int) -> Int
{
  var fib0 = 0, fib1 = 1
  
  for var i = 2; i <= n; i++
  {
    var tmp = fib0
    fib0 = fib1
    fib1 = tmp + fib1
  }
  
  return n > 0 ? fib1 : 0
}

func swiftyFib(n: Int) -> Int
{
  var fib0 = 0, fib1 = 1
  
  for _ in 2...n
  {
    let tmp = fib0
    fib0 = fib1
    fib1 = tmp + fib1
  }
  
  return n > 0 ? fib1 : 0
}

//: ## Enumerables

enum Land {
  case Forest
  case Mountain
  case Swamp
  case Plains
  case Island
}

enum Error : Int {
  case NotFound = 404
  case ServerError = 500
  case Forbidden = 403
  case Teapot = 418
}

enum PaymentMethod {
  
  case Cash
  case Check (Int)
  case CreditCard (CardType, Int)
  
  enum CardType { case Visa, MasterCard, Electron }
  
  func display() {
    switch self {
    case Cash:
      print("Paid by cash")
    case let Check(number):
      print("Paid by check #\(number)")
    case let CreditCard(type, number):
      print("Paid by \(type) #\(number)")
    }
  }
}

let method = PaymentMethod.CreditCard(.Visa, 995423)
method.display()

enum Result<T, U> {
  case Success(T)
  case Error(U)
}

indirect enum Tree<T> {
  case Empty
  case Node(T, left: Tree<T>, right: Tree<T>)
}


/*:
 ## The Optional implementation (or Maybe Monad)
 
    enum Optional<T> {
      case Some(T)
      case None
    }
*/


let nineThousand: Float = 9 * 1000

let vegetaSays = "It's over \(nineThousand) !!"
let nappaSays = "What!? " + String(nineThousand) + "?!"

//: ## Optional

func getAnswer() -> String { return "42" }
func processNumericAnswer(input: Int) { }

let answer = getAnswer()
let numericAnswer = Int(answer)

//let byOneThousand = numericAnswer * 1000 // Crashes!

if let realAnswer = numericAnswer {
  processNumericAnswer(realAnswer)
}
else {
  print("Please give a number")
}

let sanitizedAnswer = numericAnswer ?? 1
processNumericAnswer(sanitizedAnswer)


struct Contact {
  var firstName:String
  var middleName:String?
  var lastName:String
  
  var emailAddress:String
  var emailVerified:Bool
}

func getContact() -> Contact? { return nil }

let contact: Contact? = getContact()

let email: String? = contact?.emailAddress

//: ## Fun with Properties

struct Contact2 {
  var firstName: String
  var middleName: String?
  var lastName: String
  
  let securityNumber: Int
  
  var fullName: String {
    if let initial = middleName?.characters.first {
      return "\(firstName) \(initial). \(lastName)"
    }
    else {
      return "\(firstName) \(lastName)"
    }
  }
  
  var emailVerified: Bool
  var emailAddress: String {
    didSet {
      emailVerified = false
    }
  }
}

//: ## Closures, `map()`, `filter()`, `reduce()`

func getContacts() -> [Contact2] { return [] }

let people = getContacts()
let targetNames = people
  .filter({ contact in contact.lastName.hasPrefix("G") })
  .map({ contact in contact.fullName })
  .sort()

func multipleOf(factor: Int) -> Int -> Bool {
  return { (number: Int) in number % factor == 0 }
}

let isEven = multipleOf(2)
isEven(4)

// Get the sum of multiples of 3 up to 100

(1...100)
  .filter(multipleOf(3))
  .reduce(0, combine: +)


//: ## Extensions & Protocols


extension Contact {
  func composeIntroduction() -> String { return "" }
  var abbreviatedName: String { return "" }
}

protocol StringSerializable {
  func serialize() -> String
}

extension StringSerializable {
  func serialize() -> String { return "" }
}

extension Contact: StringSerializable {
  func serialize() -> String { return "" }
}

