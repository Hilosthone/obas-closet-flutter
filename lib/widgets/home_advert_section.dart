import 'package:flutter/material.dart';

class HomeAdvertSection extends StatelessWidget {
  const HomeAdvertSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. MAIN FLASH SALE BANNER
        _buildHeroBanner(),

        // 2. TRUST BADGES
        _buildServiceInfo(),

        // 3. JUMIA-STYLE QUICK ACTIONS
        _buildQuickActions(),

        // 4. SHIPPING PROMO STRIP
        _buildMiniPromo(),
      ],
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5D4037), Color(0xFF2D1B18)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white.withOpacity(0.05),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("FLASH SALE ENDS IN:",
                    style: TextStyle(color: Colors.orangeAccent, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _buildTimerBox("02"),
                    _buildTimerDivider(),
                    _buildTimerBox("14"),
                    _buildTimerDivider(),
                    _buildTimerBox("55"),
                  ],
                ),
                const SizedBox(height: 15),
                const Text("UP TO 50% OFF",
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, height: 1.0)),
                const Text("OBA'S Curated Vintage",
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: Colors.orangeAccent, borderRadius: BorderRadius.circular(5)),
                  child: const Text("SHOP DEALS", style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _actionItem(Icons.bolt, "Deals", Colors.orange),
          // FIXED: Changed CardMembership to card_membership
          _actionItem(Icons.card_membership, "Premium", Colors.blue),
          // FIXED: Changed History to history
          _actionItem(Icons.history, "Recent", Colors.green),
          // FIXED: Changed New_Releases to new_releases
          _actionItem(Icons.new_releases, "Trends", Colors.purple),
        ],
      ),
    );
  }

  Widget _actionItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildServiceInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _infoTile(Icons.verified_outlined, "Authentic Grade"),
          _infoTile(Icons.local_shipping_outlined, "Ilorin Delivery"),
          _infoTile(Icons.replay_outlined, "7-Day Return"),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildMiniPromo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF3E2723),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer_outlined, size: 16, color: Colors.orangeAccent),
          const SizedBox(width: 10),
          const Expanded(
            child: Text("Use Code: OBASVINTAGE for 10% off your first order!",
                style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w400)),
          ),
          const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white54),
        ],
      ),
    );
  }

  Widget _buildTimerBox(String value) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black)),
    );
  }

  Widget _buildTimerDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(":", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}