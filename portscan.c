#include <stdio.h>
#include <stdlib.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/socket.h>

int main(int argc, char *argv[]){
	int meusocket;
	int conecta;
	int *porta;
	char *ip;

	ip = argv[1];
	porta = atoi(argv[2]);
	
	printf("%s, %d\n", ip, porta);
	struct sockaddr_in alvo;

	meusocket = socket(AF_INET, SOCK_STREAM, 0);
	alvo.sin_family = AF_INET;
	alvo.sin_port = htons(porta);
	alvo.sin_addr.s_addr = inet_addr(ip);

	conecta = connect(meusocket, (struct sockaddr *)&alvo, sizeof alvo);

	if(conecta == 0){
		printf("Porta aberta");
		close(meusocket);
		close(conecta);
	}else{
		printf("Porta Fechada");
	}
}
