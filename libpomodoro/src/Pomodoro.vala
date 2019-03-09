public class Pomodoro.Pomodoro : Object {
    public int id { get; set; }
    public string session { get; set; }
    public string? task { get; set; }
    public DateTime start_date { get; set; }
    public DateTime? end_date { get; set; }
    public State state { get; set; }

    public Pomodoro (State pomodoro_state) {
        start_date = new DateTime.now_utc ();
        state = pomodoro_state;
    }

    public void end () {
        end_date = new DateTime.now_utc ();
    }

    public bool is_complete () {
        return end_date != null;
    }

    public int64 elapsed () {
        return (end_date ?? new DateTime.now_utc ()).difference (start_date);
    }
}
