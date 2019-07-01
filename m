Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE0124975
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 09:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfEUH4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 03:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfEUH4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:56:32 -0400
Received: from localhost.localdomain (unknown [153.145.222.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E847C21743;
        Tue, 21 May 2019 07:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558425391;
        bh=Kd2axNACunVGzNUeDo6iN2mIe+haKd+dBa4PNrVuls4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0/iPbht7l+CHlTUCKuxGbknJsk8/De4gmLjTUIsv8MICPB7GJxiDoY/6lNQE2qbs
         16EWvZ1168otFiJWextK0m3bW93n7PRT+RmHcU24UptidMAvNqid/FQQDSCSo4AyRO
         6vsGHjhX/GOjhioJVRdsHM10kKuV8Pq8F+am35y8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 1/2] kprobes: Initialize kprobes at subsys_initcall
Date:   Tue, 21 May 2019 16:56:26 +0900
Message-Id: <155842538677.4253.13061184325512815719.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155842537599.4253.14690293652007233645.stgit@devnote2>
References: <155842537599.4253.14690293652007233645.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize kprobes at subsys_initcall stage instead of module_init
since kprobes is not a module. This will allow ftrace kprobe
event to add new events when it is initializing because ftrace
kprobe event is initialized at fs_initcall.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c83e54727131..b7b6c90bb59c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2617,4 +2617,4 @@ static int __init debugfs_kprobe_init(void)
 late_initcall(debugfs_kprobe_init);
 #endif /* CONFIG_DEBUG_FS */
 
-module_init(init_kprobes);
+subsys_initcall(init_kprobes);

