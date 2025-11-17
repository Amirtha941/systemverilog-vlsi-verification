
## 🧩 1. What is Polymorphism?

**Polymorphism** = _“many forms.”_  
It means the **same function call** can behave differently depending on the **actual object** that’s calling it.

In SystemVerilog (and C++), polymorphism allows you to:

> Call a method using a **parent class handle**,  
> and still execute the **child class version** of that method — at runtime.

Example:

```
class Parent;
  virtual function void display();
    $display("Parent display");
  endfunction
endclass

class Child extends Parent;
  function void display();
    $display("Child display");
  endfunction
endclass

module tb;
  Parent p;
  initial begin
    p = new Child();
    p.display(); // Output: Child display
  end
endmodule
``` 

👉 Output is `"Child display"` because the function is **virtual** — it’s chosen _at runtime_ based on the **actual object type**.

----------

## ⚙️ 2. Why We Use a Parent Handle

Polymorphism happens only when a **parent handle points to a child object:**

```
Parent p;
p = new Child();
p.display(); // Polymorphic call
``` 

If we use a child handle directly:

```
Child c = new();
c.display(); // Always Child’s version (no polymorphism)
``` 

then there’s no runtime decision — everything is known at compile time.

----------

## ⏱️ 3. Compile Time vs Runtime

### 🧱 Compile Time

-   The simulator **reads** and **checks** your code.
    
-   It **builds class structures**, **checks syntax**, and **binds functions** to their calls (if possible).
    
-   No object is created yet — it’s just preparation.
    

Think of it as the _“planning stage”_ before the movie shoot.

### ⚙️ Runtime

-   Simulation starts.
    
-   `new()` creates objects, initial blocks execute, `$display` prints.
    
-   This is where the **actual code runs** line by line.
    

Think of it as the _“action stage”_ — the movie is being acted out.

----------

## 🧠 4. Static Binding vs Dynamic Binding

|       Type      | When Decided |    Keyword   |          Behavior         |
|:---------------:|:------------:|:------------:|:-------------------------:|
| Static binding  | Compile time | No virtual   | Fixed to parent’s version |
| Dynamic binding | Runtime      | With virtual | Decided by actual object  |

### Example:

Without `virtual`:

```
class Parent;
  function void show(); $display("Parent"); endfunction
endclass
class Child extends Parent;
  function void show(); $display("Child"); endfunction
endclass

Parent p = new Child();
p.show(); // Output: Parent
``` 

With `virtual`:

```
class Parent;
  virtual function void show(); $display("Parent"); endfunction
endclass
class Child extends Parent;
  function void show(); $display("Child"); endfunction
endclass

Parent p = new Child();
p.show(); // Output: Child
``` 

----------

## 💡 5. Why `virtual` Changes the Behavior

-   When a function is **not virtual**, the compiler _fixes_ the function call to the **handle type** at compile time.  
    → `p.show()` is always `Parent::show()` because `p` is a Parent handle.
    
-   When a function **is virtual**, the compiler delays the decision until runtime.  
    → It says, “I’ll check what object `p` is pointing to _when we run the program_.”
    

That’s called **runtime (dynamic) dispatch**.

----------

## 🧩 6. The Mechanism Behind Virtual — `vtable` and `vptr`

### 🧱 vtable (Virtual Table)

Each class that has virtual functions gets its own **vtable**.  
This is a hidden list of **function addresses** for that class.

Example (conceptually, in C++):

|  Class | vtable entries |
|:------:|:--------------:|
| Parent | Parent::show   |
| Child  | Child::show    |

### ⚙️ vptr (Virtual Pointer)

Every object of a class with virtual functions has a hidden pointer called **vptr**.  
This `vptr` points to the vtable of its class.
```
Parent object:
  vptr ──► Parent vtable

Child object:
  vptr ──► Child vtable
  ``` 

### 🔍 What Happens at Runtime

When you call a virtual function:

`p->show();` 

The compiler-generated code does:

1.  Look inside the object `p` points to.
    
2.  Follow its **vptr** to its **vtable**.
    
3.  Find the function address for `show()`.
    
4.  Jump to that address.
    

If `p` actually points to a **Child object**, its vptr points to the **Child’s vtable**,  
so **Child::show()** runs — even though `p` is a Parent handle.

----------

## 🧭 7. Visual Analogy — The Reception Desk

Imagine:

-   Each class has a **reception desk** (vtable) with directions to its own rooms (functions).
    
-   Every object carries a **map** (vptr) to its class’s reception desk.
    

When someone says “Call `show()`,”

-   The object goes to its own reception desk,
    
-   Looks up “show”,
    
-   Finds which room to go to (Parent or Child version),
    
-   Executes that version.
    

So:

> **Without `virtual`** → everyone has a fixed room number (compile-time binding).  
> **With `virtual`** → you ask the reception desk every time (runtime lookup).

----------

## 💻 8. C++ Comparison (Same Mechanism)

C++ and SystemVerilog use the same concept:

```
class  Parent { public: virtual  void  show() { cout << "Parent\n"; }
}; class  Child : public Parent { public: void  show()  override { cout << "Child\n"; }
}; int  main() {
    Parent* p = new  Child();
    p->show(); // Output: Child }
``` 

-   `virtual` triggers creation of a **vtable**.
    
-   Each object stores a **vptr** to its class’s vtable.
    
-   Function call resolved using vtable at runtime.
    

----------

## 🔬 9. Why We Need Polymorphism

Polymorphism gives **flexibility and reusability**.

For example, in verification (UVM or OOP testbenches):

```
class Packet;
  virtual function void send(); $display("Generic packet"); endfunction
endclass

class EthernetPacket extends Packet;
  function void send(); $display("Ethernet packet"); endfunction
endclass

class WifiPacket extends Packet;
  function void send(); $display("WiFi packet"); endfunction
endclass

module tb;
  Packet pkt_list[$];
  initial begin
    pkt_list.push_back(new EthernetPacket());
    pkt_list.push_back(new WifiPacket());

    foreach(pkt_list[i])
      pkt_list[i].send();
  end
endmodule
``` 

Output:

`Ethernet packet WiFi packet` 

👉 Even though `pkt_list` is an array of `Packet` (parent handles),  
each packet behaves according to its **actual type** at runtime — thanks to virtual functions.

----------

## 🧠 10. Key Takeaways

 |            Concept           |                              Description                              |
|:----------------------------:|:---------------------------------------------------------------------:|
| Polymorphism                 | One interface, many behaviors — same call, different results.         |
| Parent handle → Child object | Needed for runtime polymorphism.                                      |
| Compile time                 | Code is checked and prepared. Function calls fixed unless virtual.    |
| Runtime                      | Code actually executes; virtual calls resolved based on real object.  |
| Static binding               | Function chosen at compile time (no virtual).                         |
| Dynamic binding              | Function chosen at runtime (with virtual).                            |
| vtable                       | Table storing addresses of virtual functions for each class.          |
| vptr                         | Hidden pointer in each object pointing to its class’s vtable.         |
| Virtual function             | Function whose behavior is decided at runtime, enabling polymorphism. |

----------

## 🪞 11. In Simple Words

-   `virtual` = “decide later at runtime.”
    
-   Normal = “decide now at compile time.”
    
-   vtable = “a lookup table for virtual functions.”
    
-   vptr = “a pointer in each object that points to its vtable.”
    
-   Polymorphism = “Parent handle → Child behavior.”
    

----------

## 🌟 12. Summary Quote

> **Without `virtual`:** the compiler knows exactly which function to call (fast, static).  
> **With `virtual`:** the program waits until it sees the real object, then calls the correct version (flexible, dynamic).
> 
> `virtual` simply tells the compiler:  
> “Don’t decide now — decide when you know who’s actually calling.”