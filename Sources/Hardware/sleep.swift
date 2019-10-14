import HardwareExt

@inlinable
public func sleep(_ interval: TimeInterval) {
    _hardware_sleep_ms(UInt32(interval))
}
