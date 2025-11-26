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

        // リクエストパラメータから削除対象のIDを取得
        String idStr = request.getParameter("id");
        int id = Integer.parseInt(idStr);

        // DAOをインスタンス化して、削除処理を依頼
        MutterDAO mutterDAO = new MutterDAO();
        boolean isDeleted = mutterDAO.delete(id);

        if (isDeleted) {
            // 削除成功後、メイン画面にリダイレクトして一覧を再表示
            response.sendRedirect("bulletin-board/Main");
        } else {
            // エラー処理（簡略化：必要に応じてエラーページにフォワードするなど）
            request.setAttribute("errorMsg", "削除に失敗しました。");
            request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
        }
    }
}
