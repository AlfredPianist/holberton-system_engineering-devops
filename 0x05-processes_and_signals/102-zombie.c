#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

/**
 * infinite_while - infinite loop for parent process.
 *
 * Return: Success (0).
 */
int infinite_while(void)
{
	while (1)
	{
		sleep(1);
	}
	return (0);
}

/**
 * main - Creates 5 child zombie processes (not monitored by parent) and
 *        then continues to an infinite loop.
 *
 * Return: Success (0), or failure (1) when not able to create child processes.
 */
int main(void)
{
	int i;
	pid_t zombie_proc;

	for (i = 0; i < 5; i++)
	{
		zombie_proc = fork();
		if (zombie_proc != 0)
			printf("Zombie process created, PID: %i\n", zombie_proc);
		else
			exit(EXIT_FAILURE);
	}
	infinite_while();
	exit(EXIT_SUCCESS);
}
