import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _projectNameController = TextEditingController();
  final _urlController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  
  String _selectedStatus = 'Not Started';
  DateTime? _startDate;
  DateTime? _endDate;

  List<String> statusOptions = ['Not Started', 'In Progress', 'Finished'];

  @override
  void dispose() {
    _projectNameController.dispose();
    _urlController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFFCCFF00),
              onPrimary: Colors.black,
              surface: Color(0xFF1C1C1E),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _startDateController.text = DateFormat('MMM dd, yyyy').format(picked);
        } else {
          _endDate = picked;
          _endDateController.text = DateFormat('MMM dd, yyyy').format(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Add Project',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Project Name'),
                _buildTextField(
                  controller: _projectNameController,
                  hintText: 'Enter a Project Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter project name';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 20),
                _buildLabel('Url'),
                _buildTextField(
                  controller: _urlController,
                  hintText: 'Enter a Url',
                ),
                
                SizedBox(height: 20),
                _buildLabel('Description'),
                _buildTextField(
                  controller: _descriptionController,
                  hintText: 'Enter a Description',
                  maxLines: 4,
                ),
                
                SizedBox(height: 20),
                _buildLabel('Status'),
                _buildDropdown(),
                
                if (_selectedStatus == 'In Progress' || _selectedStatus == 'Finished') ...[
                  SizedBox(height: 20),
                  _buildLabel('Start Date'),
                  _buildDateField(true),
                ],
                
                if (_selectedStatus == 'Finished') ...[
                  SizedBox(height: 20),
                  _buildLabel('End Date'),
                  _buildDateField(false),
                ],
                
                SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission
                        final projectData = {
                          'projectName': _projectNameController.text,
                          'url': _urlController.text,
                          'description': _descriptionController.text,
                          'status': _selectedStatus,
                          'startDate': _startDateController.text,
                          'endDate': _endDateController.text,
                        };
                        // Add your API call here
                        Navigator.pop(context, projectData);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFCCFF00),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Save And Continue',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white.withOpacity(0.7),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.plusJakartaSans(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.plusJakartaSans(
          color: Colors.white.withOpacity(0.3),
        ),
        filled: true,
        fillColor: Color(0xFF1C1C1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedStatus,
          isExpanded: true,
          dropdownColor: Color(0xFF1C1C1E),
          style: GoogleFonts.plusJakartaSans(color: Colors.white),
          items: statusOptions.map((String status) {
            return DropdownMenuItem<String>(
              value: status,
              child: Text(status),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedStatus = newValue;
                // Clear dates if status changes
                if (newValue == 'Not Started') {
                  _startDateController.clear();
                  _endDateController.clear();
                  _startDate = null;
                  _endDate = null;
                }
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildDateField(bool isStartDate) {
    return TextFormField(
      controller: isStartDate ? _startDateController : _endDateController,
      readOnly: true,
      style: GoogleFonts.plusJakartaSans(color: Colors.white),
      decoration: InputDecoration(
        hintText: isStartDate ? 'Select Start Date' : 'Select End Date',
        hintStyle: GoogleFonts.plusJakartaSans(
          color: Colors.white.withOpacity(0.3),
        ),
        filled: true,
        fillColor: Color(0xFF1C1C1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: Icon(Icons.calendar_today, color: Colors.white),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onTap: () => _selectDate(context, isStartDate),
    );
  }
}