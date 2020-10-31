#ifndef SEMANTICO_H_INCLUDED
#define SEMANTICO_H_INCLUDED

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "./lista.h"
#include "./constantes.h"

void iniciar_semantica(int*);
void anadir_elementos(char**, char**, const char*, const char*, int*);
void finalizar_semantica (char**, char**, int*);
void error(const char*, int);

/* FUNCIONES CON LISTA */
void completar_tipos(t_lista*, char**, char**, int*);
char* buscar_tipo(t_lista*, const char*);
char* coercion_tipos(char*, char*, int);

#endif 