package some.package.name;

/**
 *
 * Created by sputnik on 13.01.15.
 */
public class Main {
    public static void main(String[] args) throws NoSuchMethodException, IllegalAccessException, InstantiationException {
        final String sql = new Runner().run(Main.class);
        System.out.println("Some SQL: " + sql);
    }
}
