import 'dart:convert';
import 'dart:math';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

class User {
  String username;
  String password;

  User(this.username, this.password);
}

class AuthService {
  final Map<String, User> users = {};
  final Map<String, String> tokens = {};

  User? getUserByUsername(String username) {
    return users[username];
  }

  String generateRandomToken() {
    const tokenLength = 32;
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        tokenLength,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
      ),
    );
  }

  String generateToken(User user) {
    final token = generateRandomToken();
    tokens[user.username] = token;
    return token;
  }

  bool validateToken(String username, String token) {
    return tokens.containsKey(username) && tokens[username] == token;
  }
}

void main() {
  final authService = AuthService();
  final app = Router();

  app.post('/register', (Request request) async {
    final requestBody = await utf8.decodeStream(request.read());
    final Map<String, dynamic> data = jsonDecode(requestBody);

    final username = data['username'];
    final password = data['password'];

    if (username != null && password != null) {
      final newUser = User(username, password);
      authService.users[username] = newUser;

      final token = authService.generateToken(newUser);

      return Response.ok(
        jsonEncode({'token': token}),
        headers: {'content-type': 'application/json'},
      );
    } else {
      return Response.badRequest(body: 'Invalid request body');
    }
  });

  app.post('/login', (Request request) async {
    final requestBody = await utf8.decodeStream(request.read());
    final Map<String, dynamic> data = jsonDecode(requestBody);

    final username = data['username'];
    final password = data['password'];

    final user = authService.getUserByUsername(username);

    if (user != null && user.password == password) {
      final token = authService.generateToken(user);

      return Response.ok(
        jsonEncode({'token': token}),
        headers: {'content-type': 'application/json'},
      );
    } else {
      return Response.unauthorized('Invalid credentials');
    }
  });

  app.get('/protected', (Request request) {
    final authHeader = request.headers['authorization'];

    if (authHeader != null && authHeader.startsWith('Bearer ')) {
      final token = authHeader.substring(7);
      final username = request.url.queryParameters['username'];

      if (username != null && authService.validateToken(username, token)) {
        return Response.ok('Welcome to the protected resource!');
      }
    }

    return Response.unauthorized('Invalid or missing token');
  });

  // Start the server
  shelf_io.serve(app, 'localhost', 8080).then((server) {
    print('Server is running on port 8080');
  });
}


///
///
/// /login
/// /register
/// POST
///
///