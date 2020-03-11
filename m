Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EADD1814D1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 10:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgCKJ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 05:29:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:58018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgCKJ3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:29:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 718A7AFA1;
        Wed, 11 Mar 2020 09:29:06 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: nozomi: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 10:29:05 +0100
Message-Id: <20200311092905.24362-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Also rewrite the code in a standard if-form instead of ugly
conditional operators.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/tty/nozomi.c | 67 ++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index ed99948f3b7f..3af193343f60 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -839,40 +839,39 @@ static char *interrupt2str(u16 interrupt)
 	static char buf[TMP_BUF_MAX];
 	char *p = buf;
 
-	interrupt & MDM_DL1 ? p += snprintf(p, TMP_BUF_MAX, "MDM_DL1 ") : NULL;
-	interrupt & MDM_DL2 ? p += snprintf(p, TMP_BUF_MAX - (p - buf),
-					"MDM_DL2 ") : NULL;
-
-	interrupt & MDM_UL1 ? p += snprintf(p, TMP_BUF_MAX - (p - buf),
-					"MDM_UL1 ") : NULL;
-	interrupt & MDM_UL2 ? p += snprintf(p, TMP_BUF_MAX - (p - buf),
-					"MDM_UL2 ") : NULL;
-
-	interrupt & DIAG_DL1 ? p += snprintf(p, TMP_BUF_MAX - (p - buf),
-					"DIAG_DL1 ") : NULL;
-	interrupt & DIAG_DL2 ? p += snprintf(p, TMP_BUF_MAX - (p - buf),
-					"DIAG_DL2 ") : NULL;
-
-	interrupt & DIAG_UL ? p += snprintf(p, TMP_BUF_MAX - (p - buf),
-					"DIAG_UL ") : NULL;
-
-	interrupt & APP1_DL ? p += snprintf(p, TMP_BUF_MAX - (p - buf),
-					"APP1_DL ") : NULL;
-	interrupt & APP2_DL ? p += snprintf(p, TMP_BUF_MAX - (p - buf),
-					"APP2_DL ") : NULL;
-
-	interrupt & APP1_UL ? p += snprintf(p, TMP_BUF_MAX - (p - buf),
-					"APP1_UL ") : NULL;
-	interrupt & APP2_UL ? p += snprintf(p, TMP_BUF_MAX - (p - buf),
-					"APP2_UL ") : NULL;
-
-	interrupt & CTRL_DL ? p += snprintf(p, TMP_BUF_MAX - (p - buf),
-					"CTRL_DL ") : NULL;
-	interrupt & CTRL_UL ? p += snprintf(p, TMP_BUF_MAX - (p - buf),
-					"CTRL_UL ") : NULL;
-
-	interrupt & RESET ? p += snprintf(p, TMP_BUF_MAX - (p - buf),
-					"RESET ") : NULL;
+	if (interrupt & MDM_DL1)
+		p += scnprintf(p, TMP_BUF_MAX, "MDM_DL1 ");
+	if (interrupt & MDM_DL2)
+		p += scnprintf(p, TMP_BUF_MAX - (p - buf), "MDM_DL2 ");
+	if (interrupt & MDM_UL1)
+		p += scnprintf(p, TMP_BUF_MAX - (p - buf), "MDM_UL1 ");
+	if (interrupt & MDM_UL2)
+		p += scnprintf(p, TMP_BUF_MAX - (p - buf), "MDM_UL2 ");
+	if (interrupt & DIAG_DL1)
+		p += scnprintf(p, TMP_BUF_MAX - (p - buf), "DIAG_DL1 ");
+	if (interrupt & DIAG_DL2)
+		p += scnprintf(p, TMP_BUF_MAX - (p - buf), "DIAG_DL2 ");
+
+	if (interrupt & DIAG_UL)
+		p += scnprintf(p, TMP_BUF_MAX - (p - buf), "DIAG_UL ");
+
+	if (interrupt & APP1_DL)
+		p += scnprintf(p, TMP_BUF_MAX - (p - buf), "APP1_DL ");
+	if (interrupt & APP2_DL)
+		p += scnprintf(p, TMP_BUF_MAX - (p - buf), "APP2_DL ");
+
+	if (interrupt & APP1_UL)
+		p += scnprintf(p, TMP_BUF_MAX - (p - buf), "APP1_UL ");
+	if (interrupt & APP2_UL)
+		p += scnprintf(p, TMP_BUF_MAX - (p - buf), "APP2_UL ");
+
+	if (interrupt & CTRL_DL)
+		p += scnprintf(p, TMP_BUF_MAX - (p - buf), "CTRL_DL ");
+	if (interrupt & CTRL_UL)
+		p += scnprintf(p, TMP_BUF_MAX - (p - buf), "CTRL_UL ");
+
+	if (interrupt & RESET)
+		p += scnprintf(p, TMP_BUF_MAX - (p - buf), "RESET ");
 
 	return buf;
 }
-- 
2.16.4

