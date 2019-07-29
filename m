Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 124CA789DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 12:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbfG2Kx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 06:53:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387449AbfG2Kx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:53:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 44D786037C; Mon, 29 Jul 2019 10:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564397605;
        bh=LTJxk4iRvgnwmO+F5xLBeQG+LpSu/BbVaXvnVAAtyTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=RSv0Cith2JkX58oKHbIk6j3MLLudulHOoVeramn2x+mj1gYSBWmFOACMZAZXgI75B
         QHGdt+UWfROrnqp09+uqiLiO3/spyNLNk+lriQS9IzDoaEXCBcrmAjzadzBR0k1FU6
         OfecZQP/Iklz+ABPIhsLDZQMitMIC1P2MpS5vnMw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C25AC6037C;
        Mon, 29 Jul 2019 10:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564397604;
        bh=LTJxk4iRvgnwmO+F5xLBeQG+LpSu/BbVaXvnVAAtyTQ=;
        h=From:To:Cc:Subject:Date:From;
        b=NFYHoknfz4J7E+BURTNx4dZiOkLTonEE0JHY55t3npN4ZZEWnL5QTovfkXdJscIKG
         xvjSbkHqD7WXvhrIbfEPOg0EIYBBTfdrFvYeQZ9K0uHj3Rz6OjrEvLf8ATRk1vTjjV
         SOB4xp7rk8GjDrAc/5kFc8yMcx7f+WjeFVUo8zkM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C25AC6037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 1/2] locking/mutex: Move mutex flag macros to linux/mutex.h
Date:   Mon, 29 Jul 2019 16:22:57 +0530
Message-Id: <1564397578-28423-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There exist a place where we use hard code value for mutex
flag(e.g in mutex.h __mutex_owner()). Let's move the mutex
flag macros to header linux/mutex.h, so that it could be
reused at other places as well.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 include/linux/mutex.h  | 15 +++++++++++++++
 kernel/locking/mutex.c | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index dcd03fe..79b28be 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -20,6 +20,21 @@
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
 
+/*
+ * @owner: contains: 'struct task_struct *' to the current lock owner,
+ * NULL means not owned. Since task_struct pointers are aligned at
+ * at least L1_CACHE_BYTES, we have low bits to store extra state.
+ *
+ * Bit0 indicates a non-empty waiter list; unlock must issue a wakeup.
+ * Bit1 indicates unlock needs to hand the lock to the top-waiter
+ * Bit2 indicates handoff has been done and we're waiting for pickup.
+ */
+#define MUTEX_FLAG_WAITERS	0x01
+#define MUTEX_FLAG_HANDOFF	0x02
+#define MUTEX_FLAG_PICKUP	0x04
+
+#define MUTEX_FLAGS		0x07
+
 struct ww_acquire_ctx;
 
 /*
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5e06973..b74c87d 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -50,21 +50,6 @@
 }
 EXPORT_SYMBOL(__mutex_init);
 
-/*
- * @owner: contains: 'struct task_struct *' to the current lock owner,
- * NULL means not owned. Since task_struct pointers are aligned at
- * at least L1_CACHE_BYTES, we have low bits to store extra state.
- *
- * Bit0 indicates a non-empty waiter list; unlock must issue a wakeup.
- * Bit1 indicates unlock needs to hand the lock to the top-waiter
- * Bit2 indicates handoff has been done and we're waiting for pickup.
- */
-#define MUTEX_FLAG_WAITERS	0x01
-#define MUTEX_FLAG_HANDOFF	0x02
-#define MUTEX_FLAG_PICKUP	0x04
-
-#define MUTEX_FLAGS		0x07
-
 static inline struct task_struct *__owner_task(unsigned long owner)
 {
 	return (struct task_struct *)(owner & ~MUTEX_FLAGS);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

