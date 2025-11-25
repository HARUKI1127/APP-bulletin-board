package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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

        MutterDAO dao = new MutterDAO();
        List<Mutter> list = dao.findAll();
        if (list == null) {
            list = new ArrayList<>();
        }
        request.setAttribute("mutterList", list);

        // JSPにフォワード
        request.getRequestDispatcher("/WEB-INF/main.jsp").forward(request, response);
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

        doGet(request, response);
    }
}
