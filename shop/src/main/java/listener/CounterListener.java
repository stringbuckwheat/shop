package listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import service.CounterService;

@WebListener
public class CounterListener implements HttpSessionListener {
	private CounterService counterService;

	// 세션이 생성될 때마다 DB카운터를 1씩 증가
	// 세션이 생성될 때마다 application attribute에 현재 접속 카운터를 1씩 증가
	// index.jsp에서 호출
	public void sessionCreated(HttpSessionEvent se)  { 
		this.counterService = new CounterService();
		counterService.count();
		
		
		/*
		 * request.setAttribute(): 요청 객체 안에 map 형태로 저장, 응답하고 나면 삭제됨
		 * session.setAttribute(): 세션 객체 안에 map 형태로 저장, 세션이 사라지거나 invalidate()가 호출되면 삭제됨
		 * application.setAttribute(): 컨텍스트 객체 안에?, 톰캣 안에 저장. 
		 */
		
		if(se.getSession().getServletContext().getAttribute(null) == null) {
			se.getSession().getServletContext().setAttribute("currentCounter", 1);
		} else {
			se.getSession().getServletContext().setAttribute("currentCounter"
					, (Integer)se.getSession().getServletContext().getAttribute("currentCounter") + 1);
		}

		
    }

	// 세션이 소멸되면 application attribute에 현재 접속 카운터를 1씩 감소
    public void sessionDestroyed(HttpSessionEvent se)  {
    	se.getSession().getServletContext().setAttribute("currentCounter"
				, (Integer)se.getSession().getServletContext().getAttribute("currentCounter") - 1);
    }
	
}
