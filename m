Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FE716FA1F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 10:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBZJAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 04:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgBZJAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:00:06 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C35F21556;
        Wed, 26 Feb 2020 09:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582707605;
        bh=uGqLN9OKnBbyA8w53Dt2jn5v0hokTKXjpPNu+Z3TREY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1lw5J/iWUr9GLYjG8zm3AHcjeIW4m6epxKZsz6uTKdQRPFLbbyezyHfiblAonFwZe
         mZxWc1UtCobnTQFvmR+OHxCVFtoIB4NKZxrVuI5JLolF9BkfRYOB2zKdimiuU+srOo
         R2Hm9CrBISQv7vU7oAHfAbLvfPOirqo7e7AxOzco=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip V4 4/4] kprobes: Remove redundant arch_disarm_kprobe() call
Date:   Wed, 26 Feb 2020 18:00:01 +0900
Message-Id: <158270760109.18966.17040884471473886413.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158270755997.18966.3544449431956918068.stgit@devnote2>
References: <158270755997.18966.3544449431956918068.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to remove redundant arch_disarm_kprobe() call in
force_unoptimize_kprobe(). This arch_disarm_kprobe()
will be invoked if the kprobe is optimized but disabled,
but that means the kprobe (optprobe) is unused (and
unoptimized) state.

In that case, unoptimize_kprobe() puts it in freeing_list
and kprobe_optimizer (do_unoptimize_kprobes()) automatically
disarm it. Thus this arch_disarm_kprobe() is redundant.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6d76a6e3e1a5..627fc1b7011a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -675,8 +675,6 @@ static void force_unoptimize_kprobe(struct optimized_kprobe *op)
 	lockdep_assert_cpus_held();
 	arch_unoptimize_kprobe(op);
 	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
-	if (kprobe_disabled(&op->kp))
-		arch_disarm_kprobe(&op->kp);
 }
 
 /* Unoptimize a kprobe if p is optimized */

