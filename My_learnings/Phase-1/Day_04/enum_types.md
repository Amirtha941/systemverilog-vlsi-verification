
## 🧩 1️⃣ “Type” vs “Variable” — Basic Idea

Let’s start with something you already know.

### In simple SystemVerilog:

`int a;` 

-   `int` → **data type**
    
-   `a` → **variable name**
    

👉 So this means:

> “Make a variable `a` which is of type integer.”

Now you can also say:

`real b;` 

Here:

-   `real` → data type
    
-   `b` → variable
    

So far, okay?

----------

## 🧠 2️⃣ Enum is _also_ a Data Type

When you write:

`enum {IDLE, RUN, STOP} state1;` 

This means:

-   `enum {IDLE, RUN, STOP}` → is the **data type**
    
-   `state1` → is the **variable**
    

So you just created a **variable** named `state1`,  
whose **data type** is an **enum type** (with members IDLE, RUN, STOP).

✅ Just like `int a;`  
✅ But here, the type is more descriptive.

----------

## 🕵️‍♀️ 3️⃣ What’s the “Type Name”?

Here’s the key:

> You can give that data type (the enum) a **name** using `typedef`.

That “name” becomes a label for the type, so you can reuse it later.

----------

### Example — Giving the Enum Type a Name

`typedef enum {IDLE, RUN, STOP} state_t;` 

Now what happened?

-   `enum {IDLE, RUN, STOP}` → defines a **new type**
    
-   `state_t` → is the **name** of that type (the “type name”)
    

Now you can make many variables of this type:

`state_t current_state, next_state;` 

✅ `state_t` is the **type name**  
✅ `current_state` and `next_state` are **variables**  
✅ both are of type `state_t`


## 🧩 1️⃣ What is a _named_ vs _anonymous_ enum?

When you write an enum, you can optionally **give it a name (type name)**.  
If you **don’t give it a name**, it’s called an **anonymous enum**.

----------

### 🟢 Example 1 — Anonymous Enum

`enum {RED, GREEN, BLUE} color;` 

Here:

-   `{RED, GREEN, BLUE}` → the **list of enumeration members**
    
-   `color` → a **variable** that can take one of those values
    
-   but the **enum type** itself has **no name**
    

So you can’t refer to this enum type anywhere else — only the variable `color` knows it.

That’s why it’s called **anonymous** — “it has no name”.

----------

### 🔵 Example 2 — Named Enum (using `typedef`)

```
typedef enum {RED, GREEN, BLUE} color_t;
color_t c1, c2;
``` 

Now:

-   The **enum type name** is `color_t`
    
-   You can declare **many variables** of this type (`c1`, `c2`, etc.)
    
-   You can **refer to its members** using the type name → `color_t::RED`
    

✅ Reusable  
✅ Clean  
✅ Type-safe  
✅ Recommended in almost all professional SystemVerilog code

----------

## 🧠 2️⃣ Why It Matters

If you use **anonymous enums**, you’re creating a one-time enum type.

Example:

```
enum {IDLE, RUN, STOP} state1;
enum {IDLE, RUN, STOP} state2;
``` 

Even though both look identical, **SystemVerilog treats them as two different, unrelated types**.  
You can’t directly assign `state1 = state2;` — it will give a **type mismatch** warning.

But if you use **named typedef enums**:

```
typedef enum {IDLE, RUN, STOP} state_t;
state_t state1, state2;

state1 = state_t::RUN;
state2 = state1;   // ✅ perfectly fine
``` 

Now both variables belong to the same enum **type** `state_t`.

