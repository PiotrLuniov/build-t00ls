package test.java.com.test;

import org.junit.Test;
import static org.junit.Assert.*;
import main.java.com.test.Project;


public class UnitTest {
    @Test 
    public void testAppHasAGreeting() {
        Project classUnderTest = new Project();
        assertNotNull(classUnderTest.getGreeting());
    }

   // @Test
   // public void test(){
   // 		assertNotNull(test());
   // }
}
