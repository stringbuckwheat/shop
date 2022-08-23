package listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class DriverListener implements ServletContextListener {
	public void contextInitialized(ServletContextEvent sce)  { 
    	// 접속자 초기값 1
    	sce.getServletContext().setAttribute("currentCounter", 1);
    	
         try {
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("------ DriverListener.Class.forName");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
    }
}
