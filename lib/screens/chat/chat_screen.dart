import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/constants.dart';
import 'package:rider/utils/gradient_scaffold.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  final String recipientEmail;
  final String recipientUsername;

  const ChatScreen({
    Key? key,
    required this.recipientEmail,
    required this.recipientUsername,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText = "";

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(MingCute.left_line, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        leadingWidth: 35,
        titleSpacing: 10,
        backgroundColor: AppColors.primary,
        title: Text('Chat with ${widget.recipientUsername}'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(
              recipientEmail: widget.recipientEmail,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser!.email,
                        'recipient': widget.recipientEmail,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessagesStream extends StatelessWidget {
  final String recipientEmail;

  const MessagesStream({required this.recipientEmail});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('messages')
          .where('sender', whereIn: [FirebaseAuth.instance.currentUser?.email, recipientEmail])
          .where('recipient', whereIn: [FirebaseAuth.instance.currentUser?.email, recipientEmail])
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.primary,
            ),
          );
        }

        final messages = snapshot.data!.docs;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message['text'];
          final messageSender = message['sender'];
          final isMe = messageSender == loggedInUser!.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: isMe,
          );
          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String? sender;
  final String? text;
  final bool isMe;

  MessageBubble({this.sender, this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    Color bubbleColor =
        isMe ? AppColors.primary : Color.fromARGB(255, 227, 227, 227);
    Color messageColor = isMe ? Colors.white : Colors.grey[900]!;
    CrossAxisAlignment crossAxisAlignment =
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    double topLeftRadius = isMe ? 30.0 : 0.0;
    double topRightRadius = isMe ? 0.0 : 30.0;

    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(crossAxisAlignment: crossAxisAlignment, children: <Widget>[
        Material(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeftRadius),
              topRight: Radius.circular(topRightRadius),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0)),
          elevation: 5.0,
          color: bubbleColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              '$text',
              style: TextStyle(color: messageColor, fontSize: 15.0),
            ),
          ),
        ),
      ]),
    );
  }
}
