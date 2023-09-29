
# Principles of Programming Languages and Compilers Project @CEID

This project focuses on the development of a compiler and parser for a pseudo-language using Bison and Flex tools. The primary objectives of this project are to create a syntactic definition of the language's grammar using Backus-Naur Form (BNF) and utilize the Flex and Bison programs to develop a dictionary and parser for the pseudo-language. 

The parser should perform a one-pass syntactic analysis of the input program to determine whether it adheres to the defined grammar rules.

Extend the parser to recognize and process data that may be returned from two different sources:

- Data returned from the pseudo-language described above.

- Data retrieved from the URL: https://api.opap.gr/draws/v3.0/5104/draw-date/{fromDate}/{toDate}.

## Deployment

To deploy this project run

```bash
  ./a.out test.txt 
```

where `test.txt` is the file that gets parsed.
## Screenshots
*Successful File Validation*
![App Screenshot](https://github.com/manosmin/ceid-yacc/tree/master/screenshots/valid.png)
*Unsuccessful File Validation*
![App Screenshot](https://github.com/manosmin/ceid-yacc/tree/master/screenshots/invalid.png)

