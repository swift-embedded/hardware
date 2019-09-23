

public protocol SPI {
    func transmit(_ data: ContiguousArray<UInt8>) throws
}
