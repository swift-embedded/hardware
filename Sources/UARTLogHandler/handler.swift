import Glibc
import Hardware
import Logging

public struct UARTLogHandler: LogHandler {
    public let uart: Hardware.UART

    public var logLevel: Logger.Level = .info

    private var prettyMetadata: String?

    public var metadata = Logger.Metadata() {
        didSet { prettyMetadata = prettify(metadata) }
    }

    public subscript(metadataKey metadataKey: String) -> Logger.Metadata.Value? {
        get { metadata[metadataKey] }
        set { metadata[metadataKey] = newValue }
    }

    public init(label _: String, uart: Hardware.UART) {
        self.uart = uart
    }

    public func log(level: Logger.Level,
                    message: Logger.Message,
                    metadata: Logger.Metadata?,
                    file _: String, function _: String, line _: UInt) {
        let prettyMetadata = metadata?.isEmpty ?? true
            ? self.prettyMetadata
            : prettify(self.metadata.merging(metadata!, uniquingKeysWith: { _, new in new }))

        let msg = "\(timestamp()) \(level):\(prettyMetadata.map { " \($0)" } ?? "") \(message)\r\n"
        try? uart.write(msg)
    }

    private func prettify(_ metadata: Logger.Metadata) -> String? {
        return !metadata.isEmpty ? metadata.map { "\($0)=\($1)" }.joined(separator: " ") : nil
    }

    private func timestamp() -> String {
        var timeOfDay = timeval()
        guard gettimeofday(&timeOfDay, nil) == 0 else {
            return "??s"
        }
        return "\(timeOfDay.tv_sec).\(timeOfDay.tv_usec / 1000)s"
    }
}
