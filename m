Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A27B6472
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 15:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfIRNc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 09:32:27 -0400
Received: from mail1.windriver.com ([147.11.146.13]:52535 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfIRNc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:32:27 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x8IDVjS5021368
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 18 Sep 2019 06:31:47 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Wed, 18 Sep 2019 06:31:44 -0700
From:   <zhe.he@windriver.com>
To:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH] printk: Fix unnecessary returning broken pipe error from devkmsg_read
Date:   Wed, 18 Sep 2019 21:31:43 +0800
Message-ID: <1568813503-420025-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

When users read the buffer from start, there is no need to return -EPIPE
since the possible overflows will not affect the output.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 kernel/printk/printk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1888f6a..4a6a129 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -886,7 +886,9 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		logbuf_lock_irq();
 	}
 
-	if (user->seq < log_first_seq) {
+	if (user->seq == 0) {
+		user->seq = log_first_seq;
+	} else if (user->seq < log_first_seq) {
 		/* our last seen message is gone, return error and reset */
 		user->idx = log_first_idx;
 		user->seq = log_first_seq;
-- 
2.7.4

