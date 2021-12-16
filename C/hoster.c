#include <stdio.h>
#include <netdb.h>
#include <arpa/inet.h>

int main (int argc, char *argv[]){
	if(argc < 1){
		printf("Usage ./hoster IP\n");
		return -1;
	}	
	char *alvo;
	alvo = argv[1];
	struct hostent *host;

	host = gethostbyname(alvo);

	printf("%s ==> %s \n", alvo, inet_ntoa(*(struct in_addr *)host->h_addr));
	return 0;
}
