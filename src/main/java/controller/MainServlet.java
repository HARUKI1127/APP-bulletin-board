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

    // ------------------------------------------------
    // GET（一覧表示）
    // ------------------------------------------------
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // DAOからデータ一覧を取得
        MutterDAO dao = new MutterDAO();
        List<Mutter> list = dao.findAll();
        if (list == null) {
            list = new ArrayList<>();
        }
        request.setAttribute("mutterList", list);

        // JSPにフォワード（webapp直下に置く場合は /main.jsp）
        request.getRequestDispatcher("/WEB-INF/main.jsp").forward(request, response);
    }

    // ------------------------------------------------
    // POST（つぶやき投稿 → DB登録）
    // ------------------------------------------------
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 文字コード設定
        request.setCharacterEncoding("UTF-8");

        // パラメータ取得
        String userName = request.getParameter("userName");
        String text = request.getParameter("text");

        // 入力チェック
        if (userName != null && !userName.isEmpty() && text != null && !text.isEmpty()) {

            // Mutterインスタンス作成
            Mutter mutter = new Mutter(userName, text);

            // DB登録
            MutterDAO dao = new MutterDAO();
            boolean result = dao.create(mutter);
            if (!result) {
                request.setAttribute("errorMsg", "データの登録に失敗しました。");
            }

        } else {
            request.setAttribute("errorMsg", "名前とつぶやきを入力してください。");
        }

        // GET に処理を任せて一覧再表示
        doGet(request, response);
    }
}
