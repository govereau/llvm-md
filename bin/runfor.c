#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

int main(int argc, char* argv[]) {
  if (argc < 3) {
    printf("bad usage\n");
    exit(1);
  }
  int d = atoi(argv[1]);
  if (d == 0) {
    printf("bad timeout\n");
    exit(1);
  }
  char*  prog = argv[2];
  char** args = argv+2;

  int p = fork();
  if (p < 0) {
    perror("fork");
    exit(1);
  } else if (p == 0) {
    execv(prog, args);
    exit(0);
  }
  sleep(d);
  if(kill(p,SIGKILL) >= 0)
    printf("TIMEOUT %d\n", p);
  return 0;
}
