import 'package:logger/logger.dart';

// late FileOutput fileOutPut;
// late ConsoleOutput consoleOutput;

Logger applogger(Type type) {
  // List<LogOutput> multiOutput = [consoleOutput];
  return Logger(
    printer: CustomPrinter(type.toString()),
    // output: MultiOutput(multiOutput),
    filter: DevelopmentFilter(),
  );
}

class CustomPrinter extends LogPrinter {
  CustomPrinter(this.className);
  final String className;

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter().levelColors?[event.level];
    final emoji = PrettyPrinter().levelEmojis?[event.level];
    final messageStr = event.message.toString();
    final errorStr = event.error?.toString() ?? '';
    final stackTraceStr = event.stackTrace?.toString() ?? '';
    if (color != null) {
      return [
        color('$emoji $className - $messageStr $errorStr $stackTraceStr')
      ];
    }
    return ['$emoji $className - $messageStr $errorStr $stackTraceStr'];
  }
}
