Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C4211D429
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 18:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfLLRg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 12:36:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58723 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfLLRg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:36:56 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ifSOJ-0002Nd-Pz; Thu, 12 Dec 2019 17:36:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] rcu: fix spelling mistake "leval" -> "level"
Date:   Thu, 12 Dec 2019 17:36:43 +0000
Message-Id: <20191212173643.91135-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_info message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4d4637c361b7..0765784012f8 100644
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
2.24.0

