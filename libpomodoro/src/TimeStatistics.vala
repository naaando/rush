public class Pomodoro.TimeStatistics : Object {
    Gee.HashMap<State, uint> time_per_state = new Gee.HashMap<State, uint> ();

    public TimeStatistics () {
        time_per_state[State.WORKING] = 0;
        time_per_state[State.SHORT_BREAK] = 0;
        time_per_state[State.LONG_BREAK] = 0;
    }

    public void add (State state, uint time_in_ms) {
        time_per_state[state] = time_per_state[state] + time_in_ms;
    }

    public uint get_time_in_ms (State state) {
        return time_per_state[state];
    }
}
