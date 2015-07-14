package problem482;

import java.util.Arrays;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.TreeSet;
import java.util.Set;
import java.util.stream.Collectors;
import sun.font.PhysicalFont;

/**
 *
 * @author loux
 */
public class PythagoreanTriple implements Cloneable {
    
    protected int a_,b_,c_;
    
    public PythagoreanTriple(int a, int b, int c) {
        this.a_=Math.min(a, b);
        this.b_=Math.max(a, b);
        this.c_=c;
    }
    
    @Override
    public String toString() {
        Set<Integer> set = new TreeSet<>();
        set.add(this.a_);
        set.add(this.b_);
        set.add(this.c_);
        return Arrays.toString(set.toArray());
    }
    
    public void multiply(int k) {
        this.b_ *= k;
        this.a_ *= k;
        this.c_ *= k;
    }
    
    @Override
    public PythagoreanTriple clone() throws CloneNotSupportedException {
        return (PythagoreanTriple) super.clone();
    }
    
    public static Set<PythagoreanTriple> generateTriples(double maxHypSize) throws CloneNotSupportedException {
        Comparator<PythagoreanTriple> comp = new Comparator<PythagoreanTriple>() {
            @Override
            public int compare(PythagoreanTriple t, PythagoreanTriple p) {
                int returnValue = (t.c_-p.c_);
                if (returnValue==0 && (t.b_!=p.b_ || t.a_!=p.a_)) {
                    returnValue=1;
                }
                return returnValue;
            }
        };
        Set<PythagoreanTriple> primeTriples = new TreeSet<>(comp);
        int m = 2;
        int n = 1;
        while (m*m<=maxHypSize-1) {
            if ((m-n)%2!=0 && isCoprime(m,n) && (m*m+n*n)<=maxHypSize) {
                primeTriples.add(new PythagoreanTriple(m*m-n*n, 2*m*n,m*m+n*n));
            }
            if (n<m-1 && (m*m+n*n<=maxHypSize)) {
                n++;
            } else {
                m++;
                n=1;
            }
        }
        Set<PythagoreanTriple> triples = new TreeSet<>(comp);
        for (PythagoreanTriple primeTriple : primeTriples) {
            int k = 1;
            while (primeTriple.c_*k<=maxHypSize) {
                PythagoreanTriple clone = primeTriple.clone();
                clone.multiply(k);
                triples.add(clone);
                k++;
            }
        }
        return triples;
    }
    
    private static boolean isCoprime(int m,int n) {
        while(m!=0 && n!=0) {
            if (m>n) {
                m%=n;
            } else {
                n%=m;
            }
        }
        int gcd = Math.max(n, m);
        return (gcd==1);
    }
    
    public static void main(String[] argv) throws CloneNotSupportedException {
        int maxPerimeter = (int) 1025;
        Set<PythagoreanTriple> triples = PythagoreanTriple.generateTriples(maxPerimeter/2);
        //
        System.out.println(triples.size()+"\n###########");
        int sum = 0;
        int nbTriangle = 0;
        Iterator iteratorMainSet = triples.iterator();
        while (iteratorMainSet.hasNext()) {
            PythagoreanTriple triple = (PythagoreanTriple) iteratorMainSet.next();
            for (int i=0;i<2;i++) {
                final int r = (i==0?triple.a_:triple.b_);
                if (r%2 == 0) {
                    int y = (i==0?triple.b_:triple.a_);
                    int IB = triple.c_;
                    List<PythagoreanTriple> triplesWithSameLengthSide = triples.stream().filter(t -> (t.a_==r || t.b_==r)).collect(Collectors.toList());
                    Iterator iteratorSetWithSameSide = triplesWithSameLengthSide.iterator();
                    while (iteratorSetWithSameSide.hasNext()) {
                        PythagoreanTriple tripleWithSameLengthSide = (PythagoreanTriple) iteratorSetWithSameSide.next();
                        int x;
                        int IC = tripleWithSameLengthSide.c_;
                        if (tripleWithSameLengthSide.a_ == r) {
                            x = tripleWithSameLengthSide.b_;
                        } else {
                            x = tripleWithSameLengthSide.a_;
                        }
                        double alpha = 2*Math.asin(((double)r)/((double)IC));
                        double beta = 2*Math.asin(((double)r)/((double)IB));
                        if ((alpha+beta)<Math.PI) {
                            double lastSide = (x+y)*Math.sin(alpha)/Math.sin(Math.PI-alpha-beta) - y;     
                            if (Math.abs(Math.floor(lastSide)-lastSide)<1E-5 || Math.abs(Math.floor(lastSide)+1-lastSide)<1E-5) {
                                final int z = (int) Math.rint(lastSide);
                                if ((x+y+z)*2<maxPerimeter) {
                                    for (PythagoreanTriple aux : triplesWithSameLengthSide.stream().filter(t -> (t.a_==z || t.b_==z)).collect(Collectors.toList())) {
                                            System.out.println("One triangle has been found !");
                                            System.out.println(triple.toString()+" "+tripleWithSameLengthSide.toString()+" "+aux.toString());
                                            System.out.println("Perimeter : "+(x+y+z)*2);
                                            sum += (x+y+z)*2 + IB + IC + aux.c_;
                                            nbTriangle++;
                                    }
                                }
                            }
                        }
                        iteratorSetWithSameSide.remove();
                    }
                }
            }
            iteratorMainSet.remove();
        }
        System.out.println(sum);
        System.out.println(nbTriangle);
    }
}
