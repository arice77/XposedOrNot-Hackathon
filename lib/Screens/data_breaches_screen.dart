import 'package:flutter/material.dart';
import 'package:xpose/Services/api_service.dart';

class DataBreachScreen extends StatefulWidget {
  const DataBreachScreen({super.key});
  static const routeName = '/dataBreachScreen';

  @override
  State<DataBreachScreen> createState() => _DataBreachScreenState();
}

class _DataBreachScreenState extends State<DataBreachScreen> {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>>? json;
  List<Map<String, dynamic>>? filteredJson;
  TextEditingController searchController = TextEditingController();

  getBreaches() async {
    json = await _apiService.getAllDataBreaches();
    filteredJson = json;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getBreaches();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Map<String, dynamic>> tempList = [];
      for (var breach in json!) {
        if (breach['Domain'].toLowerCase().contains(query.toLowerCase())) {
          tempList.add(breach);
        }
      }
      setState(() {
        filteredJson = tempList;
      });
      return;
    } else {
      setState(() {
        filteredJson = json;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        title: TextField(
  controller: searchController,
  onChanged: (value) {
    filterSearchResults(value);
  },
  style: const TextStyle(color: Colors.white),
  decoration: InputDecoration(
    hintText: 'Search by Domain',
    hintStyle: const TextStyle(color: Colors.white),
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    suffixIcon: IconButton(
      icon: const Icon(
        Icons.search,
        color: Colors.white,
      ),
      onPressed: () {
        // Perform search action here
      },
    ),
  ),
),

      ),
      body: filteredJson == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredJson!.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          title: Text(filteredJson![index]['Domain']),
                          children: [
                            BreachCard(breachDetails: filteredJson![index]),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class BreachCard extends StatelessWidget {
  final Map<String, dynamic> breachDetails;

  const BreachCard({Key? key, required this.breachDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Breach ID: ${breachDetails["Breach ID"]}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Breached Date: ${breachDetails["Breached Date"]}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Domain: ${breachDetails["Domain"]}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Exposed Data: ${breachDetails["Exposed Data"]}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Exposed Records: ${breachDetails["Exposed Records"]}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Exposure Description: ${breachDetails["Exposure Description"]}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Industry: ${breachDetails["Industry"]}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Password Risk: ${breachDetails["Password Risk"]}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Searchable: ${breachDetails["Searchable"]}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Sensitive: ${breachDetails["Sensitive"]}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Verified: ${breachDetails["Verified"]}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
