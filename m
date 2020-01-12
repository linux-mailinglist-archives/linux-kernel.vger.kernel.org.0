Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB871138715
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 17:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733106AbgALQtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 11:49:53 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:42906 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbgALQtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:49:52 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id pUpr210065USYZQ06UprGA; Sun, 12 Jan 2020 17:49:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgQx-0007yN-05; Sun, 12 Jan 2020 17:49:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgQw-0005Gs-VF; Sun, 12 Jan 2020 17:49:50 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 5/5] zorro: Move zorro_bus_type to bus-private header file
Date:   Sun, 12 Jan 2020 17:49:49 +0100
Message-Id: <20200112164949.20196-6-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200112164949.20196-1-geert@linux-m68k.org>
References: <20200112164949.20196-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zorro_bus_type was never used outside the Zorro bus code.  Hence move it
from the public to the bus-private header file.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/zorro/zorro.h | 7 +++++++
 include/linux/zorro.h | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/zorro/zorro.h b/drivers/zorro/zorro.h
index ac0bab3412d90ddb..f84df9fb4c200ec3 100644
--- a/drivers/zorro/zorro.h
+++ b/drivers/zorro/zorro.h
@@ -1,5 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+    /*
+     *  Zorro bus
+     */
+
+extern struct bus_type zorro_bus_type;
+
+
 #ifdef CONFIG_ZORRO_NAMES
 extern void zorro_name_device(struct zorro_dev *z);
 #else
diff --git a/include/linux/zorro.h b/include/linux/zorro.h
index 22f3f80fbcb5afe6..e2e4de188d84a6d9 100644
--- a/include/linux/zorro.h
+++ b/include/linux/zorro.h
@@ -40,13 +40,6 @@ struct zorro_dev {
 #define	to_zorro_dev(n)	container_of(n, struct zorro_dev, dev)
 
 
-    /*
-     *  Zorro bus
-     */
-
-extern struct bus_type zorro_bus_type;
-
-
     /*
      *  Zorro device drivers
      */
-- 
2.17.1

