Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8691B4F603
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 15:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFVNrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 09:47:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58806 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVNrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 09:47:05 -0400
Received: from localhost.localdomain (p4FEFC3D2.dip0.t-ipconnect.de [79.239.195.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id B9968CF184;
        Sat, 22 Jun 2019 15:55:31 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH v5.2-rc5] Bluetooth: Fix regression with minimum encryption key size alignment
Date:   Sat, 22 Jun 2019 15:47:01 +0200
Message-Id: <20190622134701.7088-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to align the minimum encryption key size requirement for
Bluetooth connections, it turns out doing this in a central location
in the HCI connection handling code is not possible.

Original Bluetooth version up to 2.0 used a security model where the
L2CAP service would enforce authentication and encryption. Starting
with Bluetooth 2.1 and Secure Simple Pairing that model has changed
into that the connection initiator is responsible for providing an
encrypted ACL link before any L2CAP communication can happen.

Now connecting Bluetooth 2.1 or later devices with Bluetooth 2.0 and
before devices are causing a regression. The encryption key size
check needs to be moved out of the HCI connection handling into the
L2CAP channel setup.

To achieve this, the current check inside hci_conn_security() has
been moved into l2cap_check_enc_key_size() helper function and then
called from four decisions point inside L2CAP to cover all combinations
of Secure Simple Pairing enabled devices and device using legacy
pairing and legacy service security model.

Fixes: d5bb334a8e17 ("Bluetooth: Align minimum encryption key size for LE and BR/EDR connections")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203643
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
---
 net/bluetooth/hci_conn.c   | 18 +++++++++---------
 net/bluetooth/l2cap_core.c | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3cf0764d5793..15d1cb5aee18 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1276,14 +1276,6 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 	    !test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 		return 0;
 
-	/* The minimum encryption key size needs to be enforced by the
-	 * host stack before establishing any L2CAP connections. The
-	 * specification in theory allows a minimum of 1, but to align
-	 * BR/EDR and LE transports, a minimum of 7 is chosen.
-	 */
-	if (conn->enc_key_size < HCI_MIN_ENC_KEY_SIZE)
-		return 0;
-
 	return 1;
 }
 
@@ -1400,8 +1392,16 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
 		return 0;
 
 encrypt:
-	if (test_bit(HCI_CONN_ENCRYPT, &conn->flags))
+	if (test_bit(HCI_CONN_ENCRYPT, &conn->flags)) {
+		/* Ensure that the encryption key size has been read,
+		 * otherwise stall the upper layer responses.
+		 */
+		if (!conn->enc_key_size)
+			return 0;
+
+		/* Nothing else needed, all requirements are met */
 		return 1;
+	}
 
 	hci_conn_encrypt(conn);
 	return 0;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b53acd6c9a3d..9f77432dbe38 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1341,6 +1341,21 @@ static void l2cap_request_info(struct l2cap_conn *conn)
 		       sizeof(req), &req);
 }
 
+static bool l2cap_check_enc_key_size(struct hci_conn *hcon)
+{
+	/* The minimum encryption key size needs to be enforced by the
+	 * host stack before establishing any L2CAP connections. The
+	 * specification in theory allows a minimum of 1, but to align
+	 * BR/EDR and LE transports, a minimum of 7 is chosen.
+	 *
+	 * This check might also be called for unencrypted connections
+	 * that have no key size requirements. Ensure that the link is
+	 * actually encrypted before enforcing a key size.
+	 */
+	return (!test_bit(HCI_CONN_ENCRYPT, &hcon->flags) ||
+		hcon->enc_key_size > HCI_MIN_ENC_KEY_SIZE);
+}
+
 static void l2cap_do_start(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1358,9 +1373,14 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 	if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
 		return;
 
-	if (l2cap_chan_check_security(chan, true) &&
-	    __l2cap_no_conn_pending(chan))
+	if (!l2cap_chan_check_security(chan, true) ||
+	    !__l2cap_no_conn_pending(chan))
+		return;
+
+	if (l2cap_check_enc_key_size(conn->hcon))
 		l2cap_start_connection(chan);
+	else
+		__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 }
 
 static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
@@ -1439,7 +1459,10 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				continue;
 			}
 
-			l2cap_start_connection(chan);
+			if (l2cap_check_enc_key_size(conn->hcon))
+				l2cap_start_connection(chan);
+			else
+				l2cap_chan_close(chan, ECONNREFUSED);
 
 		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
@@ -7490,7 +7513,7 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		}
 
 		if (chan->state == BT_CONNECT) {
-			if (!status)
+			if (!status && l2cap_check_enc_key_size(hcon))
 				l2cap_start_connection(chan);
 			else
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
@@ -7499,7 +7522,7 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
-			if (!status) {
+			if (!status && l2cap_check_enc_key_size(hcon)) {
 				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
-- 
2.21.0

