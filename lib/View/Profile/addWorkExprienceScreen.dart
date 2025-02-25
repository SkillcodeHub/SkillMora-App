import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AddWorkExperienceScreen extends StatefulWidget {
  const AddWorkExperienceScreen({super.key});

  @override
  State<AddWorkExperienceScreen> createState() => _AddWorkExperienceScreenState();
}

class _AddWorkExperienceScreenState extends State<AddWorkExperienceScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form Controllers
  final _companyController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _cityController = TextEditingController();
  final _salaryController = TextEditingController();
  final _startDateController = TextEditingController();

  // Dropdown values
  String? isCurrentlyEmployed;
  int? experienceYears;
  int? experienceMonths;
  String? noticePeriod;
  String? selectedIndustry;
  String? selectedDepartment;
  String? selectedRoleCategory;
  String? selectedJobRole;

  // Static Data
  final List<String> employmentStatus = ['Yes', 'No'];
  final List<int> years = List.generate(31, (index) => index);
  final List<int> months = List.generate(12, (index) => index);
  final List<String> noticePeriods = [
    'Immediate',
    '15 Days',
    '30 Days',
    '45 Days',
    '60 Days',
    '90 Days'
  ];

  // Dependent Dropdown Data
  final Map<String, List<String>> industryDepartments = {
    'IT': ['Software Development', 'Quality Assurance', 'DevOps'],
    'Healthcare': ['Medical', 'Nursing', 'Administration'],
    'Finance': ['Banking', 'Insurance', 'Investment'],
  };

  final Map<String, List<String>> departmentRoles = {
    'Software Development': ['Frontend', 'Backend', 'Full Stack'],
    'Quality Assurance': ['Manual Testing', 'Automation Testing'],
    'DevOps': ['Cloud Engineer', 'DevOps Engineer'],
  };

  final Map<String, List<String>> roleJobs = {
    'Frontend': ['React Developer', 'Angular Developer', 'Flutter Developer'],
    'Backend': ['Node.js Developer', 'Python Developer', 'Java Developer'],
    'Full Stack': ['MEAN Stack', 'MERN Stack', 'Full Stack Python'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Add Work Experience',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownField(
                'Are You Currently Employed?',
                employmentStatus,
                isCurrentlyEmployed,
                (value) => setState(() => isCurrentlyEmployed = value),
              ),
              SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      'Experience (Years)',
                      years.map((e) => e.toString()).toList(),
                      experienceYears?.toString(),
                      (value) => setState(() => experienceYears = int.parse(value!)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      'Experience (Months)',
                      months.map((e) => e.toString()).toList(),
                      experienceMonths?.toString(),
                      (value) => setState(() => experienceMonths = int.parse(value!)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              _buildTextField(
                'Previous Company Name',
                _companyController,
                hint: 'Enter company name',
              ),
              SizedBox(height: 16),

              _buildTextField(
                'Previous Job Title',
                _jobTitleController,
                hint: 'Enter job title',
              ),
              SizedBox(height: 16),

              _buildTextField(
                'Current City',
                _cityController,
                hint: 'Enter city name',
              ),
              SizedBox(height: 16),

              _buildTextField(
                'Start Date',
                _startDateController,
                hint: 'Select start date',
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    _startDateController.text = 
                        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                  }
                },
              ),
              SizedBox(height: 16),

              _buildTextField(
                'Previous Salary',
                _salaryController,
                hint: 'Enter salary',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),

              _buildDropdownField(
                'Notice Period',
                noticePeriods,
                noticePeriod,
                (value) => setState(() => noticePeriod = value),
              ),
              SizedBox(height: 16),

              // Dependent Dropdowns
              _buildDropdownField(
                'Industry Type',
                industryDepartments.keys.toList(),
                selectedIndustry,
                (value) {
                  setState(() {
                    selectedIndustry = value;
                    selectedDepartment = null;
                    selectedRoleCategory = null;
                    selectedJobRole = null;
                  });
                },
              ),
              SizedBox(height: 16),

              _buildDropdownField(
                'Department Type',
                selectedIndustry != null 
                    ? industryDepartments[selectedIndustry]! 
                    : [],
                selectedDepartment,
                selectedIndustry == null ? null : (value) {
                  setState(() {
                    selectedDepartment = value;
                    selectedRoleCategory = null;
                    selectedJobRole = null;
                  });
                },
              ),
              SizedBox(height: 16),

              _buildDropdownField(
                'Role Category',
                selectedDepartment != null 
                    ? departmentRoles[selectedDepartment]! 
                    : [],
                selectedRoleCategory,
                selectedDepartment == null ? null : (value) {
                  setState(() {
                    selectedRoleCategory = value;
                    selectedJobRole = null;
                  });
                },
              ),
              SizedBox(height: 16),

              _buildDropdownField(
                'Job Role',
                selectedRoleCategory != null 
                    ? roleJobs[selectedRoleCategory]! 
                    : [],
                selectedJobRole,
                selectedRoleCategory == null ? null : (value) {
                  setState(() => selectedJobRole = value);
                },
              ),
              SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle form submission
                      // You can add your API call here
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
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    String? hint,
    TextInputType? keyboardType,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: GoogleFonts.plusJakartaSans(color: Colors.white),
          keyboardType: keyboardType,
          onTap: onTap,
          readOnly: onTap != null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.plusJakartaSans(
              color: Colors.white38,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    List<String> items,
    String? value,
    void Function(String?)? onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            style: GoogleFonts.plusJakartaSans(color: Colors.white),
            dropdownColor: Colors.black87,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            isExpanded: true,
          ),
        ),
      ],
    );
  }
}