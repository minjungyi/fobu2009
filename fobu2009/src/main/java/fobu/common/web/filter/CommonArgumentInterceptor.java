package main.java.fobu.common.web.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * Common Argument Interceptor
 * 
 * <pre>
 * Client의 요청시마다 프로토콜에 종속적인 데이터를 Controller 외
 * 레이어에서 사용하기 위한 데이터 바인딩 인터셉터
 * </pre>
 *
 * @author Min™
 * @since 2012. 03. 28.
 */
public class CommonArgumentInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		request.setAttribute("ip.server", request.getLocalAddr());
		request.setAttribute("ip.client", request.getRemoteAddr());
		request.setAttribute("uri.request", request.getRequestURI());
		request.setAttribute("url.request", request.getRequestURL().toString());
		request.setAttribute("header.userAgent", request.getHeader("User-Agent"));
		request.setAttribute("context.path",
				request.getSession().getServletContext().getRealPath("."));
		//request.setAttribute("menuId", request.getParameter("menuId"));
		return super.preHandle(request, response, handler);
	}
	
}
