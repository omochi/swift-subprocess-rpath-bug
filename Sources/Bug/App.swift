import Subprocess

@main
struct App {
    static func main() async throws {
        let result = try await Subprocess.run(
            .name("tar"),
            arguments: ["-cvf", "archive.tar", "Sources/"],
            output: .standardOutput,
            error: .standardError
        )

        guard result.terminationStatus.isSuccess else {
            throw "failed to tar"
        }
    }
}
