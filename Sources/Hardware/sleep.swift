import HardwareExt

public func sleep(ms: Int) {
    _sleep_ms(UInt32(ms))
}
