public interface Pomodoro.Sequencer : Object {
    public abstract void push_state (State state);
    public abstract void pop_state ();
    public abstract State next_state ();
    public abstract State[] states_history ();
    public abstract int count_states (State counted_state, State[] states);
}
