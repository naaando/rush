public class Pomodoro.DefaultSequencer : Object, Sequencer {
    public int normal_breaks_before_long_break { get; set; default = 4; }
    State[] history;

    public void push_state (State state) {
        history += state;
    }

    public void pop_state () {
        if (history.length > 0) {
            history = history[0:-1];
        }
    }

    public State next_state () {
        if (history.length < 1) {
            return State.WORKING;
        }

        var last_state = history[history.length-1];

        if (last_state == State.WORKING) {
            return is_long_break () ? State.LONG_BREAK : State.SHORT_BREAK;
        }

        return State.WORKING;
    }

    public State[] states_history () {
        return history;
    }

    protected virtual bool is_long_break () {
        var short_breaks = count_states (State.SHORT_BREAK, history[-10:history.length]);
        var long_breaks = count_states (State.LONG_BREAK, history[-10:history.length]);

        return short_breaks >= normal_breaks_before_long_break * (long_breaks+1);
    }

    public int count_states (State counted_state, State[] states) {
        int count = 0;
        foreach (var item in states) {
            if (item == counted_state) {
                count++;
            }
        }

        return count;
    }
}
