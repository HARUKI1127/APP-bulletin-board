package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Mutter;
import model.MutterDAO;

@WebServlet("/Edit")
public class EditServlet extends HttpServlet {

    // 編集画面表示
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Mutter mutter = new MutterDAO().findOne(id);
        request.setAttribute("mutter", mutter);

        // 修正：jsp/edit.jsp → edit.jsp
        request.getRequestDispatcher("/WEB-INF/edit.jsp").forward(request, response);
    }

    // 更新処理
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String text = request.getParameter("text");

        boolean updated = new MutterDAO().update(new Mutter(id, name, text));
        if (updated) {
            response.sendRedirect("bulletin-board/Main");
        } else {
            request.setAttribute("errorMsg", "更新に失敗しました");
            request.getRequestDispatcher("/WEB-INF/edit.jsp").forward(request, response);
        }
    }
}
