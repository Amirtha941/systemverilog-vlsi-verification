
## ⚙️ **How it Works**

### 1️⃣ Clock generation

-   `clk` toggles every 5 ns → one full cycle = 10 ns.
    
-   So:
    
    -   0 ns → clk = 0
        
    -   5 ns → clk = 1
        
    -   10 ns → clk = 0
        
    -   15 ns → clk = 1
        
    -   20 ns → clk = 0  
        … and so on.
        

So the **clock period = 10 ns**, **frequency = 100 MHz**.

----------

### 2️⃣ Counter logic

-   The counter increments **on every positive edge** of the clock (`posedge clk`).
-   
| Time (ns) |   Clock   |    Event   | Count Value |
|:---------:|:---------:|:----------:|:-----------:|
| 0         | 0         | Initial    | 0           |
| 5         | ↑ posedge | count = 1  | 1           |
| 15        | ↑ posedge | count = 2  | 2           |
| 25        | ↑ posedge | count = 3  | 3           |
| 35        | ↑ posedge | count = 4  | 4           |
| 45        | ↑ posedge | count = 5  | 5           |
| …         | …         | …          | …           |
| 95        | ↑ posedge | count = 10 | 10          |

   
-   Starts at `count = 0`.
    
-   Every 10 ns, it increases by 1.

### Output waveform:

![Waveform](../Images/counter_waveform.png)

