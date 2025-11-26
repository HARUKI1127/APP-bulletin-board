package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Mutter;
import model.MutterDAO;

@WebServlet("/Main")
public class MainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MainServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // DAOを呼び出して、つぶやきリストを取得
        MutterDAO mutterDAO = new MutterDAO();
        List<Mutter> mutterList = mutterDAO.findAll();

        if (mutterList == null) {
            mutterList = new ArrayList<>();
        }

        request.setAttribute("mutterList", mutterList);

        // フォワード先を「/WEB-INF/main.jsp」に修正
        String forwardPath = "/WEB-INF/main.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(forwardPath);
        dispatcher.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String userName = request.getParameter("userName");
        String text = request.getParameter("text");

        if (userName != null && !userName.isEmpty() && text != null && !text.isEmpty()) {
            Mutter mutter = new Mutter(userName, text);
            MutterDAO dao = new MutterDAO();
            boolean result = dao.create(mutter);
            if (!result) {
                request.setAttribute("errorMsg", "データの登録に失敗しました。");
            }
        } else {
            request.setAttribute("errorMsg", "名前とつぶやきを入力してください。");
        }

        // doGet を呼び出してリスト再表示
        doGet(request, response);
    }
}
