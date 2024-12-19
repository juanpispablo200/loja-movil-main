import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/model/schedule.dart';

class ScheduleColumnList extends StatelessWidget {
  final List<Schedule> scheduleList;

  const ScheduleColumnList({super.key, required this.scheduleList});

  @override
  Widget build(BuildContext context) {
    // Ordenar la lista de horarios por el nombre del día
    final orderedScheduleList = _orderSchedulesByDay(scheduleList);

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: orderedScheduleList
            .map((schedule) => _buildScheduleRow(schedule))
            .toList(),
      ),
    );
  }

  Widget _buildScheduleRow(Schedule schedule) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              schedule.day ?? 'Desconocido',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              formatSchedule(schedule),
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }

  String formatSchedule(Schedule schedule) {
    String formatTime(String? time) {
      if (time == null || time.isEmpty) return '';
      return time.substring(0, 5); // Recorta los segundos (HH:mm:ss -> HH:mm)
    }

    List<String> timeSlots = [];

    if (schedule.openingTime1 != null && schedule.closingTime1 != null) {
      timeSlots.add(
          '${formatTime(schedule.openingTime1)} - ${formatTime(schedule.closingTime1)}');
    } else if (schedule.openingTime1 != null && schedule.closingTime2 != null) {
      timeSlots.add(
          '${formatTime(schedule.openingTime1)} - ${formatTime(schedule.closingTime2)}');
    }

    if (schedule.openingTime2 != null && schedule.closingTime2 != null) {
      timeSlots.add(
          '${formatTime(schedule.openingTime2)} - ${formatTime(schedule.closingTime2)}');
    }

    return timeSlots.isNotEmpty
        ? timeSlots.join(' | ')
        : 'Horario no disponible';
  }

  List<Schedule> _orderSchedulesByDay(List<Schedule> schedules) {
    final dayOrder = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo',
    ];

    schedules.sort((a, b) {
      final indexA = dayOrder.indexOf(a.day ?? '');
      final indexB = dayOrder.indexOf(b.day ?? '');
      return indexA.compareTo(indexB);
    });

    return schedules;
  }
}
