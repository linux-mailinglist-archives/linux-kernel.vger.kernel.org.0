Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61D15D1CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfGBOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 10:35:19 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52705 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfGBOfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:35:18 -0400
Received: from localhost.localdomain (p4FEFC3D2.dip0.t-ipconnect.de [79.239.195.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6A44DCF182;
        Tue,  2 Jul 2019 16:43:47 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH v5.2-rc6] Bluetooth: Fix faulty expression for minimum encryption key size check
Date:   Tue,  2 Jul 2019 16:35:09 +0200
Message-Id: <20190702143510.5003-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matias Karhumaa <matias.karhumaa@gmail.com>

Fixes minimum encryption key size check so that HCI_MIN_ENC_KEY_SIZE
is also allowed as stated in the comment.

This bug caused connection problems with devices having maximum
encryption key size of 7 octets (56-bit).

Fixes: 693cd8ce3f88 ("Bluetooth: Fix regression with minimum encryption key size alignment")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203997
Signed-off-by: Matias Karhumaa <matias.karhumaa@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9f77432dbe38..5406d7cd46ad 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1353,7 +1353,7 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon)
 	 * actually encrypted before enforcing a key size.
 	 */
 	return (!test_bit(HCI_CONN_ENCRYPT, &hcon->flags) ||
-		hcon->enc_key_size > HCI_MIN_ENC_KEY_SIZE);
+		hcon->enc_key_size >= HCI_MIN_ENC_KEY_SIZE);
 }
 
 static void l2cap_do_start(struct l2cap_chan *chan)
-- 
2.20.1

