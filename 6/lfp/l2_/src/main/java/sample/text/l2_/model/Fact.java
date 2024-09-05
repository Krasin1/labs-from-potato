package sample.text.l2_.model;

public class Fact {
    private int id;
    private String text;
    private float trust_coef;
    private boolean is_positive;

    public Fact(int id, String text, float trust_coef, boolean is_positive) {
        this.id = id;
        this.text = text;
        this.trust_coef = trust_coef;
        this.is_positive = is_positive;
    }

    public Fact(Question question, boolean is_positive) {
        this.id = question.getId();
        this.text = question.getText();
        this.trust_coef = question.getTrust_coef();
        this.is_positive = is_positive;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public float getTrust_coef() {
        return trust_coef;
    }

    public void setTrust_coef(float trust_coef) {
        this.trust_coef = trust_coef;
    }

    public boolean isIs_positive() {
        return is_positive;
    }

    public void setIs_positive(boolean is_positive) {
        this.is_positive = is_positive;
    }

}
