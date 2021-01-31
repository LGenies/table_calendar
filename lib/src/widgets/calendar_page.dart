// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

part of table_calendar;

class _CalendarPage extends StatelessWidget {
  final List<DateTime> visibleDays;
  final DayBuilder dowBuilder;
  final DayBuilder dayBuilder;
  final Decoration dowDecoration;
  final Decoration rowDecoration;
  final bool dowVisible;

  const _CalendarPage({
    Key key,
    @required this.visibleDays,
    this.dowBuilder,
    @required this.dayBuilder,
    this.dowDecoration,
    this.rowDecoration,
    this.dowVisible = true,
  })  : assert(!dowVisible || dowBuilder != null),
        assert(dayBuilder != null),
        assert(visibleDays != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        if (dowVisible) _buildDaysOfWeek(context),
        ..._buildCalendarDays(context),
      ],
    );
  }

  TableRow _buildDaysOfWeek(BuildContext context) {
    return TableRow(
      decoration: dowDecoration,
      children: List.generate(
        7,
        (index) => dowBuilder(context, visibleDays[index]),
      ).toList(),
    );
  }

  List<TableRow> _buildCalendarDays(BuildContext context) {
    final rowAmount = visibleDays.length ~/ 7;

    return List.generate(rowAmount, (index) => index * 7)
        .map((index) => TableRow(
              decoration: rowDecoration,
              children: List.generate(
                7,
                (id) => dayBuilder(context, visibleDays[index + id]),
              ),
            ))
        .toList();
  }
}