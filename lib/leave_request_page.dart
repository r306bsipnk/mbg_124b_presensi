import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaveRequestPage extends StatefulWidget {
  @override
  _LeaveRequestPageState createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String employeeId = '';
  String _leaveType = 'Cuti Tahunan';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 1));

  void _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue[700],
            hintColor: Colors.blue[700],
            colorScheme: ColorScheme.light(primary: Colors.blue[700]!),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null)
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate.isBefore(_startDate)) {
            _endDate = _startDate.add(Duration(days: 1));
          }
        } else {
          _endDate = picked;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengajuan Cuti', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[700]!, Colors.blue[50]!],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Formulir Cuti', style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 24),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Nama Lengkap',
                            labelStyle: GoogleFonts.poppins(),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          style: GoogleFonts.poppins(),
                          validator: (value) => value?.isEmpty == true ? 'Nama tidak boleh kosong' : null,
                          onSaved: (value) => name = value!,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'ID Karyawan',
                            labelStyle: GoogleFonts.poppins(),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          style: GoogleFonts.poppins(),
                          keyboardType: TextInputType.number,
                          validator: (value) => value?.isEmpty == true ? 'ID Karyawan tidak boleh kosong' : null,
                          onSaved: (value) => employeeId = value!,
                        ),
                        SizedBox(height: 24),
                        Text('Jenis Cuti', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500)),
                        ...['Cuti Tahunan', 'Cuti Sakit', 'Lainnya'].map((type) => RadioListTile(
                          title: Text(type, style: GoogleFonts.poppins()),
                          value: type,
                          groupValue: _leaveType,
                          onChanged: (value) => setState(() => _leaveType = value.toString()),
                        )),
                        SizedBox(height: 24),
                        Text('Tanggal Cuti', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500)),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _selectDate(context, true),
                                icon: Icon(Icons.calendar_today),
                                label: Text('Mulai: ${DateFormat('dd/MM/yyyy').format(_startDate)}', style: GoogleFonts.poppins()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[600],
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _selectDate(context, false),
                                icon: Icon(Icons.calendar_today),
                                label: Text('Selesai: ${DateFormat('dd/MM/yyyy').format(_endDate)}', style: GoogleFonts.poppins()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[600],
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Proses pengajuan cuti di sini
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Pengajuan Cuti Berhasil', style: GoogleFonts.poppins())),
                        );
                      }
                    },
                    child: Text('Ajukan Cuti', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}