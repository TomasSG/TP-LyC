#include "../include/lista.h"

void crear_lista(t_lista *pl)
{
    *pl=NULL;
}

void vaciar_lista(t_lista *pl)
{
    t_nodo_lista *pnodo;
    while(*pl)
    {
        pnodo=*pl;
        *pl=pnodo->psig;
        free(pnodo);
    }
}

int insertar_ordenado(t_lista *pl,const t_dato_lista *pd,t_cmp cmp)
{
    t_nodo_lista *pnodo;
    while(*pl && cmp(pd,&(*pl)->dato)>0)
        pl=&(*pl)->psig;
    if(*pl && cmp(pd,&(*pl)->dato)==0)
        return LISTA_DUPLICADO;
    pnodo=(t_nodo_lista*)malloc(sizeof(t_nodo_lista));
    if(!pnodo)
        return LISTA_LLENA;
    pnodo->dato=*pd;
    pnodo->psig=*pl;
    *pl=pnodo;
    return TODO_BIEN;
}

void recorrer_lista(const t_lista *pl,t_fun fun)
{
    while(*pl)
    {
        fun(&(*pl)->dato);
        pl=&(*pl)->psig;
    }
}

void guardar_lista(const t_lista *pl, const char *path)
{
	t_dato_lista *pd;
	char auxiliar[CANTIDAD_ITOA];
	FILE *pf = fopen(path, TEXTO_ESCRITURA);
	if(pf == NULL)
	{
		printf("No se pudo abrir el archivo %s\n", path);
	}
	fprintf(pf,"|-----------------------------------------------------------------------------------------------------------------------------------------------|\n");
	fprintf(pf,"|                                                      TABLA DE SIMBOLOS                                                                        |\n");
	fprintf(pf,"|-----------------------------------------------------------------------------------------------------------------------------------------------|\n");
	fprintf(pf,"|%-35s|%-35s|%-35s|%-35s|\n", "LEXEMA", "TIPO", "VALOR", "LONGITUD");
	fprintf(pf,"|-----------------------------------|-----------------------------------|-----------------------------------|-----------------------------------|\n");
    while(*pl)
    {
        pd =  &(*pl)->dato;
		if(pd->longitud == 0)
		{
			strcpy(auxiliar, " ");
		}
		else
		{
			itoa(pd->longitud, auxiliar, 10);
		}
		fprintf(pf,"|%-35s|%-35s|%-35s|%-35s|\n", pd->lexema, pd->tipo ? pd->tipo : " ", pd->valor ? pd->valor : " ", auxiliar);
        pl = &(*pl)->psig;
    }
	fprintf(pf,"|-----------------------------------------------------------------------------------------------------------------------------------------------|\n");
	fclose(pf);
}

int insertar_ts(const char *lexema, const char *valor, int longitud, t_lista *ptabla_simbolos)
{
	int resultado = -1;
	t_dato_lista *pd;
	// Reservamos memoria para el t_dato_lista
	pd = (t_dato_lista*)malloc(sizeof(t_dato_lista));
	if(pd == NULL)
	{
		printf("Problemas de memoria\n");
		return LISTA_LLENA;
	}

	// El tipo no se completa así que lo dejamos en nulo
	pd->tipo = NULL;

	// El lexema lo copiamos tal cual
	pd->lexema = (char*)malloc(sizeof(char) * strlen(lexema) + 1);
	if(pd->lexema == NULL)
	{
		printf("Problemas de memoria\n");
		return LISTA_LLENA;
	}
	strcpy(pd->lexema, lexema);
	
	// El valor hay que validar que no sea NULL porque hay casos en que no se completa el campo
	if(valor != NULL)
	{
		pd->valor = (char*) malloc(sizeof(char) * strlen(valor) + 1);
		if(pd->valor == NULL)
		{
			printf("Problemas de memoria\n");
			return LISTA_LLENA;
		}
		strcpy(pd->valor, valor);
		
	}
	else
	{
		pd->valor = NULL;
	}

	// La longitud la copiamos tal cual
	pd->longitud = longitud;
	
	// Ya armado el t_dato_lista insertamos en la tabla
	resultado = insertar_ordenado(ptabla_simbolos, pd, comparacion);
	if(resultado == LISTA_LLENA || resultado == LISTA_DUPLICADO)
	{
		free(pd);
		return resultado;
	}
	return TODO_BIEN;
}

int comparacion(const t_dato_lista *pd1,const t_dato_lista *pd2)
{
    return strcmp(pd1->lexema, pd2->lexema);
}

void mostrar(const t_dato_lista *pd)
{	
	printf("|%-35s|%-35s|%-35s|%d|\n", pd->lexema, pd->tipo, pd->valor, pd->longitud);
}
