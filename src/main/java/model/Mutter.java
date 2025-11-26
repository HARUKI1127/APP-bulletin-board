package model;

import java.sql.Timestamp;

public class Mutter {
    private int id;
    private String name;
    private String text;
    private Timestamp timestamp;

    // DBから取得用
    public Mutter(int id, String name, String text, Timestamp timestamp) {
        this.id = id;
        this.name = name;
        this.text = text;
        this.timestamp = timestamp;
    }

    // 投稿用
    public Mutter(String name, String text) {
        this.name = name;
        this.text = text;
    }

    // 更新用
    public Mutter(int id, String name, String text) {
        this.id = id;
        this.name = name;
        this.text = text;
    }

    // getter
    public int getId() { return id; }
    public String getName() { return name; }
    public String getText() { return text; }
    public Timestamp getTimestamp() { return timestamp; }

    // setter
    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setText(String text) { this.text = text; }
    public void setTimestamp(Timestamp timestamp) { this.timestamp = timestamp; }
}

