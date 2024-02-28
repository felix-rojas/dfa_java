# dfa_java
A dfa programmed in prolog that identifies any valid java 
variable name.

## Rules
- Can contain letters, digits, underscores, and dollar signs
- Must begin with a letter, '$' or  '_'
- Cannot contain whitespace
- Cannot contain special characters besides underscores, and dollar signs

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
- '$' at the beginning. 

### $q_4$
- **Valid state**. 
- This state is reached when there is a number in the variable name. 

## Diagram

- Q0 represents the initial state
- Accepting states are defined in blue outline (Q1 and Q4)
- Letter represents any alphabetic character, regardless of capitalization
- Digit represents any digit

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

```mermaid
graph LR
    Q0((Q0)) --Letter--> Q1((Q1))
    Q1 --Letter--> Q1
    Q0 --'_'--> Q2((Q2))
    Q1 --'_'--> Q2
    Q2 --'_'--> Q2
    Q2 --Letter--> Q1
    Q1 --Digit--> Q4((Q4))
    Q4 --Digit--> Q4
    Q0 --'$'--> Q3((Q3))
    Q3--'$'--> Q3
    Q3--Letter--> Q1
    Q4 --Letter--> Q1
    style Q0 fill:#f9fff,stroke:#ffff,stroke-width:3px
    style Q1 fill:#f9fff,stroke:#333fff,stroke-width:3px
    style Q3 fill:#f9fff,stroke:#333fff,stroke-width:3px
    style Q4 fill:#f9fff,stroke:#333fff,stroke-width:3px
```
