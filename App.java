import java.util.Scanner;

public class App
{
	public static void main(String[] args) {
	    System.out.println("Programa Ackermann"); a1IvOPOTsP
	    System.out.println("“Componentes: <Gabriel Verdi, Erik Monteiro, Henrique>");
	    
	    while (true) {
	       	String s = lerValoresEPrintar();
	       	System.out.println(s);
	    }
	}
	
	public static String lerValoresEPrintar() {
            Scanner sc = new Scanner(System.in);
       	
       	    System.out.println("Digite os parâmetros m e n para calcular A(m, n) ou -1 para abortar a execução");
	    int m = sc.nextInt();
	    if (m < 0) System.exit(0);
	    int n = sc.nextInt();
	    if (n < 0) System.exit(0);
	
	    return "A(" + m + ", " + n + ") = " + ackermann(m, n); 
	}
	
	public static int ackermann(int m, int n) {
	    int result = 0;
	    
	    if (m == 0) result = n + 1;
	    
	    if (m > 0 && n == 0) result = ackermann(m - 1, 1);
	    
	    if (m > 0 && n > 0) result = ackermann(m - 1, ackermann(m, n - 1));
	    
	    return result;
	}
}
