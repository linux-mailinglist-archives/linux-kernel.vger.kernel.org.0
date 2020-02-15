Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF8815FB68
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBOATG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:19:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOATE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:19:04 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2823022314;
        Sat, 15 Feb 2020 00:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725944;
        bh=x0LF8aBP+i/7AzpurMJgTIstDuFyFd+JlzQss8krq0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cahg2qzdHsfgHuef1G1y0CYdPqZ7biHtLUVHW6gRLJv9CKFpClBC/c8Min7zQtI0k
         hpkZj8Qi0zoja/wGdgXMPHs9r+31W49oGf0bUGpGNxG1nq0vDpeGD54J5ssheW9uIr
         /zV5RdThgEPJlYVEMu8mM9vmXnjZabb7lg/Zz/Qk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Colin Ian King <colin.king@canonical.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/5] rcu: Fix spelling mistake "leval" -> "level"
Date:   Fri, 14 Feb 2020 16:18:44 -0800
Message-Id: <20200215001845.15432-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215001816.GA15284@paulmck-ThinkPad-P72>
References: <20200215001816.GA15284@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

This commit fixes a spelling mistake in a pr_info() message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4d4637c..0765784 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -57,7 +57,7 @@ static void __init rcu_bootup_announce_oddness(void)
 	if (qlowmark != DEFAULT_RCU_QLOMARK)
 		pr_info("\tBoot-time adjustment of callback low-water mark to %ld.\n", qlowmark);
 	if (qovld != DEFAULT_RCU_QOVLD)
-		pr_info("\tBoot-time adjustment of callback overload leval to %ld.\n", qovld);
+		pr_info("\tBoot-time adjustment of callback overload level to %ld.\n", qovld);
 	if (jiffies_till_first_fqs != ULONG_MAX)
 		pr_info("\tBoot-time adjustment of first FQS scan delay to %ld jiffies.\n", jiffies_till_first_fqs);
 	if (jiffies_till_next_fqs != ULONG_MAX)
-- 
2.9.5

