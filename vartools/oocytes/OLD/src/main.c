#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <unistd.h>
#include <dirent.h>

#include "oofit.h"

// while (1)
// open
//filedata -> oostruct
//accept user input for these 5 commands (any order)
//      fit : oostruct datapoints -> oostruct fit values
//      graph : oostruct datapoints & fits -> graph
//      write : oostruct data -> file
//      open : continue (back to open)
//      quit : quit program


struct hash {
    int key;
    char value[50];
};

void quitfile() /* write error message and quit */
{
    fprintf(stderr, "The file name that you entered was invalid\n");
    exit(1);
}

void fitstruct (struct oorow * record, int size) {
    int result;
    int param;
    printf("Please enter an INTEGER parameter setting. Options below:\n");
    printf("1 = BOTTOM constrained to 0, TOP constrained to 100\n");
    printf("2 = BOTTOM unconstrained,    TOP constrained to 100\n");
    printf("3 = BOTTOM constrained to 0, TOP unconstrained\n");
    printf("4 = BOTTOM unconstrained,    TOP unconstrained\n");
    printf("Equation: ");
    result = scanf("%d", &param);

    if (result == EOF) {
    /* ... you're not going to get any input ... */
    }
    if (result == 0) {
        while (fgetc(stdin) != '\n');
    }
    //fitting
    // figure out the number of concentrations of the recording
    int i;
    // ---- FIT BY FILE ----
    for (i=0;i<size;i++) {
        int n = ooarrsize(&record[i]);
        // define the arrays based on the size
        double dose_arr[10]; //arbitrary size
        double res_arr[10]; //
        ootoarr(&record[i], res_arr, dose_arr, n);
        // debugging
        /*
        int j;
        for (j=0;j<n;j++) {
            printf("%.7g ", res_arr[j]);
            printf("%.7g ", dose_arr[j]);
        }
        */
        double ret_arr[6];
        if (param == 1) {
            fit1d(res_arr, dose_arr, n, ret_arr);
            //pfit(ret_arr);
        }
        if (param == 2) {
            fit2d(res_arr, dose_arr, n, ret_arr);
            //pfit(ret_arr);
        }
        if (param == 3) {
            fit3d(res_arr, dose_arr, n, ret_arr);
            //pfit(ret_arr);
        }
        if (param == 4) {
            fit4d(res_arr, dose_arr, n, ret_arr);
            //pfit(ret_arr);
        }
        struct oorow * dptr = &record[i];
        dptr->logec50 = ret_arr[0];
        dptr->hillslope = ret_arr[1];
        dptr->ymin = ret_arr[2];
        dptr->ymax = ret_arr[3];
        dptr->equation = ret_arr[4];
        dptr->conv = ret_arr[5];
    }
    printf("==========================================================================\n");
    printf("| %-20s | %-7s | %-5s | %-5s | %-5s | %-5s | %-5s |\n", "Construct", "logEC50", "nH", "Ymin", "Ymax","Eq","Iter");
    printf("|----------------------|---------|-------|-------|-------|-------|-------|\n");
    for (i=0; i<size; i++) {
        char construct[1024];
        char dash[2] = "/";
        strcpy(construct, record[i].glun1);
        strncat(construct, dash, 2);
        strncat(construct, record[i].glun2, 20);
        char logec50[6];
        char hillslope[5];
        char ymin[6];
        char ymax[6];
        char equation[6];
        char conv[6];
        snprintf(logec50, 6, "%g", record[i].logec50);
        snprintf(hillslope, 5, "%g", record[i].hillslope);
        snprintf(ymin, 6, "%g", record[i].ymin);
        snprintf(ymax, 6, "%g", record[i].ymax);
        snprintf(equation, 6, "%d", (int) record[i].equation);
        snprintf(conv, 6, "%d", (int) record[i].conv);
        printf("| %-20s | %-7s | %-5s | %-5s | %-5s | %-5s | %-5s |\n", construct, logec50, hillslope, ymin, ymax, equation, conv);
    }
    printf("==========================================================================\n");
}

int main() {
    printf("|=======================================================|\n");
    printf("| oofit v 1.0 written by James Allen for sftlab & CFERV |\n");
    printf("|=======================================================|\n");
    // get the filename
    printf("To get started, please choose a file.\n");
    while(1) {
        printf("Below are the loaded .oo files:\n");
        printf("------------------------------\n");
        DIR * dir;
        struct dirent * ent;
        dir = opendir("dir/load/");
        int fcount = 0;
        while ((ent = readdir (dir)) != NULL) {
            if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0) {
                continue;
            } else {
                printf("%s \n", ent->d_name);
                fcount++;
            }
        }
        rewinddir(dir);
        struct hash * dhash = (struct hash *) malloc(fcount * sizeof(struct hash));
        struct hash * ptr = dhash;
        int i = 0;
        char dirstr[13] = "dir/load/";
        while ((ent = readdir (dir)) != NULL) {
            if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0) {
                continue;
            } else {
                //printf("%s \n", ent->d_name);
                ptr->key = i;
                strcpy(ptr->value, ent->d_name);
                printf("%-5d :     %-20s\n", i, ent->d_name);
                i++; ptr++;
            }
        }
        closedir(dir);
        free(dhash);
        int fint;
        printf("------------------------------\n");
        printf("File index: ");
        int result = scanf("%d", &fint);
        printf("%d\n", fint);
        if (result == EOF) {
        /* ... you're not going to get any input ... */
        }
        if (result == 0) {
            while (fgetc(stdin) != '\n');
        }
        char fname[50];
        char fdir[50];
        for (i=0; i<fcount; i++) {
            if (fint == dhash[i].key) {
                strcpy(fname, dhash[i].value);
                printf("%s\n", fname);
            }
        }
        strcpy(fdir, dirstr);
        printf("%s\n", fdir);
        strcat(fdir, fname);
        printf("%s\n", fname);
        printf("%s\n", fdir);

        FILE * file;
        file = fopen(fdir, "r");
        if (file){
            fclose(file);
            printf("Parsing your file...");
        }else{
            quitfile();
        }
        // find the size of the file in rows
        int size = oosize(fdir);
        // define the structure based on the size
        struct oorow * record = (struct oorow *) malloc(size * sizeof(struct oorow)); 
        // fill the structure with data
        ooparse(fdir, record);
        printf("DONE\n");
        // ----------------------------------------------
        // Command Center
        char cmd[6];
        printf("For info on available commands type 'help'\n");
        while (1) {
            printf(">");
            fgets(cmd, 6, stdin);
            if (strncmp(cmd, "fit", 3) == 0) {
                fitstruct(record, size);
            }
            else if (strncmp(cmd, "open", 4) == 0) {
                free(record);
                break;
            } 
            else if (strncmp(cmd, "graph", 5) == 0) {
                printf("graphing not supported in this version yet...maybe one day");
                continue;
            }
            else if (strncmp(cmd, "write", 5) == 0) {
                ooreturn(fname, record, size);
            }
            else if (strncmp(cmd, "quit", 4) == 0) {
                free(record);
                return 0;
            }
            else if (strncmp(cmd, "help", 4) == 0) {
                printf("Available commands:\n");
                printf("open - file dialogue where you can load a file for fitting, etc\n");
                printf("fit - shows fitting dialogue, select an equation and\n");
                printf("graph - not currently supported (TODO)\n");
                printf("write - writes the currently open file with the last used fits.\n");
                printf("quit - stops the program\n");
            }
        }
    }
    return 0;
}
