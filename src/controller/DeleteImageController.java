package controller;

import java.util.ArrayList;
import model.dao.TourDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteImageController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<String> list = (ArrayList<String>)request.getParameter("arr");
		int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
		for(String str : list)
			TourDao.getInstance().deleteImage(reviewNum,str);
		return new ModelAndView("index.jsp");
	}

}
