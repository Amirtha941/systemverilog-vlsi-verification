## 🧩 1️⃣ What is a Class in SystemVerilog?

A **class** in SystemVerilog is a **template** (or blueprint) for creating **objects**.  
It can contain:

-   **Data members (variables)**
    
-   **Methods (functions/tasks)**
    
-   **Constructors** (for initialization)
    
-   **Destructors** (for cleanup)
    

👉 Classes are used _only in simulation_ — not synthesizable (not hardware).  
They’re used in **testbenches**, **UVM**, **verification environments**, etc.

----------

## 🧩 2️⃣ Class Syntax Example
```
class MyClass;
  int a, b; // data members

  // Constructor
  function new(int x, int y);
    a = x;
    b = y;
  endfunction

  // Method
  function void display();
    $display("a = %0d, b = %0d", a, b);
  endfunction
endclass 
```
----------

## 🧩 3️⃣ What is a Handle?

A **handle** in SystemVerilog is like a **pointer** to an object.

-   You can’t directly create or access an object using the class name.
    
-   You must use a **handle** to refer to the object in memory.
    

### Example:

`MyClass obj1; // handle declaration (no memory allocated yet)` 

At this point:

-   `obj1` is just a _null handle_ (doesn’t point to any object).
    

----------

## 🧩 4️⃣ How to Create an Object (using new)

To **create (instantiate)** an object, use the **new()** constructor.

### Example:

`obj1 = new(10, 20); // constructor called` 

Now:

-   Memory is allocated for the object.
    
-   `obj1` points to that object.
    
-   `new(10,20)` calls the constructor in `MyClass`.
    

----------

## 🧩 5️⃣ Full Example — Handle + Object + Constructor

```
class MyClass;
  int a, b;

  // Constructor
  function new(int x, int y);
    a = x;
    b = y;
    $display("Constructor: a=%0d, b=%0d", a, b);
  endfunction

  // Method
  function void show();
    $display("Values are a=%0d and b=%0d", a, b);
  endfunction
endclass
```

```
module test;
  MyClass obj; // handle declaration

  initial begin
    obj = new(5, 15);  // object creation
    obj.show();        // calling class method
  end
endmodule 
```
**Output:**

`Constructor: a=5, b=15  Values  are a=5  and b=15` 

----------

## 🧩 6️⃣ Destructor (optional)

SystemVerilog automatically **destroys objects** when they go out of scope,  
but you can define a **destructor** using `function void delete()` if you need to release resources manually.

However, **SystemVerilog doesn’t have an explicit `destructor` keyword** like C++.  
Instead, you use:

-   `delete()` method for array cleanup
    
-   `handle = null` to remove reference
    

### Example:

`obj = null; // removes the handle’s reference to the object` 

After that, the object will be garbage collected automatically.

## 🧠 Example: Multiple Objects
```
module test;
  MyClass obj1, obj2;

  initial begin
    obj1 = new(1, 2);
    obj2 = new(3, 4);

    obj1.show();
    obj2.show();

    obj1 = null; // delete reference
    obj2 = null;
  end
endmodule
```
### In **C++**, when you write:

`MyClass obj;` 

✅ This **creates** an **object directly** on the **stack**.

-   Memory is allocated immediately.
    
-   `obj` **is the object itself** (not a pointer).
    
-   You can directly access it:
    
    `obj.display();` 
    

----------

### In **SystemVerilog**, when you write:

`MyClass obj;` 

🚫 This **does NOT** create an object.  
It only creates a **handle (a pointer/reference)** to a class object.

-   No memory is allocated yet.
    
-   The handle `obj` just exists — pointing to nothing (null).
    
-   You must explicitly create the object using `new()`:
    
    `obj = new(); // Now object is created in heap memory` 
    

That’s why we call it a **handle**, not an object —  
because it’s only a _reference_ (like a pointer), not the actual instance.

## ⚙️ Analogy — C++ vs SystemVerilog

|          Concept          |          C++         |                     SystemVerilog                    |
|:-------------------------:|:--------------------:|:----------------------------------------------------:|
| Object on stack           | MyClass obj;         | ❌ Not allowed — only handle                          |
| Pointer to object         | MyClass* ptr;        | ✅ MyClass handle;                                    |
| Create object dynamically | ptr = new MyClass(); | ✅ handle = new();                                    |
| Access via pointer        | ptr->display();      | ✅ handle.display(); (SystemVerilog uses dot, not ->) |
| Destroy                   | delete ptr;          | handle = null; (auto garbage collected)              |

So, in essence:

> 🔹 In **C++**, you can have both _objects_ and _pointers_.  
> 🔹 In **SystemVerilog**, you can **only** have _pointers (handles)_ to class objects.

----------

## 🧠 Why did SystemVerilog choose this?

Because **SystemVerilog classes are simulation-time objects**,  
not hardware structures.  
They live in the **simulation memory (heap)** — like dynamic testbench data, transactions, packets, sequences, etc.

So the language designers decided:

-   All class instances are **dynamically allocated**
    
-   All variables referring to them are **handles (references)**
  

| C++                                                               | SystemVerilog                                                                            |
| ----------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `cpp<br>MyClass obj;<br>obj.display();`                           | ❌ Not valid in SV (no automatic instantiation)                                           |
| `cpp<br>MyClass* obj;<br>obj = new MyClass();<br>obj->display();` | ✅ Equivalent in SV:<br>`systemverilog<br>MyClass obj;<br>obj = new();<br>obj.display();` |
