package sample.text.l2_.model;

import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.TreeMap;
import java.util.Optional;

public class Consult {
    private ArrayList<Answer> answers;
    private ArrayList<Influence> influences;
    private ArrayList<Fact> facts;
    private TreeMap<Float, String> sorted_cfg;

    public Consult(ArrayList<Fact> facts) {
        this.facts = facts;
        this.answers = Answer.getAnswersFromDB();
        this.influences = Influence.getInfluencesFromDB();
    }

	public ArrayList<Fact> getFacts() {
		return facts;
	}

	public TreeMap<Float, String> getSorted_cfg() {
        if (sorted_cfg == null) {
            throw new IllegalStateException("Call analyze() first");
        }
		return sorted_cfg;
	}

    public int analyze() {
        HashMap<String, Float> result_cfg = new HashMap<>();

        for (Answer ans : answers) {
            float coef_sum = 0;
            int positive_count = 0;
            for (Fact fact : facts) {
                Optional<Influence> a = influences.stream().filter(i -> i.getAnswer_id() == ans.getId() &&
                    i.getQuestion_id() == fact.getId()).findFirst();
                if (a.isPresent()) {
                    Influence i = a.get();
                    coef_sum += i.getInfluence_coef() * fact.getTrust_coef();
                    positive_count++;
                }
            }
            if (positive_count > 0) {
                result_cfg.put(ans.getText(), coef_sum / positive_count);
            }
        }

        Float min_value = result_cfg.values().stream().min(Float::compareTo).orElse(Float.MAX_VALUE);
        Float max_value = result_cfg.values().stream().max(Float::compareTo).orElse(Float.MIN_VALUE);

        for (String key : result_cfg.keySet()) {
            result_cfg.put(key, (result_cfg.get(key) - min_value) / (max_value - min_value));
        }

        sorted_cfg = new TreeMap<> ();
        for(Map.Entry<String, Float> entry : result_cfg.entrySet()) {
            sorted_cfg.put(entry.getValue(), entry.getKey());
        }

        return 0;
    }
}
