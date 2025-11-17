
### 🧩 1. **Copy Assignment**

When you do something like this:

`a = b;` 

it’s called **copy assignment** — you’re copying **values** from `b` into `a`.

✅ For **simple data types** (int, logic, etc.), this just copies the number.

✅ For **structs or classes**, it depends on whether it’s a **value type** or **class handle**.

----------

### 🧮 2. **Shallow Copy**

> Only copies the **handle (reference)**, not the actual object.

for shallow copy, we simply **assign** the handles:

`obj2 = obj1;` 

Both `obj1` and `obj2` now **point to the same object** in memory.  
No new object is created.
```
class Box;
  int size;
endclass

Box a = new();
a.size = 10;

Box b = a; // shallow copy
b.size = 20;

$display("a.size = %0d", a.size); // shows 20 — both refer to same object!
``` 

🧠 Both `a` and `b` point to the **same memory location**, so changing one affects the other.

----------

### 🧊 3. **Deep Copy**

> Creates a **new object** and copies the **data inside** separately.

You have to do this **manually** in SystemVerilog:
```
class Box;
  int size;

  function Box copy();
    Box temp = new();
    temp.size = this.size;
    return temp;
  endfunction
endclass

Box a = new();
a.size = 10;

Box b = a.copy(); // deep copy
b.size = 20;

$display("a.size = %0d", a.size); // shows 10 — independent copy
```
🧠 a and b are two separate objects now.

Usually — in SystemVerilog, there is **no automatic deep copy** for class objects.  
So you typically write a **custom `copy()` function** inside your class.

You can name it anything (`clone()`, `copy()`, etc.), but it’s conventionally `copy()`.

**Reason: **
SystemVerilog doesn’t know how _you_ want to copy — your class may contain other class handles, arrays, or complex data — so you define it manually.

### 🧠 3. How `this` Works in SystemVerilog

`this` in SystemVerilog behaves almost exactly like `this` in C++:

-   It refers to the **current object** (the one calling the function).
    
-   You use it to access that object’s variables.
    

So when you write:

`temp.size = this.size;` 

you’re saying:

> “Take the `size` value from **this** current object (the source) and copy it into `temp` (the new object).”

----------

### 🧩 4. Why `this` Appears on the **Right Side**

In **C++ copy constructors** you often see:

`this->a = other.a;` 

(because you’re inside the destination object, assigning from another object)

But in **SystemVerilog**, in a `copy()` function like this:

```
function Box copy();
  Box temp = new();
  temp.size = this.size;
  return temp;
endfunction
``` 

you’re writing the function **inside the source object**, not the destination.

That means:

-   `this` = current object (source)
    
-   `temp` = new object (destination)
    

Hence:  
👉 `temp.size = this.size;`  
and not the other way around.

----------

### 🧾 5. Visual Example

```
Box a = new();
a.size = 10;

Box b = a.copy(); // deep copy

// Internally does:
b.size = a.size;
``` 

→ `b` becomes a new object with same data, but not same reference.

### 🧩 What “Source” and “Destination” Mean

When you make a **copy**, there are two objects involved:

|     Role    |                       Meaning                       |       Example      |
|:-----------:|:---------------------------------------------------:|:------------------:|
| Source      | The original object — the one that already has data | a in b = a.copy(); |
| Destination | The new object — the one receiving the data         | b in b = a.copy(); |

