import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:los_pollos_hermanos/models/opening_hours.dart';
import 'package:los_pollos_hermanos/models/restaurant.dart';
import 'package:los_pollos_hermanos/models/time_interval.dart';

class RestaurantItem extends StatefulWidget {
  final Restaurant restaurant;
  final Color? color;

  const RestaurantItem({super.key, required this.restaurant, this.color});

  @override
  State<RestaurantItem> createState() => _RestaurantItemState();
}

class _RestaurantItemState extends State<RestaurantItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Card(
        color: widget.color,
        child: Column(
          children: [
            _nameAndStatus(),
            const SizedBox(height: 5),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              firstChild: _longDescription(),
              secondChild: _shortDescription(),
              crossFadeState: expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameAndStatus() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.restaurant.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _openedClosedText(widget.restaurant),
        ],
      ),
    );
  }

  Widget _shortDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurant.description,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Today: ${_formatOpeningHours(
                    widget.restaurant.todayHours(),
                    context,
                  )}",
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => setState(() => expanded = true),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _longDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurant.description,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Today: ${_formatOpeningHours(
                    widget.restaurant.todayHours(),
                    context,
                  )}",
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                const Text(
                  "Opening Hours",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ..._allOpeningHours(widget.restaurant.openingHours),
                const SizedBox(height: 5),
                const Text(
                  "Contact Information",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Telephone: ${widget.restaurant.telephone}"),
                Text("Email: ${widget.restaurant.email}"),
              ],
            ),
          ),
          IconButton(
            onPressed: () => setState(() => expanded = false),
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  List<Widget> _allOpeningHours(OpeningHours oh) {
    final List<Text> result = [];
    final intervals = [
      oh.monday,
      oh.tuesday,
      oh.wednesday,
      oh.thursday,
      oh.friday,
      oh.saturday,
      oh.sunday
    ];
    List<String> days = [
      ...DateFormat.EEEE().dateSymbols.STANDALONESHORTWEEKDAYS
    ]; // unmodifiable list workaround
    // days starts with sunday by default
    var sun = days[0];
    days.removeAt(0);
    days.add(sun);
    intervals.asMap().forEach(
      (index, interval) {
        var text = "${days[index]}: ${_formatOpeningHours(interval, context)}";
        result.add(
          Text(
            text,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
    return result;
  }

  String _formatOpeningHours(TimeInterval? interval, context) {
    if (interval == null) {
      return "Closed";
    }
    return "${interval.start.format(context)} to ${interval.end.format(context)}";
  }

  Widget _openedClosedText(Restaurant restaurant) {
    return restaurant.isOpened()
        ? const Text(
            "Opened",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          )
        : const Text(
            "Closed",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          );
  }
}
