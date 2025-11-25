package model;

public class Mutter {
    private String name;
    private String text;

    // コンストラクタ
    public Mutter(String name, String text) {
        this.name = name;
        this.text = text;
    }

    // getter
    public String getName() {
        return name;
    }

    public String getText() {
        return text;
    }

    // setter
    public void setName(String name) {
        this.name = name;
    }

    public void setText(String text) {
        this.text = text;
    }
}
