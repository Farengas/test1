using System.Windows;
using System.Text.RegularExpressions;

namespace WPF_CriptazioneQuadrato
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void EncryptButton_Click(object sender, RoutedEventArgs e)
        {
            string inputText = InputTextBox.Text;
            string normalizedText = NormalizzaTesto(inputText);
            (int rows, int columns) = CalcolaDimensioni(normalizedText.Length);
            string encryptedText = Cripta(normalizedText, rows, columns);
            OutputTextBox.Text = encryptedText;
        }
        //Converte il testo in minuscolo,elimina punteggiatura e spazi
        private string NormalizzaTesto(string text) //Converte il testo in minuscolo,elimina punteggiatura e spazi
        {
            string lowerText = text.ToLower();
            string normalizedText = Regex.Replace(lowerText, @"[^a-z]", "");
            return normalizedText;
        }
        //Calcola le dimensioni della matrice
        private (int, int) CalcolaDimensioni(int length)
        {
            int columns = (int)Math.Ceiling(Math.Sqrt(length));
            int rows = (int)Math.Floor(Math.Sqrt(length));
            while (columns * rows < length){
                if (columns > rows)              
                    rows++;               
                else               
                    columns++;               
            }
            return (rows, columns);
        }
        private string Cripta(string text, int rows, int columns)
        {
            char[,] rectangle = new char[rows, columns];
            for (int i = 0; i < text.Length; i++){
                int row = i / columns;
                int column = i % columns;
                rectangle[row, column] = text[i];
            }
            string encryptedText = "";
            for (int column = 0; column < columns; column++){
                for (int row = 0; row < rows; row++){
                    if (rectangle[row, column] != '\0')                   
                        encryptedText += rectangle[row, column];                   
                }
                encryptedText += " ";
            }
            return encryptedText.Trim();
        }
    }     
}
