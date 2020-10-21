%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include "./lib/lista.h"
#include "./lib/utilitarias.h"
#include "y.tab.h"

/* VARIABLES GLOBALES */
FILE *yyin;
int yyval;
t_lista tabla_simbolos;
%}

%option noyywrap
%option yylineno

LETRA			[a-zA-Z]
DIGITO			[0-9]
DIGITO_BINARIO	[01]
DIGITO_HEXA		[0-9a-fA-F]

/* PALABRAS RESERVADAS */
WHILE			"while"
IF				"if"
ELSE			"else"|"Else"
PUT				"PUT"
GET				"GET"
DIM				"DIM"
AS				"AS"
CONTAR			"contar"
INTEGER			"Integer"
FLOAT			"Float"
STRING			"String"

/* SIGNOS PUNTUACION Y OTROS */
LLAVE_ABIERTO		"{"
LLAVE_CERRADO		"}"
PAR_ABIERTO			"("
PAR_CERRADO			")"
COR_ABIERTO			"["
COR_CERRADO			"]"
PUNTO_COMA			";"
COMA				","

/* OPERADORES */
OP_ASIGNACION		":="
OP_SUMA 			"+"
OP_RESTA			"-"
OP_DIVISION			"/"
OP_MULT				"*"
OP_LE				"<"
OP_LEQ				"<="
OP_GE				">"
OP_GEQ				">="
OP_NE				"<>"
OP_IGUAL			"=="
OP_AND				"and"
OP_OR				"or"
OP_NOT				"not"

/* CONSTANTES */
CONST_ENTERA		{DIGITO}+
CONST_REAL			({DIGITO}+"."{DIGITO}*)|({DIGITO}*"."{DIGITO}+)
CONST_STRING		\".*\"
CONST_BINARIA		0b{DIGITO_BINARIO}+
CONST_HEXA			0x{DIGITO_HEXA}+

/* VARIABLES */
ID			{LETRA}({LETRA}|{DIGITO}|"_")*

/* COMENTARIOS */
COMENTARIO		"*-".*"-*"

%%

{WHILE}				{return WHILE;}	
{IF}				{return IF;}	
{ELSE}				{return ELSE;}
{PUT}				{return PUT;}
{GET}				{return GET;}
{DIM}				{return DIM;}
{AS}				{return AS;}
{CONTAR}			{return CONTAR;}		
{INTEGER}			{return INTEGER;}
{FLOAT}				{return FLOAT;}
{STRING}			{return STRING;}

{LLAVE_ABIERTO}		{return LLAVE_ABIERTO;}
{LLAVE_CERRADO}		{return LLAVE_CERRADO;}
{PAR_ABIERTO}		{return PAR_ABIERTO;}
{PAR_CERRADO}		{return PAR_CERRADO;}
{COR_ABIERTO}		{return COR_ABIERTO;}
{COR_CERRADO}		{return COR_CERRADO;}
{PUNTO_COMA}		{return PUNTO_COMA;}
{COMA}				{return COMA;}

{OP_ASIGNACION} 	{return OP_ASIGNACION;}
{OP_SUMA}			{return OP_SUMA;}
{OP_RESTA}			{return OP_RESTA;}
{OP_DIVISION}		{return OP_DIVISION;}
{OP_MULT}			{return OP_MULT;}
{OP_LE}				{return OP_LE;}
{OP_LEQ}			{return OP_LEQ;}		
{OP_GE}				{return OP_GE;}
{OP_GEQ}			{return OP_GEQ;}	
{OP_NE}				{return OP_NE;}
{OP_AND}			{return OP_AND;}
{OP_OR}				{return OP_OR;}
{OP_NOT}			{return OP_NOT;}
{OP_IGUAL}			{return OP_IGUAL;}


{CONST_STRING}		{char *string = sacar_comillas(yytext);
					verificar_string(string, yylineno);
					insertar_ts(agregar_guion_bajo(string), string, &tabla_simbolos);
					return CONST_STRING;}

{CONST_ENTERA}		{verificar_rango_entero(yytext, yylineno);
					insertar_ts(agregar_guion_bajo(yytext), yytext, &tabla_simbolos);
					return CONST_ENTERA;}

{CONST_REAL}		{verificar_rango_real(yytext, yylineno);
					insertar_ts(agregar_guion_bajo(yytext), yytext, &tabla_simbolos);
					return CONST_REAL;}

{CONST_BINARIA}		{char *cadena_valor_decimal = convertir_cadena_decimal(yytext);
					verificar_rango_entero(cadena_valor_decimal, yylineno);
					insertar_ts(agregar_guion_bajo(yytext), cadena_valor_decimal, &tabla_simbolos);
					return CONST_BINARIA;}

{CONST_HEXA}		{char *cadena_valor_decimal = convertir_cadena_decimal(yytext);
					verificar_rango_entero(cadena_valor_decimal, yylineno);
					insertar_ts(agregar_guion_bajo(yytext), cadena_valor_decimal, &tabla_simbolos);
					return CONST_HEXA;}

{ID}				{insertar_ts(yytext, NULL, &tabla_simbolos); return ID;}

{COMENTARIO}		{}
"\n"				{}
"\t"				{}

%%

