@echo off

:do_while
echo Creando el archivo lex.yy.c.
F:\GnuWin32\bin\flex ./Lexico.l
pause
echo Creando el archivo de byson.
F:\GnuWin32\bin\bison -dyv ./Sintactico.y
pause
echo Creando el ejecutable ...
F:\MinGW\bin\gcc.exe  ./lib/lista_ts.c ./lib/pila.c ./lib/lexico.c ./lib/semantico.c ./lib/gci.c ./lex.yy.c ./y.tab.c -o ./Primera.exe
pause
cls
echo Ejecutando el Analizador Lexicografico
echo RESULTADOS:
echo -----------------------------------------------------------------
Primera.exe ./prueba.txt
echo.
echo -----------------------------------------------------------------
pause
del lex.yy.c
del Primera.exe
del y.output
del y.tab.c
del y.tab.h
cls
set /p seguir=Desea seguir con el programa? [s/n]
if "%seguir%"=="s" goto do_while