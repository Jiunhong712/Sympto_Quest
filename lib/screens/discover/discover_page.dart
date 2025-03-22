import 'package:flutter/material.dart';

const _primaryColor = Color(0xFFD00F00);
const _backgroundColor = Color(0xFFFFD8D9);
const _textPrimary = Color(0xFF43170B);
const _textSecondary = Color(0xFF6B3C2C);

class DiscoverPage extends StatefulWidget {
  final String? initialFilter;
  DiscoverPage({this.initialFilter});

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String _selectedFilter = 'all';
  final List<String> _filterOptions = [
    'all',
    'clinic',
    'hospital',
    'pharmacy',
    'others'
  ];

  final List<Map<String, dynamic>> _clinics = [
    {
      'name': 'Sunway Medical',
      'address': 'Petaling Jaya',
      'type': 'hospital',
      'sponsored': true
    },
    {
      'name': 'Sunway Medical Velocity Centre',
      'address': 'Kuala Lumpur',
      'type': 'hospital',
      'sponsored': false
    },
    {
      'name': 'Trust Clinic',
      'address': 'Cheras',
      'type': 'clinic',
      'sponsored': true
    },
    {
      'name': 'KL Psychology Center',
      'address': 'Kuala Lumpur',
      'type': 'clinic',
      'sponsored': false
    },
    {
      'name': 'Guardian Pharmacy',
      'address': 'Bukit Bintang',
      'type': 'pharmacy',
      'sponsored': true
    },
    {
      'name': 'Traditional Wellness',
      'address': 'Puchong',
      'type': 'others',
      'sponsored': false
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter ?? 'all';
  }

  @override
  Widget build(BuildContext context) {
    final filteredClinics = _selectedFilter == 'all'
        ? _clinics
        : _clinics
            .where((clinic) => clinic['type'] == _selectedFilter)
            .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover', style: TextStyle(color: Colors.white)),
        backgroundColor: _primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: _backgroundColor,
      body: Column(
        children: [
          _buildSegmentedFilter(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: filteredClinics.length,
              itemBuilder: (context, index) => _ClinicTile(
                clinic: filteredClinics[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedFilter() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _primaryColor.withOpacity(0.3)),
        ),
        child: Row(
          children: List.generate(_filterOptions.length, (index) {
            final filter = _filterOptions[index];
            final isSelected = _selectedFilter == filter;
            final isFirst = index == 0;
            final isLast = index == _filterOptions.length - 1;

            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedFilter = filter),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? _primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.horizontal(
                      left: isFirst ? Radius.circular(8) : Radius.zero,
                      right: isLast ? Radius.circular(8) : Radius.zero,
                    ),
                    border: Border.all(
                      color: _primaryColor.withOpacity(0.3),
                      width: 0.5,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    filter[0].toUpperCase() + filter.substring(1),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : _textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _ClinicTile extends StatelessWidget {
  final Map<String, dynamic> clinic;
  _ClinicTile({required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(Icons.local_hospital, color: _primaryColor),
        title: Text(clinic['name'], style: TextStyle(color: _textPrimary)),
        subtitle:
            Text(clinic['address'], style: TextStyle(color: _textSecondary)),
        trailing: clinic['sponsored']
            ? Chip(
                label: Text('Sponsored', style: TextStyle(color: Colors.white)),
                backgroundColor: _primaryColor,
              )
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
