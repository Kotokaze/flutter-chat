import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInfoCard extends StatefulWidget {
  final User user;
  const UserInfoCard(this.user);

  @override
  _UserInfoCardState createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          alignment: Alignment.center,
          child: const Text(
            'User info',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        if (widget.user != null)
          if (widget.user.photoURL != null)
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 8),
              child: Image.network(widget.user.photoURL),
            )
          else
            Align(
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 8),
                color: Colors.black,
                child: const Text(
                  'No image',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        Text(widget.user == null
          ? 'Not signed in'
          : '${widget.user.isAnonymous ? 'User is anonymous\n\n' : ''}'
            'Email: ${widget.user.email} (verified: ${widget.user.emailVerified})\n\n'
            'Phone number: ${widget.user.phoneNumber}\n\n'
            'Name: ${widget.user.displayName}\n\n'
            'ID: ${widget.user.uid}\n\n'
            'Tenant ID: ${widget.user.tenantId}\n\n'
            'Refresh token: ${widget.user.refreshToken}\n\n'
            'Created: ${widget.user.metadata.creationTime.toString()}\n\n'
            'Last login: ${widget.user.metadata.lastSignInTime}\n\n'),
        if (widget.user != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.user.providerData.isEmpty
                  ? 'No providers'
                  : 'Providers:',
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              for (var provider in widget.user.providerData)
                Dismissible(
                  key: Key(provider.uid),
                  onDismissed: (action) => widget.user.unlink(provider.providerId),
                  child: Card(
                    color: Colors.grey[350],
                    child: ListTile(
                      leading: provider.photoURL == null
                          ? IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => widget.user.unlink(provider.providerId))
                          : Image.network(provider.photoURL),
                      title: Text(provider.providerId),
                      subtitle: Text(
                        "${provider.uid == null ? "" : "ID: ${provider.uid}\n"}"
                        "${provider.email == null ? "" : "Email: ${provider.email}\n"}"
                        "${provider.phoneNumber == null ? "" : "Phone number: ${provider.phoneNumber}\n"}"
                        "${provider.displayName == null ? "" : "Name: ${provider.displayName}\n"}"
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
