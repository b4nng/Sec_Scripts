#include <stdio.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <string.h>

int main(int argc, char *argv[]){
	if(argc < 2){
		printf("Utilize os parametros de IP e listname respectivamente");
		return 0;
	}
	struct hostent *host;
	char *alvo;
	alvo = argv[1];
	FILE *arquivo;
	arquivo = fopen(argv[2], "r");
	char texto[20];
	char *result;
	while(fscanf(arquivo, "%s", &texto) != EOF){
		result = (char *) strcat(texto,".");
		result = (char *) strcat(result,alvo);
		host=gethostbyname(result);
		if(host == NULL){ continue; }
		printf("%s ==> %s\n", result, inet_ntoa(*((struct in_addr *)host->h_addr)));	
	}
}
