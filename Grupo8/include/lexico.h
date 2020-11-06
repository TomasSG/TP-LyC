#ifndef UTILITARIAS_H_INCLUDED
#define UTILITARIAS_H_INCLUDED

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "./constantes.h"
#include "./lista.h"

char* sacar_comillas(const char*);
char* agregar_guion_bajo(const char*);
char* convertir_cadena_decimal(const char*);
int convertir_caracter_decimal(const char);
char* adelantar_ceros(char*);
int error_lexico(const char*, int);

/* FUNCIONES DE VERIFICACION */
void verificar_string(const char*, int);
void verificar_rango_entero(char*, int);
void verificar_rango_real(char*, int);

/* FUNCIONES RELACIOANDAS CON LISTA */
void iniciar_lexico(t_lista*);
void finalizar_lexico(t_lista*, const char*);
void insertar_ts(const char*,const char*, const char*, int, t_lista*);

#endif // UTILITARIAS_H_INCLUDEDs