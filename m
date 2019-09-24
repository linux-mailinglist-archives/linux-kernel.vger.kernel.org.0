Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6834ABC292
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 09:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440551AbfIXH1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 03:27:05 -0400
Received: from mail.windriver.com ([147.11.1.11]:64617 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409268AbfIXH1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:27:05 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x8O7QkLK001049
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 24 Sep 2019 00:26:46 -0700 (PDT)
Received: from pek-lpg-core3.wrs.com (128.224.153.232) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Tue, 24 Sep 2019 00:26:41 -0700
From:   <zhe.he@windriver.com>
To:     <john.ogness@linutronix.de>, <linux-rt-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH RT] printk: devkmsg: read: Return EPIPE when the first message user-space wants has gone
Date:   Tue, 24 Sep 2019 15:26:39 +0800
Message-ID: <20190924072639.25986-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

When user-space wants to read the first message, that is when user->seq
is 0, and that message has gone, it currently automatically resets
user->seq to current first seq. This mis-aligns with mainline kernel.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/dev-kmsg#n39
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/printk/printk.c#n899

We should inform user-space that what it wants has gone by returning EPIPE
in such scenario.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 kernel/printk/printk.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e3fa33f2e23c..58c545a528b3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -703,14 +703,10 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		goto out;
 	}
 
-	if (user->seq == 0) {
-		user->seq = seq;
-	} else {
-		user->seq++;
-		if (user->seq < seq) {
-			ret = -EPIPE;
-			goto restore_out;
-		}
+	user->seq++;
+	if (user->seq < seq) {
+		ret = -EPIPE;
+		goto restore_out;
 	}
 
 	msg = (struct printk_log *)&user->msgbuf[0];
-- 
2.17.1

