Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6433308A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfFCNEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 09:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfFCNEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:04:48 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9117F27FCE;
        Mon,  3 Jun 2019 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559567087;
        bh=NLlyuoL8659H1E2jNxb1kSF6VtTnVPNy54AwF0w2a18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCglHfcTjyT8PmV+FXdBYjkt9g7gM/46ccpplI93C7bsmvcNDVoAbUyl/Z4xRRkQx
         YwUzMGfmSMw1auhhoWrkcBaEc9bezJ8DQY+7L6SkPkMIaLZ7P8xnUbcjg+fcTu/wJ8
         ErGNAF1+28ifKLsvAvydeLh9uNJpP03D4WVuwtD8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kprobes: Fix to init kprobes in subsys_initcall
Date:   Mon,  3 Jun 2019 22:04:42 +0900
Message-Id: <155956708268.12228.10363800793132214198.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603214105.715a4072472ef4946123dc20@kernel.org>
References: <20190603214105.715a4072472ef4946123dc20@kernel.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since arm64 kernel initializes breakpoint trap vector in arch_initcall(),
initializing kprobe (and run smoke test) in postcore_initcall() causes
a kernel panic.

To fix this issue, move the kprobe initialization in subsys_initcall()
(which is called right afer the arch_initcall).

In-kernel kprobe users (ftrace and bpf) are using fs_initcall() which is
called after subsys_initcall(), so this shouldn't cause more problem.

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Fixes: b5f8b32c93b2 ("kprobes: Initialize kprobes at postcore_initcall")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 54aaaad00a47..5471efbeb937 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2289,7 +2289,7 @@ static int __init init_kprobes(void)
 		init_test_probes();
 	return err;
 }
-postcore_initcall(init_kprobes);
+subsys_initcall(init_kprobes);
 
 #ifdef CONFIG_DEBUG_FS
 static void report_probe(struct seq_file *pi, struct kprobe *p,

