%{
#include "./include/cabecera.h"
%}

				/* LISTA DE TOKENS */
/* PALABRAS RESERVADAS */
%token	WHILE
%token	IF
%token	ELSE
%token	PUT
%token	GET
%token	DIM
%token	AS
%token	CONTAR
%token	INTEGER
%token	FLOAT
%token	STRING

/* SIGNOS PUNTUACION Y OTROS */
%token	LLAVE_ABIERTO
%token	LLAVE_CERRADO
%token	PAR_ABIERTO
%token	PAR_CERRADO
%token	COR_ABIERTO
%token	COR_CERRADO
%token	PUNTO_COMA
%token	COMA

/* OPERADORES */
%token	OP_ASIGNACION
%token	OP_SUMA
%token	OP_RESTA
%token	OP_DIVISION
%token	OP_MULT
%token	OP_LE
%token	OP_LEQ
%token	OP_GE
%token	OP_GEQ
%token	OP_NE
%token	OP_IGUAL
%token	OP_AND
%token	OP_OR
%token	OP_NOT

/* CONSTANTES */
%token	CONST_ENTERA
%token	CONST_REAL
%token	CONST_STRING
%token	CONST_BINARIA
%token	CONST_HEXA

/* VARIABLES */
%token	ID

/* ______________________________________________________________ */

/* DECLARACION DE REGLAS SINTACTICAS */
%%

programa	: bloque 					{printf("Regla: <programa> -> <bloque> --- COMPILACION EXITOSA\n");}
		;

bloque		: sentencia bloque 			{printf("Regla: <bloque> -> <sentencia> <bloque>\n");}
		| sentencia 					{printf("Regla: <bloque> -> <sentencia>\n");}
		;

sentencia	: asignacion PUNTO_COMA 	{printf("Regla: <sentencia> -> <asignacion> PUNTO_COMA\n");}
			| declaracion PUNTO_COMA	{printf("Regla: <sentencia> -> <declaracion> PUNTO_COMA\n");} 
			| salida PUNTO_COMA 		{printf("Regla: <sentencia> -> <salida> PUNTO_COMA\n");} 
			| entrada PUNTO_COMA 		{printf("Regla: <sentencia> -> <entrada> PUNTO_COMA\n");}
			| bloqueWhile				{printf("Regla: <sentencia> -> <bloque_while>\n");}
			| bloqueIf					{printf("Regla: <sentencia> -> <bloque_if>\n");}
		;

/* REGLAS PARA LA ASIGNACION */
asignacion	: ID OP_ASIGNACION cuenta 	{printf("Regla: <asignacion> -> ID OP_ASIGNACION <cuenta>\n");}
		;

cuenta		: termino OP_SUMA cuenta 	{printf("Regla: <cuenta> -> <termino> OP_SUMA <cuenta>\n");}
		| termino OP_RESTA cuenta		{printf("Regla: <cuenta> -> <termino> OP_RESTA <cuenta>\n");}
		| termino						{printf("Regla: <cuenta> -> <termino>\n");}
		;

termino		: factor OP_MULT termino	{printf("Regla: <termino> -> <factor> OP_MULT <termino>\n");}
		| factor OP_DIVISION termino	{printf("Regla: <termino> -> <factor> OP_DIVISION <termino>\n");}
		| factor 						{printf("Regla: <termino> -> <factor>\n");}						
		;

factor		: PAR_ABIERTO cuenta PAR_CERRADO	{printf("Regla: <factor> -> PAR_ABIERTO <cuenta> PAR_CERRADO\n");}
		| ID 							{printf("Regla: <factor> -> ID\n");}
		| constante					{printf("Regla: <factor> -> <constante>\n");}
		| funcionContar					{printf("Regla: <factor> -> <funcion_contar>\n");}
		;
		
/* REGLAS PARA LA DECLARACION DE VARIABLES */

declaracion	: DIM listaVariables AS listaTipos {printf("Regla: <declaracion> -> DIM <lista_variables> AS <lista_tipos>\n");}
		;

listaVariables	: OP_LE variables OP_GE	{printf("Regla: <lista_variables> -> OP_LE <variables> OP_GE\n");}
		;

variables	: ID COMA variables			{printf("Regla: <variables> -> ID COMA <variables>\n");}
		| ID							{printf("Regla: <variables> -> ID\n");}
		;

listaTipos	: OP_LE tipos OP_GE			{printf("Regla: <lista_tipos> -> OP_LE <tipos> OP_GE\n");}
		;

tipos		: tipoDeDato COMA tipos		{printf("Regla: <tipos> -> <tipo_dato> COMA <tipos>\n");}
		|tipoDeDato						{printf("Regla: <tipos> -> <tipo_dato>\n");}
		;

tipoDeDato	: FLOAT						{printf("Regla: <tipo_dato> -> FLOAT\n");}
		| INTEGER						{printf("Regla: <tipo_dato> -> INTEGER\n");}
		| STRING						{printf("Regla: <tipo_dato> -> STRING\n");}
		;
		
/* REGLAS PARA PUT Y GET */

salida		: PUT ID					{printf("Regla: <salida> -> PUT ID\n");}
		| PUT CONST_STRING				{printf("Regla: <salida> -> PUT CONST_STRING\n");}
		;

entrada		: GET ID					{printf("Regla: <entrada> -> GET ID\n");}
		;

/* REGLAS PARA LA DECLARACION DE WHILE E IF */

bloqueWhile	: WHILE PAR_ABIERTO condicion PAR_CERRADO LLAVE_ABIERTO bloque LLAVE_CERRADO	{printf("Regla: <bloque_while> -> WHILE PAR_ABIERTO <condicion> PAR_CERRADO LLAVE_ABIERTO <bloque> LLAVE_CERRADO\n");}
		| WHILE PAR_ABIERTO condicion PAR_CERRADO sentencia		{printf("Regla: <bloque_while> -> WHILE <condicion> <sentencia>\n");}
		;
/* TOMAMOS NADA MÁS QUE TENGAN QUE IR ENTRE LLAVES EXCEPTO EL IF DE UNA SOLA LÍNEA*/
bloqueIf	: IF PAR_ABIERTO condicion PAR_CERRADO LLAVE_ABIERTO bloque LLAVE_CERRADO ELSE LLAVE_ABIERTO bloque LLAVE_CERRADO {printf("Regla: <bloque_if> -> IF PAR_ABIERTO <condicion> PAR_CERRADO LLAVE_ABIERTO <bloque> LLAVE_CERRADO ELSE LLAVE_ABIERTO <bloque> LLAVE_CERRADO\n");}
			| IF PAR_ABIERTO condicion PAR_CERRADO sentencia {printf("Regla: <bloque_if> -> IF PAR_ABIERTO <condicion> PAR_CERRADO <sentencia>\n");}
			| IF PAR_ABIERTO condicion PAR_CERRADO LLAVE_ABIERTO bloque LLAVE_CERRADO {printf("Regla: <bloque_if> -> IF PAR_ABIERTO <condicion> PAR_CERRADO LLAVE_ABIERTO <bloque> LLAVE_CERRADO\n");}
			;
		
condicion	: expLogica OP_AND expLogica {printf("Regla: <condicion> -> <exp_logica> OP_AND <exp_logica>\n");}
		| expLogica OP_OR expLogica		{printf("Regla: <condicion> -> <exp_logica> OP_OR <exp_logica>\n");}
		| OP_NOT expLogica				{printf("Regla: <condicion> -> OP_NOT <exp_logica>\n");}
		| expLogica						{printf("Regla: <condicion> -> <exp_logica>\n");}
		;

expLogica	: PAR_ABIERTO condicion PAR_CERRADO	{printf("Regla: <exp_logica> -> PAR_ABIERTO <condicion> PAR_CERRADO\n");}
		| cuenta comparador cuenta		{printf("Regla: <exp_logica> -> <cuenta> <comparador> <cuenta>\n");}
		;

comparador	: OP_IGUAL					{printf("Regla: <comparador> -> OP_IGUAL\n");}
		| OP_LE							{printf("Regla: <comparador> -> OP_LE\n");}
		| OP_LEQ						{printf("Regla: <comparador> -> OP_LEQ\n");}
		| OP_GE							{printf("Regla: <comparador> -> OP_GE\n");}
		| OP_GEQ						{printf("Regla: <comparador> -> OP_GEQ\n");}
		| OP_NE							{printf("Regla: <comparador> -> OP_NE\n");}
		;
/* REGLAS PARA CONTAR */

funcionContar	: CONTAR PAR_ABIERTO cuenta PUNTO_COMA listaConstantes PAR_CERRADO	{printf("Regla: <funcion_contar> -> CONTAR PAR_ABIERTO <cuenta> PUNTO_COMA <lista_constantes> PAR_CERRADO\n");}
		;

listaConstantes	: COR_ABIERTO constantes COR_CERRADO 	{printf("Regla: <lista_constantes> -> COR_ABIERTO <constantes> COR_CERRADO\n");}
		;

constantes	: constante COMA constantes		{printf("Regla: <constantes> -> <constante> COMA <constantes>\n");}
		| constante						{printf("Regla: <constantes> -> <constante>\n");}
		;

constante : CONST_BINARIA					{printf("Regla: <constante> -> CONST_BINARIA\n");}
		| CONST_HEXA					{printf("Regla: <constante> -> CONST_HEXA\n");}
		| CONST_REAL					{printf("Regla: <constante> -> CONST_REAL\n");}
		| CONST_ENTERA 					{printf("Regla: <constante> -> CONST_ENTERA\n");}
		;
%%

int main(int argc, char *argv[]) 
{
	FILE *pf = NULL;
	yyin = fopen(argv[1], TEXTO_LECTURA);

	if(yyin == NULL)
	{	
		printf("\nNo se pudo abrir el archivo %s\n", argv[1]);
		return ERROR;
	}
	
	crear_lista(&tabla_simbolos);

	yyparse();

	pf = fopen(PATH_ARCHIVO_TS, TEXTO_ESCRITURA);
	if(pf == NULL)
	{
		printf("No se pudo crear el archivo %s para la tabla de simbolos\n", PATH_ARCHIVO_TS);
	}	
	else
	{
		guardar_lista(&tabla_simbolos, pf);
		fclose(pf);
	}

	vaciar_lista(&tabla_simbolos);
	fclose(yyin);
	return TODO_BIEN;
}

int yyerror(void)
{
    printf("Error Sintactico\n");
	exit (ERROR);
}