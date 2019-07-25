Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B3374DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 14:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfGYMJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 08:09:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbfGYMJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:09:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8186A307D965;
        Thu, 25 Jul 2019 12:09:21 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.43.2.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 667E15B838;
        Thu, 25 Jul 2019 12:09:19 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     vdronov@redhat.com, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suraj Sumangala <suraj@atheros.com>,
        Frederic Danis <frederic.danis@linux.intel.com>,
        Loic Poulain <loic.poulain@intel.com>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        syzkaller@googlegroups.com
Subject: [PATCH] Bluetooth: hci_uart: check for missing tty operations in protocol handlers
Date:   Thu, 25 Jul 2019 14:09:09 +0200
Message-Id: <20190725120909.31235-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 25 Jul 2019 12:09:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain ttys operations (pty_unix98_ops) lack tiocmget() and tiocmset()
functions which are called by the certain HCI UART protocols (hci_ath,
hci_bcm, hci_intel, hci_mrvl, hci_qca) via hci_uart_set_flow_control()
or directly. This leads to an execution at NULL and can be triggered by
an unprivileged user. Fix this by adding a check for the missing tty
operations to the protocols which use them.

This fixes CVE-2019-10207.

Link: https://syzkaller.appspot.com/bug?id=1b42faa2848963564a5b1b7f8c837ea7b55ffa50
Reported-by: syzbot+79337b501d6aa974d0f6@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org # v2.6.36+
Fixes: b3190df62861 ("Bluetooth: Support for Atheros AR300x serial chip")
Fixes: 118612fb9165 ("Bluetooth: hci_bcm: Add suspend/resume PM functions")
Fixes: ff2895592f0f ("Bluetooth: hci_intel: Add Intel baudrate configuration support")
Fixes: 162f812f23ba ("Bluetooth: hci_uart: Add Marvell support")
Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990")
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/bluetooth/hci_ath.c   | 3 +++
 drivers/bluetooth/hci_bcm.c   | 5 +++++
 drivers/bluetooth/hci_intel.c | 3 +++
 drivers/bluetooth/hci_mrvl.c  | 3 +++
 drivers/bluetooth/hci_qca.c   | 4 ++++
 5 files changed, 18 insertions(+)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index a55be205b91a..99df8a13e47e 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -98,6 +98,9 @@ static int ath_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+	if (!hu->tty->driver->ops->tiocmget || !hu->tty->driver->ops->tiocmset)
+		return -ENOTSUPP;
+
 	ath = kzalloc(sizeof(*ath), GFP_KERNEL);
 	if (!ath)
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 8905ad2edde7..8c3e09cc341c 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -406,6 +406,11 @@ static int bcm_open(struct hci_uart *hu)
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
 
+#ifdef CONFIG_PM
+	if (!hu->tty->driver->ops->tiocmget || !hu->tty->driver->ops->tiocmset)
+		return -ENOTSUPP;
+#endif
+
 	bcm = kzalloc(sizeof(*bcm), GFP_KERNEL);
 	if (!bcm)
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 207bae5e0d46..a314882a1cac 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -391,6 +391,9 @@ static int intel_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+	if (!hu->tty->driver->ops->tiocmget || !hu->tty->driver->ops->tiocmset)
+		return -ENOTSUPP;
+
 	intel = kzalloc(sizeof(*intel), GFP_KERNEL);
 	if (!intel)
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
index f98e5cc343b2..4ee27c8d8679 100644
--- a/drivers/bluetooth/hci_mrvl.c
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -59,6 +59,9 @@ static int mrvl_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+	if (!hu->tty->driver->ops->tiocmget || !hu->tty->driver->ops->tiocmset)
+		return -ENOTSUPP;
+
 	mrvl = kzalloc(sizeof(*mrvl), GFP_KERNEL);
 	if (!mrvl)
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 9a5c9c1f9484..a65c202e8995 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
+#include <linux/tty.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -473,6 +474,9 @@ static int qca_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p qca_open", hu);
 
+	if (!hu->tty->driver->ops->tiocmget || !hu->tty->driver->ops->tiocmset)
+		return -ENOTSUPP;
+
 	qca = kzalloc(sizeof(struct qca_data), GFP_KERNEL);
 	if (!qca)
 		return -ENOMEM;
-- 
2.20.1

