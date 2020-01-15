Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B79BC13B83B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 04:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgAODlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 22:41:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbgAODkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 22:40:51 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E6ED222C3;
        Wed, 15 Jan 2020 03:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579059650;
        bh=PfXVwen4hTVjQMRYwec2sWG+kkHoy5njpKLA4uQB6ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9cEIHzPQuncy3JNYZdId3xal8IPCiO9Wwr57oKx99+i3pcdtkF+kUfOW6wtyVwtj
         KCVYDNWKR3+busVG47m5ApFhZtsxnF5WOwW3wP26ELaJK7C9A9Nb51BhHn0QF2Szhy
         d3wStf3FX3GjCMrQs2TDyHpxP+qSbE48mONW5Awk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH -tip V3 1/2] kprobes: Suppress the suspicious RCU warning on kprobes
Date:   Wed, 15 Jan 2020 12:40:46 +0900
Message-Id: <157905964590.2268.3265472584921714383.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157905963533.2268.4672153983131918123.stgit@devnote2>
References: <157905963533.2268.4672153983131918123.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anders reported that the lockdep warns that suspicious
RCU list usage in register_kprobe() (detected by
CONFIG_PROVE_RCU_LIST.) This is because get_kprobe()
access kprobe_table[] by hlist_for_each_entry_rcu()
without rcu_read_lock.

If we call get_kprobe() from the breakpoint handler context,
it is run with preempt disabled, so this is not a problem.
But in other cases, instead of rcu_read_lock(), we locks
kprobe_mutex so that the kprobe_table[] is not updated.
So, current code is safe, but still not good from the view
point of RCU.

Joel suggested that we can silent that warning by passing
lockdep_is_held() to the last argument of
hlist_for_each_entry_rcu().

Add lockdep_is_held(&kprobe_mutex) at the end of the
hlist_for_each_entry_rcu() to suppress the warning.

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Suggested-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/kprobes.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2625c241ac00..bd484392d789 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -326,7 +326,8 @@ struct kprobe *get_kprobe(void *addr)
 	struct kprobe *p;
 
 	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
-	hlist_for_each_entry_rcu(p, head, hlist) {
+	hlist_for_each_entry_rcu(p, head, hlist,
+				 lockdep_is_held(&kprobe_mutex)) {
 		if (p->addr == addr)
 			return p;
 	}

