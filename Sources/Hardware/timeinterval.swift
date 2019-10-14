/// Represents time interval in milliseconds.
public typealias TimeInterval = UInt

extension TimeInterval {
    @inlinable
    public static func seconds(_ value: UInt) -> TimeInterval {
        return value * 1000
    }

    @inlinable
    public static func milliseconds(_ value: UInt) -> TimeInterval {
        return value
    }
}
