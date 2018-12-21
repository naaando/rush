public class Pomodoro.History : Gee.ArrayList<Pomodoro> {
    public void push (Pomodoro pomodoro) {
        add (pomodoro);
    }

    public void pop () {
        remove (last ());
    }

    public int count_by_states (State state) {
        return filter_by_state(state).length;
    }

    public int time_by_state (State state) {
        return filter_by_state (state).
    }

    public int filter_by_state (State state) {
        return filter (p => p.state == state);
    }
}
