Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22D43168ACC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 01:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgBVAP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 19:15:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40488 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgBVAP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:15:26 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j5IRu-0006DV-LS; Sat, 22 Feb 2020 00:15:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] clone3: fix an unsigned args.cgroup comparison to less than zero
Date:   Sat, 22 Feb 2020 00:15:13 +0000
Message-Id: <20200222001513.43099-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The less than zero comparison of args.cgroup is aways false because
args.cgroup is a u64 and can never be less than zero.  I believe the
correct check is to cast args.cgroup to a s64 first to ensure an
invalid value is not copied to kargs->cgroup.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 67a5d691ffa8..98513a122dd1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2635,7 +2635,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     !valid_signal(args.exit_signal)))
 		return -EINVAL;
 
-	if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup < 0)
+	if ((args.flags & CLONE_INTO_CGROUP) && (s64)args.cgroup < 0)
 		return -EINVAL;
 
 	*kargs = (struct kernel_clone_args){
-- 
2.25.0

