import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.TreeSet;
import java.util.Set;
import java.util.stream.Collectors;

/**
 *
 * @author loux
 */
public class PythagoreanTriple implements Cloneable {
    
    protected int a_,b_,c_;
    private static final double EPS = 1E-5;
    
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
    
    public static Set<PythagoreanTriple> generateTriples(double maxHypSize,Comparator<PythagoreanTriple> comp) throws CloneNotSupportedException {
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
    
    
    @SuppressWarnings("Convert2Lambda")
    public static void main(String[] argv) throws CloneNotSupportedException {
        double beginingTime = System.currentTimeMillis();
	if (argv.length!=1) {
		throw new RuntimeException("There must be only one argument bro : the maximal perimeter");
	}
        int maxPerimeter = (int) Double.parseDouble(argv[0]);
        Comparator<PythagoreanTriple> comp = new Comparator<PythagoreanTriple>() {
            @Override
            public int compare(PythagoreanTriple t, PythagoreanTriple p) {
                int returnValue = (t.a_-p.a_);
                if (returnValue==1) {
                    returnValue++;
                }
                if (returnValue==0 && (t.b_!=p.b_ || t.a_!=p.a_ || t.c_!=p.c_)) {
                    returnValue=1;
                }
                return returnValue;
            }
        };
        Set<PythagoreanTriple> triples = PythagoreanTriple.generateTriples(maxPerimeter/2,comp);
        //
        comp = new Comparator<PythagoreanTriple>() {
            @Override
            public int compare(PythagoreanTriple t, PythagoreanTriple p) {
                int returnValue = (t.b_-p.b_);
                if (returnValue==1) {
                    returnValue++;
                }
                if (returnValue==0 && (t.b_!=p.b_ || t.a_!=p.a_ || t.c_!=p.c_)) {
                    returnValue=1;
                }
                return returnValue;
            }
        };
        Set<PythagoreanTriple> triplesAux = PythagoreanTriple.generateTriples(maxPerimeter/2,comp);
        //
        double totalSizeSet = triples.size();
        System.out.println("Number of pythagorean triples : "+(int)totalSizeSet);
        System.out.println("###########");
        System.out.println("Start of the run !");
        int percentChecked = 0;
        int checkedTriple = 0;
        long sum = 0;
        int nbTriangleFound = 0;
        Iterator iteratorMainSet = triples.iterator();
        PythagoreanTriple newTriple = (PythagoreanTriple) iteratorMainSet.next();
        while (iteratorMainSet.hasNext()) {
            //
            PythagoreanTriple triple = newTriple;
            int r = triple.a_;
            List<PythagoreanTriple> triplesWithSameRadius = new ArrayList<>();
            iteratorMainSet.remove();
            checkedTriple++;
            triplesWithSameRadius.add(triple);
            boolean loop = iteratorMainSet.hasNext();
            while (loop) {
                PythagoreanTriple tripleAux = (PythagoreanTriple) iteratorMainSet.next();
                loop = iteratorMainSet.hasNext() && tripleAux.a_==r;
                if (tripleAux.a_==r) {
                    triplesWithSameRadius.add(tripleAux);
                    iteratorMainSet.remove();
                    checkedTriple++;
                } else {
                    newTriple = tripleAux;
                }
            }
            //
            Iterator iteratorAuxSet = triplesAux.iterator();
            loop = iteratorAuxSet.hasNext();
            while (loop) {
                PythagoreanTriple tripleAux = (PythagoreanTriple) iteratorAuxSet.next();
                loop = iteratorAuxSet.hasNext() && (tripleAux.b_<=r);
                if (tripleAux.b_<=r) {
                    iteratorAuxSet.remove();
                    if (tripleAux.b_==r) {
                        triplesWithSameRadius.add(tripleAux);
                    } 
                }
            }
            //
            for (int i=0;i<triplesWithSameRadius.size();i++) {
                PythagoreanTriple mainTriple = triplesWithSameRadius.get(i);
                int y = (mainTriple.a_ == r)?mainTriple.b_:mainTriple.a_;
                int IB = mainTriple.c_;
                for (int j=i;j<triplesWithSameRadius.size();j++) {
                    PythagoreanTriple secondTriple = triplesWithSameRadius.get(j);
                    int x = (secondTriple.a_ == r)?secondTriple.b_:secondTriple.a_;
                    int IC = secondTriple.c_;
                    double alpha = 2*Math.asin(((double)r)/((double)IC));
                    double beta = 2*Math.asin(((double)r)/((double)IB));
                    if ((alpha+beta)<Math.PI) {
                        double lastSide = (x+y)*Math.sin(beta)/Math.sin(Math.PI-alpha-beta) - x;     
                        if (Math.abs(Math.floor(lastSide)-lastSide)<PythagoreanTriple.EPS || Math.abs(Math.floor(lastSide)+1-lastSide)<PythagoreanTriple.EPS) {
                            final int z = (int) Math.rint(lastSide);
                            if ((x+y+z)*2<maxPerimeter) {
                                List<PythagoreanTriple> tripleWithWantedZ = triplesWithSameRadius.subList(j, triplesWithSameRadius.size()).stream().filter(t -> (t.a_==z || t.b_==z)).collect(Collectors.toList());
                                for (PythagoreanTriple aux : tripleWithWantedZ) {
    //                                    System.out.println("One triangle has been found !");
//                                        System.out.println(mainTriple.toString()+" "+secondTriple.toString()+" "+aux.toString());
                                        sum += (long) (x+y+z)*2 + IB + IC + aux.c_;
                                        nbTriangleFound++;
                                }
                            }
                        }
                    }
                }
            }
//          Print progress...
            int percent = (int) Math.floor(100*checkedTriple/totalSizeSet);
            if (percent > percentChecked) {
                percentChecked = percent;
                System.out.println("Progress ... "+percentChecked+"%");
            }            
        }
        System.out.println("###########");
        System.out.println("End of run!");
        System.out.println("Time of run : "+(System.currentTimeMillis()-beginingTime)/1000+" s");
        System.out.println("S("+maxPerimeter+") = "+sum);
        System.out.println("Number of triangle = "+nbTriangleFound);
    }
}
