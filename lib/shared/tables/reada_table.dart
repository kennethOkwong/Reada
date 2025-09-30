import 'package:flutter/material.dart';

class ReadaTable extends StatelessWidget {
  final List<String> headers;
  final List<List<Widget>> rows;
  final TextStyle? headerStyle;
  final double rowHeight;

  const ReadaTable({
    super.key,
    required this.headers,
    required this.rows,
    this.headerStyle,
    this.rowHeight = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Headers
          Container(
            height: rowHeight,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: headers
                  .map(
                    (h) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          h,
                          style: headerStyle ??
                              const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          // Rows
          ...rows.map(
            (r) => Container(
              height: rowHeight,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Row(
                children: r
                    .map(
                      (c) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: c,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
