#ifndef LISTA_TS_H_INCLUDED
#define LISTA_TS_H_INCLUDED

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "./constantes.h"

typedef struct
{
	char *lexema;
	char *tipo;
	char *valor;
	int longitud;
}t_dato_lista_ts;

typedef struct s_nodo_lista_ts
{
    t_dato_lista_ts dato;
    struct s_nodo_lista_ts *psig;
}t_nodo_lista_ts;

typedef t_nodo_lista_ts* t_lista_ts;
typedef int(*t_cmp)(const t_dato_lista_ts*,const t_dato_lista_ts*);


int comparacion(const t_dato_lista_ts*,const t_dato_lista_ts*);

void crear_lista(t_lista_ts*);
void vaciar_lista(t_lista_ts*);
int insertar_ordenado(t_lista_ts*,const t_dato_lista_ts*,t_cmp);
void guardar_lista_en_archivo(t_lista_ts*, const char*);
int cambiar_campo_tipo(t_lista_ts*, const char*, const char*);
char* buscar_tipo(t_lista_ts*, const char*);
char* buscar_valor(t_lista_ts*, const char*);

#endif // LISTA_TS_H_INCLUDED