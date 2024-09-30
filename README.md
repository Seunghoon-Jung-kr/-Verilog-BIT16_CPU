# Overview

"This is a personal project where I designed a 16-bit CPU with a set of 25 instructions introduced in M. Morris Mano's book, Computer System Architecture, using Verilog."

# Purpose of this project

"I created this project to deepen my understanding of computer architecture, digital logic circuits, and Verilog HDL."

# More Detail

"I wanted to try both behavioral and dataflow modeling in Verilog, so I applied behavioral modeling to large-scale modules like the system bus, while using dataflow modeling for smaller modules like register modules, where I derived Boolean functions from block diagrams, truth tables, and Karnaugh maps."

# Design objective

"My objective was to design a low-power CPU capable of executing the given instruction set using the von Neumann architecture. To achieve this, I implemented partial power gating in the ALU circuit and the increment circuit within the registers. And I primarily focused on implementing the CPU. Furthermore, I designed it under the assumption that the main memory would use IP, so the RAM.v file in the code list is intended only for simulation purposes. And apart from that I designed all arithmetic logic circuits using a carry lookahead adder." 

# Design method

"I basically used a top-down design methodology, employing elements like the control unit, registers, multiplexers, and the ALU, while also incorporating a partial bottom-up approach by designing each component starting from the smallest elements. Additionally, while designing some registers, I created circuit diagrams on paper and translated them into dataflow modeling, which may make the code feel somewhat less user-friendly. I uploaded a image for reference."

<img src="https://github.com/user-attachments/assets/d5d7f946-ae57-4e06-8882-0bf28e0757af" alt="CamScanner 2024-09-30 16 36 (1)" width="350"/>

# IDE

"I designed it using Vivado."

# In order, Verilog Code & RTL-level diagram of the circuit & the diagram of the synthesized circuit

![image](https://github.com/user-attachments/assets/81c7306e-1d24-44b5-8854-df2be174ad28)
![image](https://github.com/user-attachments/assets/a947bd46-24ea-43c7-8db7-5a7becb065ad)
![sSYNchematic-1](https://github.com/user-attachments/assets/e1714634-a28e-45f2-8952-4c039e01f08b)




