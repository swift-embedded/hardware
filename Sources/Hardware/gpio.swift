
public enum PinState {
    case low
    case high
}

public protocol DigitalIn {
    func get() -> PinState
}

public protocol DigitalOut {
    func set(_ value: PinState)
}

public protocol ToggleableDigitalOut: DigitalOut {
    func toggle()
}

public protocol StatefulDigitalOut: DigitalOut {
    func get() -> PinState
}
