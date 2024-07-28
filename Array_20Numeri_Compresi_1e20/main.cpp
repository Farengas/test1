#include <iostream>
#include <algorithm>
#include <ctime>

using namespace std;

int main()
{
    srand(time(0)); // imposta il seme per la generazione di numeri casuali

    int arrayVentiNumeri[20];
    int contaOccorrenze[21] = {0}; // array per contare le occorrenze di ogni numero compreso tra 1 e 20

    cout << "Sto generando i numeri compresi tra 1 e 20..." << endl;
    cout << endl;

    for (int i = 0; i < 20; i++)
    {
        arrayVentiNumeri[i] = rand() % 20 + 1;
        cout << arrayVentiNumeri[i] << " ";
        contaOccorrenze[arrayVentiNumeri[i]]++; // incrementa la conta per il numero corrente
    }
    cout << endl;



    // stampa gli elementi che compaiono esattamente due volte
    cout << "Gli elementi che compaiono esattamente due volte sono:" << endl;

    for (int i = 1; i <= 20; i++)
    {
        if (contaOccorrenze[i] == 2)
        {
            cout << i << " " << endl;
        }
    }
   cout << endl;

    return 0;
}
