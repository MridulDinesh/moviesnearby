import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserViewShow extends StatefulWidget {
  const UserViewShow({Key? key, required this.docId}) : super(key: key);
  final String docId;

  @override
  _UserViewShowState createState() => _UserViewShowState();
}

class _UserViewShowState extends State<UserViewShow> {
  List<String> uniqueDates = []; // Initialize uniqueDates with an empty list
  String selectedDate = ''; // Selected date

  @override
  void initState() {
    super.initState();
    _fetchUniqueDates(); // Fetch unique dates when the widget initializes
  }

  // Fetch unique dates from Firestore
  Future<void> _fetchUniqueDates() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection("films2")
        .doc(widget.docId)
        .collection("shows")
        .get();

    // Extract unique dates
    final List<String> dates = snapshot.docs.map((doc) => doc['date'] as String).toSet().toList();

    setState(() {
      uniqueDates = dates;
      if (dates.isNotEmpty) {
        selectedDate = dates.first; // Set the first date as selected by default
      }
    });
  }

  // Fetch shows for the selected date
  Future<void> _fetchShowsForSelectedDate(String date) async {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: selectedDate,
          onChanged: (String? newValue) {
            if (newValue != null) {
              _fetchShowsForSelectedDate(newValue); // Fetch shows for the selected date
            }
          },
          items: uniqueDates
              .map((date) => DropdownMenuItem<String>(
            value: date,
            child: Text(date),
          ))
              .toList(),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("films2")
                .doc(widget.docId)
                .collection("shows")
                .where('date', isEqualTo: selectedDate) // Filter by selected date
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Handle errors gracefully
              }

              if (!snapshot.hasData) {
                return const Text("No data");
              }

              final showDocs = snapshot.data!.docs;
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: showDocs.length,
                  itemBuilder: (context, index) {
                    final showData = showDocs[index].data(); // Get document data
                    final documentId = showDocs[index].id; // Get document ID

                    return GestureDetector(
                      onTap: () => _showTicketDialog(context, documentId, showData['numberOfTickets'], showData),

                      child: Row(
                        children: [
                          // Item with black border
                          Card(
                            elevation: 4, // Add elevation for shadow effect
                            shadowColor: Colors.grey, // Set shadow color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // Add border radius for rounded corners
                            ),
                            child: Container(
                              padding: EdgeInsets.all(12), // Add padding for better appearance
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                                children: [
                                  Text('Date: ${showData['date']}', style: TextStyle(color: Colors.green)), // Setting text color to cyan
                                  Text('Tickets: ${showData['numberOfTickets']}', style: TextStyle(color: Colors.green)), // Setting text color to cyan
                                  Text('Theatre: ${showData['theatre']}', style: TextStyle(color: Colors.green)), // Setting text color to cyan
                                  Text('Time: ${showData['time']}', style: TextStyle(color: Colors.green)), // Setting text color to cyan
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showTicketDialog(BuildContext context, String documentId, int currentTickets, Map<String, dynamic> showData) {
    final TextEditingController ticketController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Book Tickets'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ticketController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter number of tickets',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                int? newTicketCount = int.tryParse(ticketController.text);
                if (newTicketCount != null && newTicketCount >= 0) {
                  // Update show document with new ticket count (ensure it's non-negative)
                  _updateTicketCount(documentId, currentTickets - newTicketCount);
                  // Pass show data along with the ticket count to create ticket details
                  _createTicketDetails(newTicketCount, showData);
                  Navigator.pop(context); // Close dialog after updates
                } else {
                  // Show error message if invalid input
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid number of tickets (non-negative).'),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _createTicketDetails(int newTicketCount, Map<String, dynamic> showData) async {
    // Generate a unique document ID for the new ticket details document
    final String ticketDetailsId = FirebaseFirestore.instance.collection('TICKET_DETAILS').doc().id;

    // Retrieve the movie name from the Firestore document referenced by docId
    final DocumentSnapshot<Map<String, dynamic>> movieSnapshot =
    await FirebaseFirestore.instance.collection('films2').doc(widget.docId).get();
    final String? movieName = movieSnapshot.data()?['name'];

    // Create a new document in the TICKET_DETAILS collection with the following fields:
    await FirebaseFirestore.instance.collection('TICKET_DETAILS').doc(ticketDetailsId).set({
      'numberOfTickets': newTicketCount,
      'date': showData['date'],
      'theatre': showData['theatre'],
      'time': showData['time'],
      'userId': FirebaseAuth.instance.currentUser?.uid, // Assuming you are using FirebaseAuth for user authentication
      'movieName': movieName, // Store the movie name
      // Add any other relevant fields for ticket details here,
      // such as timestamp, user ID, etc.
    });

    print('Successfully created ticket details document with ID: $ticketDetailsId');
  }

  void _updateTicketCount(String documentId, int newTicketCount) async {
    // Update Firebase with new ticket count (ensure it's non-negative)
    if (newTicketCount >= 0) {
      await FirebaseFirestore.instance
          .collection("films2")
          .doc(widget.docId)
          .collection("shows")
          .doc(documentId)
          .update({'numberOfTickets': newTicketCount});
    }
  }
}
