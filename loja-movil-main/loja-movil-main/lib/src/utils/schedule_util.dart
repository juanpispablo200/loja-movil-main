import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/model/schedule.dart';

bool isOpenNow(List<Schedule> scheduleList) {
  final now = DateTime.now();
  final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);
  final currentDay = _getDayOfWeek(now.weekday);

  // Buscar el horario para el día actual
  final scheduleForToday = scheduleList.firstWhere(
    (schedule) => schedule.day == currentDay,
    orElse: () => Schedule(
      id: 0,
      day: currentDay,
      isActive: false,
    ),
  );

  // Si no hay horario activo para el día actual, asumir que está cerrado
  if (!scheduleForToday.isActive) {
    return false;
  }

  // Verificar las diferentes combinaciones de horarios
  if (scheduleForToday.openingTime1 != null &&
      scheduleForToday.closingTime2 != null) {
    // Si `openingTime1` y `closingTime2` están presentes, comprobar ambos rangos
    return isTimeInRange(currentTime, scheduleForToday.openingTime1,
        scheduleForToday.closingTime2);
  } else if (scheduleForToday.openingTime1 != null &&
      scheduleForToday.closingTime1 != null) {
    // Si `openingTime1` y `closingTime1` están presentes, comprobar el primer rango
    return isTimeInRange(currentTime, scheduleForToday.openingTime1,
        scheduleForToday.closingTime1);
  } else if (scheduleForToday.openingTime2 != null &&
      scheduleForToday.closingTime2 != null) {
    // Si `openingTime2` y `closingTime2` están presentes, comprobar el segundo rango
    return isTimeInRange(currentTime, scheduleForToday.openingTime2,
        scheduleForToday.closingTime2);
  }

  // Si no hay horarios válidos, retornar cerrado
  return false;
}


bool isTimeInRange(TimeOfDay currentTime, String? initHour, String? endHour) {
  if (initHour == null || endHour == null) {
    return false; // Revisar ambos deben estar presentes
  }

  final initTime = parseTimeOfDay(initHour);
  final endTime = parseTimeOfDay(endHour);

  final currentMinutes = currentTime.hour * 60 + currentTime.minute;
  final initMinutes = initTime.hour * 60 + initTime.minute;
  final endMinutes = endTime.hour * 60 + endTime.minute;

  // Verificar si el rango cruza la medianoche
  if (endMinutes < initMinutes) {
    // Caso en que el horario cruza la medianoche
    return (currentMinutes >= initMinutes || currentMinutes < endMinutes);
  } else {
    // Caso normal donde el cierre es mayor que la apertura
    return (currentMinutes >= initMinutes && currentMinutes <= endMinutes);
  }
}

TimeOfDay parseTimeOfDay(String timeString) {
  final parts = timeString.split(":");
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}

String _getDayOfWeek(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'Lunes';
    case DateTime.tuesday:
      return 'Martes';
    case DateTime.wednesday:
      return 'Miércoles';
    case DateTime.thursday:
      return 'Jueves';
    case DateTime.friday:
      return 'Viernes';
    case DateTime.saturday:
      return 'Sábado';
    case DateTime.sunday:
      return 'Domingo';
    default:
      return 'Desconocido';
  }
}
