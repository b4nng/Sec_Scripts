#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void parabens(){
	printf("Parabens");
}

int main(int argc, char *argv[]){
	char login[10];
	char correto[10];
	strcpy(correto, "Joao");
	gets(login);
	if(strcmp(login, correto) == 0){
		parabens();
	}else{
		printf("Errou\n");
	}
	return 0;
}
