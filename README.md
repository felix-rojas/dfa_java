# dfa_java
A dfa programmed in prolog that identifies any valid java 
variable name.

## Rules
- Can contain letters, digits, underscores, and dollar signs
- Must begin with a letter, '$' or  '_'
- Cannot contain whitespace
- Cannot contain special characters besides underscores, and dollar signs
- Cannot be a single underscore
- Cannot start with a digit
- Cannot be a reserved keyword

## States

This DFA has the following states:

### $q_0$ 
- Initial state. 
- No inputs have been made and thus, it is not a valid state.

### $q_1$ 
- **Valid state** where the variable has a name, such as 'a' or 'A'. Any number of inputs of alphabetic characters will loop this state.

### $q_2$
- '_' at the beginning. 

### $q_3$ 
- **Valid state**. 
- '$' at the beginning.
- Java allows '$' as a valid identifier on its own. 

### $q_4$
- **Valid state**. 
- This state is reached when there is a number in the variable name. 


### $q_5$
- **Valid state**. 
- Java allows '__' as a valid identifier on its own.
- This state is necessary to differentiate when there is a single underscore at the beginning or multiple ones. 

## Regex 
`^(?!_$)[a-zA-Z$_][a-zA-Z\d_$]*$`
### Breakdown
- `^(?!_$)` means to make sure that the first position "^", by looking ahead "?" that there is NOT "!" a single "_" that simply ends "$".
- `[a-zA-Z$_]` means any character in the range of a-z or A-Z or "$" or "_".
- `[a-zA-Z\d$_]*` means any character mentioned previously or any digit "\d" or "$" or "_". The asterisk (star operator) means there can be from 0 to any number of the characters stated in the group enclosed by brackets.
- Finally the $ just means this is the end of the string.

### Examples of valid identifiers
```
$astrid
$$aa
a$A$a$_
A$a
$as1111
$____$$$$
$$$as$$
$_
$
a_
_a
_9
_$
__
```

### DFA chart

- Q0 represents the initial state
- Accepting states are defined in thick blue outline:
  - Q1, Q3, Q4, Q5
- Letter represents any alphabetic character, regardless of capitalization

```mermaid
%%{init: {"flowchart": {"curve": "cardinal"}, {"htmlLabels": false}}}%%

graph LR
    Q0(("`*q_0*`"))
    Q1(("`*q_1*`"))
    Q2(("`*q_2*`"))
    Q3(("`*q_3*`"))
    Q4(("`*q_4*`"))
    Q5(("`*q_5*`"))
    
    Q0 -. Letter .-> Q1
    Q0 -.'_'.-> Q2
    Q0 -.'$'.-> Q3
    Q1 -.Letter.-> Q1
    Q1 -.'$'.-> Q3
    Q1 -.Digit.-> Q4
    Q1 -.'_'.-> Q5
    Q2 -.Letter.-> Q1
    Q2 -.'$'.-> Q3
    Q2 -.Digit.-> Q4
    Q2 -.'_'.-> Q5
    Q3 -.Letter.-> Q1
    Q3 -.'$'.-> Q3
    Q3 -.Digit.-> Q4
    Q3 -.'_'.-> Q5
    Q4 -.Letter.-> Q1
    Q4 -.'_'.-> Q2
    Q4 -.Digit.-> Q4
    Q5 -.Letter.-> Q1
    Q5 -.'$'.-> Q3
    Q5 -.Digit.-> Q4
    Q5 -.'_'.-> Q5
    
    style Q0 fill:#f9fff,stroke:#ffff,stroke-width:3px
    style Q1 fill:#f9fff,stroke:#2DFE54,stroke-width:3px
    style Q3 fill:#f9fff,stroke:#2DFE54,stroke-width:3px
    style Q4 fill:#f9fff,stroke:#2DFE54,stroke-width:3px
    style Q5 fill:#f9fff,stroke:#2DFE54,stroke-width:3px
    
    linkStyle 0,1,2 stroke:blue,stroke-width:2px;
    linkStyle 3,4,5,6 stroke:green,stroke-width:2px;
    linkStyle 7,8,9,10 stroke:yellow,stroke-width:2px;
    linkStyle 11,12,13,14 stroke:magenta,stroke-width:2px;
    linkStyle 15,16,17 stroke:white,stroke-width:2px;
    linkStyle 18,19,20,21 stroke:red,stroke-width:2px;
```