```dart
import 'package:flutter/material.dart';
​void main() {
runApp(const CentralDosMemesApp());
}
​class CentralDosMemesApp extends StatelessWidget {
const CentralDosMemesApp({Key? key}) : super(key: key);
​@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Central dos Memes',
theme: ThemeData.dark().copyWith(
scaffoldBackgroundColor: const Color(0xFF0B0F19),
primaryColor: const Color(0xFF00F2FE),
),
initialRoute: '/lock',
routes: {
'/lock': (context) => const LockScreen(),
'/home': (context) => const MainNavigationScreen(),
},
);
}
}
​// ----------------------------------------------------
// TELA DE BLOQUEIO (SENHA: soamigos)
// ----------------------------------------------------
class LockScreen extends StatefulWidget {
const LockScreen({Key? key}) : super(key: key);
​@override
State<LockScreen> createState() => _LockScreenState();
}
​class _LockScreenState extends State<LockScreen> {
final TextEditingController _passwordController = TextEditingController();
String _errorMessage = '';
​void _validatePassword() {
if (_passwordController.text.trim().toLowerCase() == 'soamigos') {
Navigator.of(context).pushReplacementNamed('/home');
} else {
setState(() {
_errorMessage = 'Senha incorreta! Dica: soamigos';
});
}
}
​@override
Widget build(BuildContext context) {
return Scaffold(
body: Center(
child: Padding(
padding: const EdgeInsets.all(24.0),
child: Container(
constraints: const BoxConstraints(maxWidth: 400),
padding: const EdgeInsets.all(32.0),
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.06),
borderRadius: BorderRadius.circular(24),
border: Border.all(color: Colors.white.withOpacity(0.15)),
),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
const Icon(Icons.bolt, size: 64, color: Color(0xFF00F2FE)),
const SizedBox(height: 16),
const Text(
"CENTRAL DOS MEMES",
style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2),
),
const SizedBox(height: 6),
const Text(
'"Entrou, virou meme!"',
style: TextStyle(color: Colors.white54, fontSize: 13, fontStyle: FontStyle.italic),
),
const SizedBox(height: 28),
TextField(
controller: _passwordController,
obscureText: true,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
hintText: "Digite a senha de acesso",
hintStyle: const TextStyle(color: Colors.white38),
filled: true,
fillColor: Colors.black38,
border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
),
),
if (_errorMessage.isNotEmpty) ...[
const SizedBox(height: 12),
Text(_errorMessage, style: const TextStyle(color: Colors.redAccent, fontSize: 13)),
],
const SizedBox(height: 24),
ElevatedButton(
onPressed: _validatePassword,
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFF00F2FE),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
minimumSize: const Size(double.infinity, 50),
),
child: const Text("ENTRAR", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
),
],
),
),
),
),
);
}
}
​// ----------------------------------------------------
// NAVEGAÇÃO PRINCIPAL (5 ABAS)
// ----------------------------------------------------
class MainNavigationScreen extends StatefulWidget {
const MainNavigationScreen({Key? key}) : super(key: key);
​@override
State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}
​class _MainNavigationScreenState extends State<MainNavigationScreen> {
int _currentIndex = 0;
​Color primaryThemeColor = const Color(0xFF00F2FE);
Color backgroundThemeColor = const Color(0xFF0B0F19);
String activeThemeName = "Padrão Liquid Glass";
​final List<Widget> _screens = [];
​@override
void initState() {
super.initState();
_updateScreens();
}
​void _updateScreens() {
_screens.clear();
_screens.addAll([
FeedTab(themeColor: primaryThemeColor),
FriendsTab(themeColor: primaryThemeColor),
MessagesTab(themeColor: primaryThemeColor),
NovaIATab(
onThemeChanged: (newName, newPrimary, newBg) {
setState(() {
activeThemeName = newName;
primaryThemeColor = newPrimary;
backgroundThemeColor = newBg;
_updateScreens();
});
},
currentTheme: activeThemeName,
),
ProfileTab(themeColor: primaryThemeColor),
]);
}
​@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: backgroundThemeColor,
body: IndexedStack(
index: _currentIndex,
children: _screens,
),
bottomNavigationBar: Container(
decoration: BoxDecoration(
color: Colors.black.withOpacity(0.4),
border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
),
child: BottomNavigationBar(
currentIndex: _currentIndex,
onTap: (index) => setState(() => _currentIndex = index),
backgroundColor: Colors.transparent,
type: BottomNavigationBarType.fixed,
selectedItemColor: primaryThemeColor,
unselectedItemColor: Colors.white54,
items: const [
BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Início'),
BottomNavigationBarItem(icon: Icon(Icons.people_outline), activeIcon: Icon(Icons.people), label: 'Amigos'),
BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'Mensagens'),
BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), activeIcon: Icon(Icons.auto_awesome), label: 'NOVA IA'),
BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Perfil'),
],
),
),
);
}
}
​// ----------------------------------------------------
// 1. ABA INÍCIO (FEED & POSTS)
// ----------------------------------------------------
class FeedTab extends StatelessWidget {
final Color themeColor;
const FeedTab({Key? key, required this.themeColor}) : super(key: key);
​@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.transparent,
appBar: AppBar(
title: const Text("Central dos Memes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
backgroundColor: Colors.transparent,
elevation: 0,
actions: [
IconButton(icon: const Icon(Icons.add_box_outlined, color: Colors.white), onPressed: () {})
],
),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
_buildPostCard(
author: "Dina Alvarenga",
time: "Há 15 minutos",
content: "Quando você tenta consertar a pia e acaba criando uma nova galáxia na cozinha. 🌌😂",
likes: "428",
themeColor: themeColor,
),
const SizedBox(height: 16),
_buildPostCard(
author: "Carlos MemeMaster",
time: "Há 2 horas",
content: "O programador depois de achar que o código estava pronto sem testar:",
imageUrl: "https://images.unsplash.com/photo-1531403009284-440f080d1e12?w=500&auto=format&fit=crop&q=60",
likes: "1.2K",
themeColor: themeColor,
),
],
),
);
}
​Widget _buildPostCard({required String author, required String time, required String content, String? imageUrl, required String likes, required Color themeColor}) {
return Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.05),
borderRadius: BorderRadius.circular(20),
border: Border.all(color: Colors.white.withOpacity(0.1)),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
children: [
CircleAvatar(backgroundColor: themeColor, radius: 18, child: Text(author[0], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
const SizedBox(width: 12),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(author, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
Text(time, style: const TextStyle(color: Colors.white54, fontSize: 11)),
],
),
],
),
const SizedBox(height: 12),
Text(content, style: const TextStyle(color: Colors.white90, fontSize: 14)),
if (imageUrl != null) ...[
const SizedBox(height: 12),
ClipRRect(
borderRadius: BorderRadius.circular(12),
child: Image.network(imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
),
],
const SizedBox(height: 16),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Row(
children: [
Icon(Icons.favorite, color: themeColor, size: 20),
const SizedBox(width: 6),
Text(likes, style: const TextStyle(color: Colors.white70)),
],
),
const Icon(Icons.share_outlined, color: Colors.white54, size: 20),
],
),
],
),
);
}
}
​// ----------------------------------------------------
// 2. ABA AMIGOS & RELACIONAMENTOS
// ----------------------------------------------------
class FriendsTab extends StatelessWidget {
final Color themeColor;
const FriendsTab({Key? key, required this.themeColor}) : super(key: key);
​@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.transparent,
appBar: AppBar(title: const Text("Amigos e Relacionamento", style: TextStyle(color: Colors.white)), backgroundColor: Colors.transparent, elevation: 0),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
Container(
padding: const EdgeInsets.all(20),
decoration: BoxDecoration(
gradient: LinearGradient(colors: [themeColor.withOpacity(0.2), Colors.purple.withOpacity(0.2)]),
borderRadius: BorderRadius.circular(20),
border: Border.all(color: themeColor.withOpacity(0.4)),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Text("MEU RELACIONAMENTO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1)),
Icon(Icons.favorite, color: themeColor),
],
),
const SizedBox(height: 12),
const Text("Status: Em um relacionamento sério com os memes", style: TextStyle(color: Colors.white70, fontSize: 14)),
const SizedBox(height: 6),
const Text("Especial desde: 12 de Março", style: TextStyle(color: Colors.white54, fontSize: 12)),
],
),
),
const SizedBox(height: 24),
const Text("Amigos Online (3)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
const SizedBox(height: 12),
_buildFriendItem("Carlos Silva", "Jogando Minecraft...", themeColor),
_buildFriendItem("Mariana Souza", "Criando um novo meme com IA", themeColor),
_buildFriendItem("Roberto Dias", "Offline (Fila sincronizada)", themeColor),
],
),
);
}
​Widget _buildFriendItem(String name, String status, Color themeColor) {
return Container(
margin: const EdgeInsets.only(bottom: 12),
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.04),
borderRadius: BorderRadius.circular(16),
border: Border.all(color: Colors.white.withOpacity(0.08)),
),
child: Row(
children: [
CircleAvatar(backgroundColor: themeColor.withOpacity(0.3), child: Text(name[0], style: TextStyle(color: themeColor, fontWeight: FontWeight.bold))),
const SizedBox(width: 12),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
Text(status, style: const TextStyle(color: Colors.white54, fontSize: 12)),
],
),
),
const Icon(Icons.chat_bubble_outline, color: Colors.white54),
],
),
);
}
}
​// ----------------------------------------------------
// 3. ABA MENSAGENS (CHAT)
// ----------------------------------------------------
class MessagesTab extends StatelessWidget {
final Color themeColor;
const MessagesTab({Key? key, required this.themeColor}) : super(key: key);
​@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.transparent,
appBar: AppBar(title: const Text("Mensagens & Fila Offline", style: TextStyle(color: Colors.white)), backgroundColor: Colors.transparent, elevation: 0),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: Colors.amber.withOpacity(0.1),
borderRadius: BorderRadius.circular(12),
border: Border.all(color: Colors.amber.withOpacity(0.3)),
),
child: const Row(
children: [
Icon(Icons.cloud_done, color: Colors.amber),
SizedBox(width: 12),
Expanded(
child: Text("Fila Inteligente: 0 mensagens pendentes. Tudo sincronizado!", style: TextStyle(color: Colors.amberAccent, fontSize: 12)),
),
],
),
),
const SizedBox(height: 16),
_buildChatRow("Grupo da Zoeira Oficial", "Carlos: Mandou uma figurinha nova", "10:42", themeColor),
_buildChatRow("Mariana Souza", "KKkkkk sério isso?", "09:15", themeColor),
],
),
);
}
​Widget _buildChatRow(String name, String lastMessage, String time, Color themeColor) {
return Container(
margin: const EdgeInsets.only(bottom: 12),
padding: const EdgeInsets.all(14),
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.04),
borderRadius: BorderRadius.circular(16),
border: Border.all(color: Colors.white.withOpacity(0.08)),
),
child: Row(
children: [
CircleAvatar(backgroundColor: themeColor, child: Text(name[0], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
const SizedBox(width: 14),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
const SizedBox(height: 4),
Text(lastMessage, style: const TextStyle(color: Colors.white60, fontSize: 13)),
],
),
),
Text(time, style: const TextStyle(color: Colors.white38, fontSize: 11)),
],
),
);
}
}
​// ----------------------------------------------------
// 4. ABA NOVA IA (MOTOR DE PERSONALIZAÇÃO)
// ----------------------------------------------------
class NovaIATab extends StatefulWidget {
final Function(String, Color, Color) onThemeChanged;
final String currentTheme;
​const NovaIATab({Key? key, required this.onThemeChanged, required this.currentTheme}) : super(key: key);
​@override
State<NovaIATab> createState() => _NovaIATabState();
}
​class _NovaIATabState extends State<NovaIATab> {
final TextEditingController _commandController = TextEditingController();
String _aiResponse = "Olá! Sou a NOVA IA. Digite um comando para personalizar sua experiência (ex: 'Deixe meu feed roxo neon', 'Modo Cyberpunk' ou 'Tema Sunset').";
String selectedLevel = "Essencial";
​void _processAICommand() {
String text = _commandController.text.toLowerCase();
setState(() {
if (text.contains('roxo') || text.contains('cyber')) {
widget.onThemeChanged("Neon Cyber", Colors.purpleAccent, const Color(0xFF13051D));
_aiResponse = "✨ Tema 'Neon Cyber' aplicado com sucesso!";
} else if (text.contains('verde') || text.contains('matrix')) {
widget.onThemeChanged("Matrix Verde", Colors.greenAccent, const Color(0xFF051D0B));
_aiResponse = "✨ Tema 'Matrix Verde' ativado!";
} else if (text.contains('sunset') || text.contains('laranja')) {
widget.onThemeChanged("Sunset Neon", Colors.orangeAccent, const Color(0xFF1D1005));
_aiResponse = "✨ Tema 'Sunset Neon' configurado!";
} else {
widget.onThemeChanged("Liquid Cyan", const Color(0xFF00F2FE), const Color(0xFF0B0F19));
_aiResponse = "🤖 Comando entendido! Ajustei os refletores de vidro e o layout para você.";
}
});
_commandController.clear();
}
​@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.transparent,
appBar: AppBar(title: const Text("NOVA IA • Estilista de Interface", style: TextStyle(color: Colors.white)), backgroundColor: Colors.transparent, elevation: 0),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
Center(
child: Container(
height: 100,
width: 100,
decoration: BoxDecoration(
shape: BoxShape.circle,
gradient: LinearGradient(colors: [Colors.white.withOpacity(0.3), Colors.cyan.withOpacity(0.1)]),
boxShadow: [BoxShadow(color: Colors.cyan.withOpacity(0.3), blurRadius: 20, spreadRadius: 5)],
border: Border.all(color: Colors.white.withOpacity(0.4)),
),
child: const Icon(Icons.auto_awesome, size: 48, color: Colors.white),
),
),
const SizedBox(height: 20),
Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.05),
borderRadius: BorderRadius.circular(16),
border: Border.all(color: Colors.white.withOpacity(0.1)),
),
child: Text(_aiResponse, style: const TextStyle(color: Colors.white, fontSize: 14)),
),
const SizedBox(height: 20),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: ["Essencial", "Criativo", "Universo"].map((level) {
bool isSelected = selectedLevel == level;
return Padding(
padding: const EdgeInsets.symmetric(horizontal: 4),
child: ChoiceChip(
label: Text(level),
selected: isSelected,
selectedColor: const Color(0xFF00F2FE),
backgroundColor: Colors.white10,
labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white, fontWeight: FontWeight.bold),
onSelected: (val) => setState(() => selectedLevel = level),
),
);
}).toList(),
),
const SizedBox(height: 20),
TextField(
controller: _commandController,
style: const TextStyle(color: Colors.white),
decoration: InputDecoration(
hintText: "Ex: Mude meu tema para roxo...",
hintStyle: const TextStyle(color: Colors.white38),
filled: true,
fillColor: Colors.white.withOpacity(0.05),
border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
suffixIcon: IconButton(
icon: const Icon(Icons.send, color: Color(0xFF00F2FE)),
onPressed: _processAICommand,
),
),
),
],
),
);
}
}
​// ----------------------------------------------------
// 5. ABA PERFIL
// ----------------------------------------------------
class ProfileTab extends StatelessWidget {
final Color themeColor;
const ProfileTab({Key? key, required this.themeColor}) : super(key: key);
​@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.transparent,
appBar: AppBar(title: const Text("Meu Perfil", style: TextStyle(color: Colors.white)), backgroundColor: Colors.transparent, elevation: 0),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
Center(
child: Column(
children: [
CircleAvatar(radius: 45, backgroundColor: themeColor, child: const Text("DA", style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold))),
const SizedBox(height: 12),
const Text("Dina Alvarenga", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
const SizedBox(height: 4),
const Text("@dina_memes", style: TextStyle(color: Colors.white54, fontSize: 13)),
],
),
),
const SizedBox(height: 24),
Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.05),
borderRadius: BorderRadius.circular(16),
border: Border.all(color: Colors.white.withOpacity(0.1)),
),
child: const Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text("Configurações do Aplicativo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
Divider(color: Colors.white24),
ListTile(
contentPadding: EdgeInsets.zero,
leading: Icon(Icons.lock_reset, color: Colors.white70),
title: Text("Senha de Acesso", style: TextStyle(color: Colors.white70, fontSize: 14)),
trailing: Text("soamigos", style: TextStyle(color: Color(0xFF00F2FE), fontWeight: FontWeight.bold)),
),
ListTile(
contentPadding: EdgeInsets.zero,
leading: Icon(Icons.phone_android, color: Colors.white70),
title: Text("Versão do App", style: TextStyle(color: Colors.white70, fontSize: 14)),
trailing: Text("1.0.0 Pro", style: TextStyle(color: Colors.white54)),
),
],
),
),
],
),
);
}
}
