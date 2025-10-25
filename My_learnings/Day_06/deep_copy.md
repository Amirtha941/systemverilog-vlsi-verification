
## 🧱 How a Deep Copy Function Works

Since SystemVerilog doesn’t automatically create deep copies, you **write your own function** inside the class.

Here’s the **basic pattern** (syntax) 👇

```class ClassName;
  // class properties
  int a, b;

  // deep copy function
  function ClassName copy();
    ClassName temp = new();     // create a NEW object (destination)
    temp.a = this.a;            // copy each field from 'this' (source)
    temp.b = this.b;
    return temp;                // return the new (destination) object
  endfunction
endclass
``` 

----------

### 💬 Explanation Line-by-Line

`function ClassName copy();` 

This defines a **function** that returns a **ClassName type** (a new object of the same class).

`ClassName temp = new();` 

Creates a **new, empty object** — this is your **destination**.

`temp.a = this.a;` 

Copies the value of variable `a` from **this** (the _source_, the current object calling the function)  
into **temp** (the _destination_, new copy).

`return temp;` 

Gives back that new, independent object.

----------

## 🧠 3. Example in Use

```
class Box;
  int size;

  function Box copy();
    Box temp = new();
    temp.size = this.size;
    return temp;
  endfunction
endclass

module test;
  initial begin
    Box a = new();  a.size = 10;        // source
    Box b = a.copy();                   // destination (deep copy)

    b.size = 20;

    $display("a.size = %0d", a.size);  // 10
    $display("b.size = %0d", b.size);  // 20
  end
endmodule
``` 

💡 Both objects now have their own separate data.

----------

## 🧬 4. When Classes Contain Other Handles (Nested Copy)

If a class has another class or dynamic array, you also deep-copy _those_ inside the same function:

```
class Inner;
  int x;
endclass

class Outer;
  Inner i;

  function new();
    i = new();
  endfunction

  function Outer copy();
    Outer temp = new();
    temp.i = new();
    temp.i.x = this.i.x; // deep copy nested object
    return temp;
  endfunction
endclass
``` 

If you had just done `temp.i = this.i;` — that’s a **shallow copy**, both would share same `Inner` handle.


### 🪞 **Shallow Copy**

> Just copies the **handle (reference)** — both names point to the **same object** in memory.

📘 Example:

`a = b;   // shallow copy` 

If you change `a`, `b` also changes — because they are both referring to the **same object**.

🧠 Think of it like:

> Two remotes controlling the **same TV**.

----------

### 🧊 **Deep Copy**

> Creates a **new object** and copies the **data inside** separately.

📘 Example:

`b = a.copy(); // deep copy (you write this function)` 

If you change `b`, `a` stays the same — they’re **independent**.

🧠 Think of it like:

> Taking a **photo** of a book — now you have two books with same content, but separate.

|          Feature          |        Shallow Copy        |            Deep Copy           |
|:-------------------------:|:--------------------------:|:------------------------------:|
| What it copies            | Handle (reference)         | Data + new object              |
| Memory                    | Shared                     | Separate                       |
| Change one affects other? | ✅ Yes                      | ❌ No                           |
| How to make it            | Simple assignment (a = b;) | Write a custom copy() function |