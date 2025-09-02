//Sherzod Hayitmatov PU220117

//Wednesday 09:00
#include <iostream>
#include <algorithm>
#include <vector>
#include <memory>
#include <string>
#include <future>
#include <stdexcept>

using namespace std;

//Question 6.1 - BankAccount class
class BankAccount {
private:
    double balance;
public:
    BankAccount(double initialBalance) {
        if (initialBalance >= 0) {
            balance = initialBalance;
        } else {
            balance = 0;
        }
    }
    
    void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }
    
    double getBalance() {
        return balance;
    }
};

//Question 7.1 - Season enum
enum class Season {
    SPRING,
    SUMMER,
    AUTUMN,
    WINTER
};

string recommendActivity(Season currentSeason) {
    switch (currentSeason) {
        case Season::SPRING: return "Plant flowers";
        case Season::SUMMER: return "Go to the beach";
        case Season::AUTUMN: return "Rake leaves";
        case Season::WINTER: return "Build a snowman";
        default: return "Rest";
    }
}

//Question 8.1 - Vehicle inheritance
class Vehicle {
public:
    void startEngine() {
        cout << "Engine has started." << endl;
    }
};

class Car : public Vehicle {
public:
    void drive() {
        cout << "The car is moving." << endl;
    }
};

//Question 9.1 - Printable mixin
class IStringable {
public:
    virtual string toString() const = 0;
    virtual ~IStringable() = default;
};

class Printable {
public:
    void print(const IStringable& obj) {
        cout << obj.toString() << endl;
    }
};

class Book : public IStringable {
private:
    string title;
    string author;
public:
    Book(string t, string a) : title(t), author(a) {}
    string toString() const override {
        return "'" + title + "' by " + author;
    }
};

//Question 10.1 - Polymorphism with shapes
class Shape {
public:
    virtual double getArea() const = 0;
    virtual ~Shape() = default;
};

class Circle : public Shape {
    double r;
public:
    Circle(double radius) : r(radius) {}
    double getArea() const override { 
        return 3.14159 * r * r; 
    }
};

class Rectangle : public Shape {
    double w, h;
public:
    Rectangle(double width, double height) : w(width), h(height) {}
    double getArea() const override { 
        return w * h; 
    }
};

//Question 11.1 - Async operations
long long calculateSum() {
    long long sum = 0;
    for (long long i = 1; i <= 1000000; ++i) {  
        sum += i;
    }
    return sum;
}

//Question 12.1 - Exception handling
void processAge(int age) {
    if (age < 0) {
        throw invalid_argument("Age cannot be negative.");
    }
    cout << "Age processed successfully: " << age << endl;
}

//Question 4.1
bool isPalindrome(const string& str) {
    int left = 0;
    int right = str.length() - 1;
    while (left < right) {
        if (str[left] != str[right]) {
            return false;
        }
        ++left;
        --right;
    }
    return true;
}
//Main Function
int main(int argc, char* argv[]){

    //Question 1.1:
    cout << "Number of arguments received: " << argc << endl;
    cout << "Arguments are: " << endl;
    for(int i = 0; i < argc; ++i){
        cout << "Argument " << i << ": " << argv[i] << endl;
    }
    /*
    Question 1.2
        Main is the entry point of the program where the execution begins.
        It can be called by the JVM witout creating an instance of a class, which allows the program to start without creating an object.
    Question 1.3
        Return type is int in C++, but void in JAVA
        Parameters in C++: (int argc, char* argv[]) and in JAVA: (String[] args)
        C++ does not have access modifiers, but JAVA has (public static) access modifier.
    Question 1.4
        Integer return refers to exit status in both languages, in C++, return 0 means success and any non-zero return means error; in JAVA, main returns void as stated in Question 1.2; to set non-zero exit in JAVA, we need to use ```System.exit(1)``` where we can use any non-zero value in the place of 1;
    */


    //Question 2.1:
    int a = 10;
    int b = 20;

    cout << "Before swap: " << a << " & " << b  << endl;
    swap(a, b);
    cout << "After swap: " << a << " & " << b << endl;
    /*
    Question 2.2
        Primitive types store values directly in memory, on the stak - they have fixed size and fast to access.
        Reference types store a reference to a data located on the heap - the variable holds the address, not the data.
    Question 2.3
        Scope means where a variable can be accessed within the code.
        Local scope - variables declared inside a function/method are only accessible inside that function/method
        Class-level/static scope - variables declared in a class are accessible throughout the class.
    Question 2.4
        Static-typed language: variables types are declared and checked at compile time, type errors are checked before running the program.
        Dynamic-typed language: variables are determined at runtime. The same variable can hold many types at different times, type errors only occur when code is execuded.
    */

    

    //Question 3.1:
    int n1 = 0, n2 = 1, nextTerm = 0;

    cout << "First 10 Fibonacci numbers: " << endl;

    for(int i = 1; i <= 10; ++i){
        if(i == 1){
            cout << n1 << " ";
            continue;
        }
        if(i == 2){
            cout << n2 << " ";
            continue;
        }
        nextTerm = n1 + n2;
        n1 = n2;
        n2 = nextTerm;
        

        cout << nextTerm << " ";
    }
    cout << endl;

    /*
    Question 3.2
        While loop checks the condition before each iteration; do-while loop iterates at least once, and then checks the condition. We can use do-while loop when we need to loop through the body at least once before checking the condition.
    Question 3.3
        Switch statement is multi-way branching based on the value of the logic. Case specifies a value to match; if matches, executes its block; break exits switch block, prevents fall-through next case; defaults gets executed if no case matches.
    Question 3.4
        Logical AND (&&) - if the first operand is false, second operand is not evaluated. Logical OR - if the first operand is true, the second operand is not evaulated.
        We might use it when receiving full name in terms of firstname and lastname from backend. we might use if(firstName && lastName){ //do some logic}
    */

    cout << " madam is palindrome ? " << ( isPalindrome ( " madam " ) ? " true " : " false" ) << endl ;
    cout << " hello is palindrome ? " << ( isPalindrome ( " hello " ) ? " true " : " false" ) << endl ;

    //Question 6.1 - Testing BankAccount
    cout << "\n=== Testing BankAccount ===" << endl;
    BankAccount myAccount(100.50);
    cout << "Initial balance: " << myAccount.getBalance() << endl;
    myAccount.deposit(50.25);
    cout << "Balance after deposit: " << myAccount.getBalance() << endl;

    //Question 7.1 - Testing Season enum
    cout << "\n=== Testing Season Enum ===" << endl;
    Season now = Season::AUTUMN;
    cout << "It's autumn! Let's: " << recommendActivity(now) << endl;

    //Question 8.1 - Testing Vehicle inheritance
    cout << "\n=== Testing Vehicle Inheritance ===" << endl;
    Car myCar;
    myCar.startEngine();  // Inherited from Vehicle
    myCar.drive();        // Defined in Car

    //Question 9.1 - Testing Printable mixin
    cout << "\n=== Testing Printable Mixin ===" << endl;
    Book myBook("The Hobbit", "J.R.R. Tolkien");
    Printable p;
    p.print(myBook);

    //Question 10.1 - Testing Polymorphism
    cout << "\n=== Testing Polymorphism ===" << endl;
    vector<unique_ptr<Shape>> shapes;
    shapes.push_back(make_unique<Rectangle>(10, 5));
    shapes.push_back(make_unique<Circle>(3));
    for (const auto& shape : shapes) {
        cout << "Area: " << shape->getArea() << endl;
    }

    //Question 11.1 - Testing Async operations
    cout << "\n=== Testing Async Operations ===" << endl;
    cout << "Main thread: Starting calculation..." << endl;
    future<long long> sumFuture = async(launch::async, calculateSum);
    cout << "Main thread: Waiting for result..." << endl;
    long long result = sumFuture.get();
    cout << "Main thread: The calculated sum is: " << result << endl;

    //Question 12.1 - Testing Exception handling
    cout << "\n=== Testing Exception Handling ===" << endl;
    int userAge = -5;
    try {
        cout << "Processing age: " << userAge << endl;
        processAge(userAge);
    }
    catch (const invalid_argument& e) {
        cerr << "Error: " << e.what() << endl;
    }
    cout << "Program continues." << endl;
    /*
    Question 4.2
        Pass-by-value: function receives a copy of the argument. Changes inside the function do not affect the original variable.
        Pass-by-pointer: function receives an address to the variable. Changes made by address changes the actual variable.
        Pass-by-reference: function receives an ailas to the original variable. Changes affect the original variable.

        In JAVA:
            Primitive types are always passed by values.

            Objects are passed by their value references. The reference itself is copied, but both the original and the copy point to the same object. 
    Question 4.3
        Defining multiple functions/methods with the same name but different parameters. 

        Parameter list must be different for overloading.
    Quesetion 4.4
        When a function calls iteslf within the function, it's called recursion, base case is where the program calls stop, preventing infinite recursion. Without base case, we encounter stack overflow.
    */

    //Question 5.1 is about commenting single line/multiline (I have been commenting in different styles so far)

    /*
    Question 5.2
        Comments are crucial for code maintability, readability. One developer can show what he has done on specific method or function to another developer.
    Question 5.3
        Those systems allow developers to write structured comments directly in source code. They automatically generate documentation for classes/methods/functions.
    Question 5.4
        As developers, we should write code following Clean Code principles, which means that the code should be readable and understandable even after years another programmer is assigned to refactor/modify the code.
    */

    /*
    Question 6.1 - BankAccount class implementation shown above
    Question 6.2
        Class is a blueprint/template for creating objects. Object is an instance of a class - actual entity created from the class blueprint.
    Question 6.3
        Public - accessible from anywhere; Private - only accessible within the same class; Protected - accessible within the class and its subclasses.
    Question 6.4
        Constructor is a special method that initializes objects when they are created. Default constructor has no parameters and is automatically provided by compiler if no other constructor is defined.
    
    Question 7.1 - Season enum implementation shown above
    Question 7.2
        Enums provide type safety, prevent invalid values, make code self-documenting, and enable better compiler optimizations compared to strings or integers.
    Question 7.3
        Enums make code more readable by using meaningful names instead of magic numbers. They provide compile-time type checking to prevent invalid values.
    Question 7.4
        Java enums can have methods and fields, C++ scoped enums are more limited but provide better type safety than old C-style enums. Java enums are classes, C++ enums are just named constants.
    
    Question 8.1 - Vehicle/Car inheritance shown above
    Question 8.2
        "Is-a" relationship means inheritance (Car is-a Vehicle). "Has-a" relationship means composition (Car has-a Engine).
    Question 8.3
        Method overriding allows subclasses to provide specific implementation of parent method. Virtual/override ensures proper polymorphic behavior.
    Question 8.4
        Diamond Problem occurs when a class inherits from two classes that share a common base. C++ uses virtual inheritance, Java avoids it by not allowing multiple class inheritance.
    
    Question 9.1 - Printable mixin implementation shown above
    Question 9.2
        Mixins promote code reuse without strict inheritance hierarchy, allowing classes to gain functionality from multiple sources.
    Question 9.3
        Java default methods in interfaces allow adding functionality to existing interfaces without breaking implementations.
    Question 9.4
        Inheritance creates tight coupling, composition provides flexibility, mixins offer reusability without hierarchy constraints.
    
    Question 10.1 - Shape polymorphism implementation shown above
    Question 10.2
        Compile-time polymorphism: method overloading (same name, different parameters). Runtime polymorphism: method overriding (virtual functions, decided at runtime).
    Question 10.3
        Abstract class can have some implemented methods. Interface/pure abstract class has only pure virtual functions. Use interface for contracts, abstract class for shared implementation.
    Question 10.4
        Interfaces and pure virtual classes define contracts that implementing classes must follow, enabling polymorphic behavior through common interface.
    
    Question 11.1 - Async operation implementation shown above
    Question 11.2
        Asynchronous programming prevents blocking the main thread during slow operations like I/O, keeping applications responsive.
    Question 11.3
        Parallel execution: multiple tasks running simultaneously on different cores. Concurrent execution: multiple tasks making progress by time-slicing on same core.
    Question 11.4
        Future/Promise represents eventual result of async operation. Allows main thread to continue while waiting for background task completion.
    
    Question 12.1 - Exception handling implementation shown above
    Question 12.2
        Try contains risky code, catch handles exceptions, finally (Java) always executes. C++ uses RAII - destructors automatically clean up resources.
    Question 12.3
        Java has checked exceptions (must be declared/handled) and unchecked exceptions (runtime). C++ doesn't distinguish in type system.
    Question 12.4
        Exceptions provide cleaner error handling, separate error logic from main logic, but can impact performance and make control flow complex.
    */

    return 0;
}