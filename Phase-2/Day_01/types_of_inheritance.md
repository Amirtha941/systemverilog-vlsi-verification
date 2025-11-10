
It means **how one class inherits another**, or **how many parents/children are involved** in that relationship.

SystemVerilog supports **single inheritance only** (like C++ and Java),  
but you can **create inheritance structures** that _behave_ like multiple forms — using **multi-level**, **hierarchical**, and **hybrid** patterns.

----------

## 🧩 1️⃣ **Single Inheritance**

➡ One **child** inherits from **one parent**.  
✅ Most common and directly supported in SystemVerilog.

```
class Parent;
  function void show();
    $display("I am Parent");
  endfunction
endclass

class Child extends Parent;
  function void show();
    $display("I am Child");
  endfunction
endclass
``` 

👉 The `Child` class gets all variables and methods from `Parent`.

----------

## 🧩 2️⃣ **Multi-Level Inheritance**

➡ A **chain** of inheritance.  
Parent → Child → Grandchild.

✅ Common in layered verification components.

```
class GrandParent;
endclass

class Parent extends GrandParent;
endclass

class Child extends Parent;
endclass
``` 

👉 Each class adds or overrides behavior from its parent.  
Used in **UVM**, where:

-   `uvm_component` → `uvm_env` → `my_env` → `my_test_env`
    

----------

## 🧩 3️⃣ **Hierarchical (Tree) Inheritance**

➡ One parent → multiple children.

✅ Used to create different specialized versions of a class.

```
class Vehicle;
endclass

class Car extends Vehicle;
endclass

class Bike extends Vehicle;
endclass
``` 

👉 All children share base functionality (like `start()`, `stop()`),  
but define their own specifics (`gear()`, `accelerate()`).

----------

## 🧩 4️⃣ **Hybrid Inheritance (Combination)**

➡ Combination of **multi-level + hierarchical** inheritance.

✅ Example:

```
	Vehicle
 ↙ 		  ↘
Car       Bike
  ↘
 SportsCar
 ``` 

```
class Vehicle; endclass
class Car extends Vehicle; endclass
class Bike extends Vehicle; endclass
class SportsCar extends Car; endclass
```` 

👉 Though SystemVerilog **doesn’t support true multiple inheritance**,  
you can **structure classes** like this to behave similarly (a hybrid pattern).

----------

## 🚫 5️⃣ **Multiple Inheritance** (❌ Not Supported Directly)

➡ A child inherits from **two or more parents**.

`// ❌ Not allowed in SystemVerilog
class Child extends Parent1, Parent2;` 

**Why not supported?**  
Because it leads to **ambiguity** — if both parents have the same function name, which one should the child use?

👉 Instead, SystemVerilog uses **interfaces** and **composition** to achieve similar results.