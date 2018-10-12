package controller;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dao.TourDao;
import model.vo.ReviewVO;
import service.ListVO;
import service.ReviewService;

public class GetBestReviewCityBytagController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String tag = request.getParameter("tag");
		System.out.println("tag�� ���ڶ� " + tag); //V

		int size = 0;
		if (request.getParameter("size") != null)
			size = Integer.parseInt(request.getParameter("size")); // relist size
		String city = request.getParameter("city"); 
		String location = request.getParameter("location");
		System.out.println("city�� ���ڶ� " + city);//V
		System.out.println("location�� ���ڶ� " + location);
		String pageNo = request.getParameter("pageNo");

	/*	System.out.println("pageNo�� ���ڶ� " + pageNo);*/
		ListVO cblist = null;

		try {
			cblist = ReviewService.getInstance().getBestReviewCityByTag(location, city, tag, pageNo);
			request.setAttribute("cblist", cblist);
			request.setAttribute("listSize", cblist.getList().size() + "");
			if (cblist.getList().size() - size < 3) {
				// �� ������ �� ���� ����.
				request.setAttribute("flag", false);
			}
			System.out.println(cblist);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("tabResult2.jsp");
	}
}
