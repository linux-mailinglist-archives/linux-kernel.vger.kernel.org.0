Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590C47C1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 14:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbfGaMjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 08:39:33 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:59530 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfGaMja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:39:30 -0400
Received: from ramsan ([84.194.98.4])
        by laurent.telenet-ops.be with bizsmtp
        id jQfT2000G05gfCL01QfT3r; Wed, 31 Jul 2019 14:39:27 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hsnt9-0008W3-EA; Wed, 31 Jul 2019 14:39:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hsnt9-0003fa-Be; Wed, 31 Jul 2019 14:39:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] printk: Use strlen/sizeof instead of hardcoded constants
Date:   Wed, 31 Jul 2019 14:39:22 +0200
Message-Id: <20190731123922.14056-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hardcoded string length or size constants by proper strlen() or
sizeof() constructs.  As the strings are constant, gcc will reduce the
lengths or sizes to constants again.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Assembler output before/after compared: no change in generated code.
---
 include/linux/printk.h |  3 +--
 kernel/printk/printk.c | 12 ++++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cefd374c47b1f88e..9a85d2eb6ff63460 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -77,8 +77,7 @@ static inline void console_verbose(void)
 		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
 }
 
-/* strlen("ratelimit") + 1 */
-#define DEVKMSG_STR_MAX_SIZE 10
+#define DEVKMSG_STR_MAX_SIZE sizeof("ratelimit")
 extern char devkmsg_log_str[];
 struct ctl_table;
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1888f6a3b694cb88..e8f332f0ae3595e8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -121,15 +121,15 @@ static int __control_devkmsg(char *str)
 	if (!str)
 		return -EINVAL;
 
-	if (!strncmp(str, "on", 2)) {
+	if (!strncmp(str, "on", strlen("on"))) {
 		devkmsg_log = DEVKMSG_LOG_MASK_ON;
-		return 2;
-	} else if (!strncmp(str, "off", 3)) {
+		return strlen("on");
+	} else if (!strncmp(str, "off", strlen("off"))) {
 		devkmsg_log = DEVKMSG_LOG_MASK_OFF;
-		return 3;
-	} else if (!strncmp(str, "ratelimit", 9)) {
+		return strlen("off");
+	} else if (!strncmp(str, "ratelimit", strlen("ratelimit"))) {
 		devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
-		return 9;
+		return strlen("ratelimit");
 	}
 	return -EINVAL;
 }
-- 
2.17.1

