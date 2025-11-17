## 🧠 What’s an Array?

An **array** in SystemVerilog is just a **collection of elements of the same data type** (like integers, bits, or logic values) that are stored together under one name.

Example 👇

`int my_array[5]; // 5 integers stored together: index 0 to 4` 

----------

## 🔹 1. Types of Arrays in SystemVerilog

SystemVerilog supports **4 major types** of arrays:

## 🧠 What’s an Array?

An **array** in SystemVerilog is just a **collection of elements of the same data type** (like integers, bits, or logic values) that are stored together under one name.

Example 👇

`int my_array[5]; // 5 integers stored together: index 0 to 4` 

----------

## 🔹 1. Types of Arrays in SystemVerilog

SystemVerilog supports **4 major types** of arrays:

|        Type        |             Definition             |           When to use          |
|:------------------:|:----------------------------------:|:------------------------------:|
| Fixed-size arrays  | Size known at compile time         | When size never changes        |
| Dynamic arrays     | Size decided at runtime            | When size can vary             |
| Associative arrays | Indexed by keys (not numbers only) | For sparse or lookup-like data |
| Queues             | Ordered list that grows/shrinks    | For FIFO-type storage          |


## 🔸 1. Fixed-size (Static) Arrays

✅ Declared with constant size.  
Example:

`int a[5];  // fixed array with 5 elements: a[0]...a[4]` 

You can initialize it:

`int b[3] = '{1, 2, 3};` 

You can loop through it:

`foreach (b[i])
  $display("b[%0d] = %0d", i, b[i]);` 

----------

## 🔸 2. Dynamic Arrays

✅ Declared without a size — you allocate memory later.

Example:

`int dyn_array[];
dyn_array = new[5]; // allocate space for 5 ints` 

You can resize later:

`dyn_array = new[10](dyn_array); // keep old contents, extend to 10` 

Delete it when done:

`dyn_array.delete();` 

----------

## 🔸 3. Associative Arrays

✅ Indexed by **any key type** (like integer, string, etc.)

Example 1 (integer key):

```
int assoc[int];
assoc[10] = 100;
assoc[25] = 200;
``` 

Example 2 (string key):

```
int marks[string];
marks["Amirtha"] = 95;
marks["Dhoni"] = 88;
``` 

Check if key exists:

```
if (marks.exists("Amirtha"))
  $display("Found!");
  ``` 

Delete:

`marks.delete("Dhoni");` 

----------

## 🔸 4. Queues

✅ Like a dynamic array but behaves like a **list or FIFO**.  
You can push and pop elements.

Example:

```
int q[$]; // queue of ints

q.push_back(10);
q.push_back(20);
q.push_front(5);

$display("%p", q); // {5,10,20}

int x = q.pop_front(); // removes 5
int y = q.pop_back();  // removes 20
``` 

Queues are great for **simulation buffers, transactions, or packet lists**.

----------

## 🧩 Multidimensional Arrays

You can have **2D or 3D** arrays too.

Example:

```
int mat[3][3] = '{ '{1,2,3}, '{4,5,6}, '{7,8,9} };

foreach (mat[i, j])
  $display("mat[%0d][%0d] = %0d", i, j, mat[i][j]);
  ```


# 🧩: Why we use the **apostrophe (`'`)** in arrays

In SystemVerilog, the **apostrophe (`'`)** is part of **aggregate literals** — it tells the compiler _“I’m giving you a whole set of values for an array or structure.”_

So, when you write something like:

`int a[3] = '{1, 2, 3};` 

It means:

> “Assign this **array** with elements 1, 2, and 3 as a group.”

----------

## ✅ Why `'` is necessary

Let’s say you write:

`int a[3] = {1, 2, 3}; // ❌ WRONG in SystemVerilog` 

That gives an error — because `{}` without `'` means **concatenation**, not array initialization.

SystemVerilog uses:

-   `{}` → Concatenation (joins bits)
    
-   `'{}` → Array or structure initialization
    

✅ Correct usage:

```
int a[3] = '{1, 2, 3};   // array initialization
bit [5:0] b = {a, 2'b10}; // concatenation (joins bits)
``` 

----------

## 🎯 When you **must** use `'{}`

1.  When initializing arrays or structures.
    
2.  When assigning all elements at once.
    
3.  When you use the **default initialization**:
    
    `int arr[5] = '{default: 0}; // all elements = 0` 
    

## When you **don’t** use `'{}`

1.  When assigning a single element:
    
    `arr[0] = 5;  // no need for '{}` 
    
2.  When using concatenation:
    
    `{a, b, c} // bit concatenation`
