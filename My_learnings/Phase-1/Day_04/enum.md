
## 🧩 1. What is an `enum`?

**Enum** (short for _enumeration_) is a **user-defined data type** that lets you assign **names to numeric values**, making code more readable and less error-prone.

Think of it as labeling numbers with meaningful names.

----------

## 🧠 2. Basic Syntax

`enum {name1, name2, name3, ...} enum_variable;` 

By default:

-   The first name gets value `0`.
    
-   The next gets `1`, and so on.
    

----------

### Example:

`enum {RED, GREEN, BLUE} color;` 

This means:

-   `RED = 0`
    
-   `GREEN = 1`
    
-   `BLUE = 2`
    

Usage:

```
color = GREEN;

if (color == BLUE)
  $display("It's blue!");
else
  $display("Not blue!");
``` 

----------

## ⚙️ 3. Explicit Values

You can assign custom integer values:

`enum {IDLE = 2, RUN = 5, STOP = 8} state;` 

Then:

-   `IDLE = 2`
    
-   `RUN = 5`
    
-   `STOP = 8`
    

The next unassigned element (if any) continues from the last assigned +1.

----------




## ⚙️ 4. Accessing Enum Members (dot `::` scope operator)

If you used a **named enum type**, you can access its members using **scope resolution `::`**.

Example with a typedef (this is the recommended style):

```
typedef enum {RED, GREEN, BLUE} color_t;
color_t c1, c2;
``` 

Now you can access members as:

```
c1 = color_t::RED;     // Assign RED to variable c1
c2 = color_t::BLUE;    // Assign BLUE to variable c2
``` 

✅ `color_t` is the **enum type name**  
✅ `::RED` is the **member of that enum type**

----------

## 🧠 5. Accessing Enum Methods

Enum **methods** (like `.first()`, `.next()`, `.name()`) can be used in **two ways**:

### (A) Using the variable itself

When you call it through a variable (e.g., `color.first()`),  
the method acts on that enum type.

```
typedef enum {RED, GREEN, BLUE} color_t;
color_t color;

initial begin
  color = color.first();    // Assigns RED (the first member)
  $display("Color: %s", color.name()); // prints "RED"

  color = color.next(color);  // Move to next → GREEN
  $display("Next: %s", color.name());
end
``` 

Here, `color` is both:

-   the **variable**, and
    
-   the **type reference** (because SystemVerilog allows that if type name isn’t explicit).
    

That’s why you often see code like `color.first()` — it works fine.

----------

### (B) Using the type name (recommended, more readable)

You can also use the **enum type name** instead of the variable name — this is often clearer.

```
typedef enum {RED, GREEN, BLUE} color_t;
color_t c1, c2;

initial begin
  c1 = color_t::first();     // RED
  c2 = color_t::next(c1);    // next of RED → GREEN
  $display("c1=%s, c2=%s", c1.name(), c2.name());
end
``` 

✅ Here `color_t` is the **type**, not the variable  
✅ Works even if you have multiple variables of that enum type

`enum logic [2:0] {RED, GREEN, BLUE} color;` 

Now `color` is stored as a **3-bit logic vector**.


## 🔍 6. Summary of Enum Methods

|  Method  |                 Description                |               Example               |   Returns  |
|:--------:|:------------------------------------------:|:-----------------------------------:|:----------:|
| .first() | First member in enum                       | color_t::first() → RED              | enum value |
| .last()  | Last member                                | color_t::last() → BLUE              | enum value |
| .next(x) | Next member after x (wraps around if last) | color_t::next(color_t::RED) → GREEN | enum value |
| .prev(x) | Previous member before x (wraps if first)  | color_t::prev(color_t::GREEN) → RED | enum value |
| .num()   | Number of members                          | color_t::num() → 3                  | integer    |
| .name()  | String name of current value               | c1.name() → "RED"                   | string     |