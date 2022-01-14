#include <stdio.h>
#include <unistd.h>

int x86_atomic_cmp_set(int *lock, int old, int set)
{
    char res;

    __asm__ volatile (
            " lock; "
            "    cmpxchgl  %3, %1;   "
            "    sete      %0;       "
            : "=a" (res) : "m" (*lock), "a" (old), "r" (set) : "cc", "memory");

    return res;

}

int main(int argc, char **argv)
{
    int pid = getpid();

    int lock = 1;
    int res;

    res = x86_atomic_cmp_set(&lock, 0, pid);
    if (res) {
        printf("Yep, I get the lock\n");
    } else {
        printf("No, I don't get the lock\n");
    }

    printf("Now lock value is: %d\n", lock);
}
