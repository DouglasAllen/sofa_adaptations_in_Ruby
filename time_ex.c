// 21.4.9 Time Functions Example

// Here is an example program showing the use of some of the calendar time functions.

     
#include <time.h>
#include <stdio.h>
#include <sys/time.h>

#define SIZE 256

int
main (void)
{
	char buffer[SIZE];
	time_t curtime;
	struct tm *loctime;

	/* Get the current time. */
	curtime = time (NULL);

	/* Convert it to local time representation. */
	loctime = localtime (&curtime);

	/* Print out the date and time in the standard format. */
	fputs (asctime (loctime), stdout);

	/* Print it out in a nice format. */
	strftime (buffer, SIZE, "Today is %A, %B %d.\n", loctime);
	fputs (buffer, stdout);
	strftime (buffer, SIZE, "The time is %I:%M %p.\n", loctime);
	fputs (buffer, stdout);

	return 0;
}
// It produces output like this:

     // Wed Jul 31 13:02:36 1991
     // Today is Wednesday, July 31.
     // The time is 01:02 PM.