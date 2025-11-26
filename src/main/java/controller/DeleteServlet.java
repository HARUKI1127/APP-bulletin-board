package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MutterDAO;

@WebServlet("/Delete")
public class DeleteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        int id = Integer.parseInt(idStr);

        MutterDAO mutterDAO = new MutterDAO();
        boolean isDeleted = mutterDAO.delete(id);

        if (isDeleted) {
            // ★絶対パスに修正
            response.sendRedirect("/bulletin-board/Main");
        } else {
            request.setAttribute("errorMsg", "削除に失敗しました。");
            request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
        }
    }
}
