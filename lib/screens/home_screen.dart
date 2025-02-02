import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Name';
  final List<String> _filterOptions = [
    'Name',
    'Company',
    'Graduation Year',
    'Skills',
    'Location',
    'Degree'
  ];

  // Dummy data for demonstration
  final List<Map<String, dynamic>> _alumni = [
    {
      'name': 'John Doe',
      'image': 'https://picsum.photos/200',
      'company': 'Google',
      'designation': 'Senior Software Engineer',
      'graduationYear': '2018',
      'degree': 'B.Tech Computer Science',
      'location': 'San Francisco, USA',
      'skills': ['Flutter', 'Firebase', 'Python', 'Machine Learning'],
    },
    {
      'name': 'Jane Smith',
      'image': 'https://picsum.photos/201',
      'company': 'Microsoft',
      'designation': 'Product Manager',
      'graduationYear': '2019',
      'degree': 'B.Tech Electronics',
      'location': 'Seattle, USA',
      'skills': ['Product Management', 'Agile', 'Leadership'],
    },
    // Add more dummy data as needed
  ];

  List<Map<String, dynamic>> _filteredAlumni = [];

  @override
  void initState() {
    super.initState();
    _filteredAlumni = _alumni;
  }

  void _filterAlumni(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredAlumni = _alumni;
      });
      return;
    }

    setState(() {
      _filteredAlumni = _alumni.where((alumni) {
        switch (_selectedFilter) {
          case 'Name':
            return alumni['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase());
          case 'Company':
            return alumni['company']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase());
          case 'Graduation Year':
            return alumni['graduationYear']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase());
          case 'Skills':
            return (alumni['skills'] as List).any((skill) =>
                skill.toString().toLowerCase().contains(query.toLowerCase()));
          case 'Location':
            return alumni['location']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase());
          case 'Degree':
            return alumni['degree']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase());
          default:
            return false;
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alunet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // TODO: Navigate to profile page
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search alumni...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: _filterAlumni,
                      ),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: _selectedFilter,
                      items: _filterOptions.map((String filter) {
                        return DropdownMenuItem<String>(
                          value: filter,
                          child: Text(filter),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedFilter = newValue;
                          });
                          _filterAlumni(_searchController.text);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredAlumni.length,
              itemBuilder: (context, index) {
                final alumni = _filteredAlumni[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(alumni['image']),
                    ),
                    title: Text(alumni['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${alumni['designation']} at ${alumni['company']}'),
                        Text(alumni['location']),
                        Wrap(
                          spacing: 4,
                          children: (alumni['skills'] as List)
                              .take(3)
                              .map((skill) => Chip(
                                    label: Text(
                                      skill,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                    onTap: () {
                      // TODO: Navigate to alumni detail page
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement post creation
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
