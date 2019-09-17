Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6812CB508E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 16:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfIQOiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 10:38:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26541 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfIQOiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:38:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F7CB8980EF;
        Tue, 17 Sep 2019 14:37:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.72])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4A7FF5DC18;
        Tue, 17 Sep 2019 14:37:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 17 Sep 2019 16:37:59 +0200 (CEST)
Date:   Tue, 17 Sep 2019 16:37:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     Jan Kratochvil <jan.kratochvil@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH? v2] powerpc: Hard wire PT_SOFTE value to 1 in gpr_get() too
Message-ID: <20190917143753.GA12300@redhat.com>
References: <20190917121256.GA8659@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917121256.GA8659@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Tue, 17 Sep 2019 14:37:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have a ppc machine, this patch wasn't even compile tested,
could you please review?

The commit a8a4b03ab95f ("powerpc: Hard wire PT_SOFTE value to 1 in
ptrace & signals") changed ptrace_get_reg(PT_SOFTE) to report 0x1,
but PTRACE_GETREGS still copies pt_regs->softe as is.

This is not consistent and this breaks
http://sourceware.org/systemtap/wiki/utrace/tests/user-regs-peekpoke

Reported-by: Jan Kratochvil <jan.kratochvil@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/powerpc/kernel/ptrace.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 8c92feb..291acfb 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -363,11 +363,36 @@ static int gpr_get(struct task_struct *target, const struct user_regset *regset,
 	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
 		     offsetof(struct pt_regs, msr) + sizeof(long));
 
+#ifdef CONFIG_PPC64
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &target->thread.regs->orig_gpr3,
+					  offsetof(struct pt_regs, orig_gpr3),
+					  offsetof(struct pt_regs, softe));
+
+	if (!ret) {
+		unsigned long softe = 0x1;
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &softe,
+					  offsetof(struct pt_regs, softe),
+					  offsetof(struct pt_regs, softe) +
+					  sizeof(softe));
+	}
+
+	BUILD_BUG_ON(offsetof(struct pt_regs, trap) !=
+		     offsetof(struct pt_regs, softe) + sizeof(long));
+
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &target->thread.regs->trap,
+					  offsetof(struct pt_regs, trap),
+					  sizeof(struct user_pt_regs));
+#else
 	if (!ret)
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 					  &target->thread.regs->orig_gpr3,
 					  offsetof(struct pt_regs, orig_gpr3),
 					  sizeof(struct user_pt_regs));
+#endif
 	if (!ret)
 		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
 					       sizeof(struct user_pt_regs), -1);
-- 
2.5.0


