
### 🧠 Basic Idea

**Inheritance** means one class (child) can **reuse** and **extend** another class (parent).  
It helps avoid writing the same code again and again.

----------

### 🏠 Example (Real-life analogy)

Think of it like this:

-   You have a **parent class**: `Car`
    
-   You make a **child class**: `SportsCar`
    

A **SportsCar** _is a kind of_ **Car**, but with extra features.

----------

### 💻 In SystemVerilog Code

```
class Car;
  int speed;

  function void drive();
    $display("Car is driving at %0d km/h", speed);
  endfunction
endclass
``` 

Now we create a **child class** that **inherits** `Car`:

```
class SportsCar extends Car;
  int turbo_speed;

  function void boost();
    $display("SportsCar turbo speed = %0d km/h", turbo_speed);
  endfunction
endclass
``` 

----------

### 🧩 Using Them Together

```
module test;
  initial begin
    SportsCar s1 = new();

    s1.speed = 100;         // inherited from Car
    s1.turbo_speed = 200;   // defined in SportsCar

    s1.drive();  // from parent class
    s1.boost();  // from child class
  end
endmodule
``` 

**Output:**

```
Car is driving at 100 km/h
SportsCar turbo speed = 200 km/h
``` 

----------

### 📚 What Happened Here

|   Concept   |                       Meaning                      |
|:-----------:|:--------------------------------------------------:|
| extends     | keyword used to inherit another class              |
| Child class | Gets all variables and functions of the parent     |
| Child can   | Add new variables/functions                        |
| Child can   | Override parent functions (change how they behave) |

### ⚙️ Example: Overriding a Parent Function

```
class Car;
  function void drive();
    $display("Driving a normal car");
  endfunction
endclass

class SportsCar extends Car;
  function void drive();
    $display("Driving a sports car fast!");
  endfunction
endclass

module test;
  initial begin
    Car c = new();
    SportsCar s = new();

    c.drive(); // normal car
    s.drive(); // sports car
  end
endmodule
``` 

**Output:**

```
Driving a  normal car
Driving a sports car fast!
```

## 🧠 What is `super`?

👉 `super` is used inside a **child class** to **refer to the parent class**.  
You use it when you want to call a parent’s **function** or **constructor** from the child.

----------

## 🎯 Why Do We Need It?

Imagine you have a child class that overrides a parent function,  
but you _still_ want to use the parent’s version **inside** it.

Or when the parent class’s constructor does some setup,  
and you want to call that setup from the child’s constructor.

That’s when you use `super`.

----------

## 🧩 Example 1 — Calling Parent’s Function

```
class Car;
  function void drive();
    $display("Car is driving normally");
  endfunction
endclass

class SportsCar extends Car;
  function void drive();
    super.drive();  // Call parent version first
    $display("SportsCar drives faster!");
  endfunction
endclass

module test;
  initial begin
    SportsCar s = new();
    s.drive();
  end
endmodule
``` 

### 🧾 Output:

```
Car is driving normally
SportsCar drives faster!
``` 

🧩 Here:

-   `super.drive()` called the **parent function**.
    
-   Then the child added **its own logic**.
    

----------

## 🧩 Example 2 — Using `super.new()` (Calling Parent Constructor)

Let’s say your parent class does some setup inside its **constructor**.

```
class Car;
  int wheels;

  function new(int w);
    wheels = w;
    $display("Car constructor: wheels = %0d", wheels);
  endfunction
endclass

class SportsCar extends Car;
  string model;

  function new(int w, string m);
    super.new(w); // Call parent constructor
    model = m;
    $display("SportsCar constructor: model = %s", model);
  endfunction
endclass

module test;
  initial begin
    SportsCar s = new(4, "Ferrari");
  end
endmodule
``` 

### 🧾 Output:

```
Car constructor: wheels = 4 SportsCar 
constructor: model = Ferrari
```