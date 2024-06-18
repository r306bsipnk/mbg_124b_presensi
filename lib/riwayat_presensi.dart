import 'package:flutter/material.dart';

class RiwayatPresensi extends StatelessWidget {
  final List<AttendanceRecord> attendanceRecords = [
    AttendanceRecord(
      date: DateTime(2023, 6, 1),
      status: AttendanceStatus.present,
    ),
    AttendanceRecord(
      date: DateTime(2023, 6, 2), 
      status: AttendanceStatus.absent,
    ),
    AttendanceRecord(
      date: DateTime(2023, 6, 3),
      status: AttendanceStatus.absent,
    ),
    // Tambahkan data riwayat presensi lainnya di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Presensi'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: attendanceRecords.length,
        itemBuilder: (context, index) {
          final record = attendanceRecords[index];
          return ListTile(
            title: Text(
              '${record.date.day}/${record.date.month}/${record.date.year}',
            ),
            trailing: record.status == AttendanceStatus.present
                ? Icon(Icons.check_circle, color: Color.fromARGB(255, 33, 185, 38))
                : Icon(Icons.cancel, color: Colors.red),
          );
        },
      ),
    );
  }
}

enum AttendanceStatus { present, absent }

class AttendanceRecord {
  final DateTime date;
  final AttendanceStatus status;

  AttendanceRecord({required this.date, required this.status});
}
