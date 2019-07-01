Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2D125F91
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 10:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfEVIca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 04:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbfEVIca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:32:30 -0400
Received: from devnote2.wi2.ne.jp (unknown [103.5.140.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C41F820644;
        Wed, 22 May 2019 08:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558513949;
        bh=xi0hd/CIk0ze4lSsjiKkjqQbHpgNdAFL9Zy8BVEz4tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8mm01EHRelbD9H5x89TMsnt3zJWAa36eQtDYcDr3fbMfkLWMWdty96+Iiqg6YFrA
         RW19pP9hDZyBTsY6ptCEVNwWJwUuVjPaEdft6/aeMKhzVUlFO60UItkN64Jn2mxuGn
         48Kk742n4E8aZ+sn95oaaha4s5k6IdqiQfA/VDCI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 1/2] kprobes: Initialize kprobes at postcore_initcall
Date:   Wed, 22 May 2019 17:32:27 +0900
Message-Id: <155851394736.15728.13626739508905120098.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155851393823.15728.9489409117921369593.stgit@devnote2>
References: <155851393823.15728.9489409117921369593.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize kprobes at postcore_initcall level instead of module_init
since kprobes is not a module, and it depends on only subsystems
initialized in core_initcall.
This will allow ftrace kprobe event to add new events when it is
initializing because ftrace kprobe event is initialized at
later initcall level.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v2
   - use postcore_initcall instead of subsys_initcall
---
 kernel/kprobes.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c83e54727131..5d51dd84b1a2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2291,6 +2291,7 @@ static int __init init_kprobes(void)
 		init_test_probes();
 	return err;
 }
+postcore_initcall(init_kprobes);
 
 #ifdef CONFIG_DEBUG_FS
 static void report_probe(struct seq_file *pi, struct kprobe *p,
@@ -2616,5 +2617,3 @@ static int __init debugfs_kprobe_init(void)
 
 late_initcall(debugfs_kprobe_init);
 #endif /* CONFIG_DEBUG_FS */
-
-module_init(init_kprobes);

