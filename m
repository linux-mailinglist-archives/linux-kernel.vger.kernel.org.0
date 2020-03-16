Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6CB186D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 15:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbgCPOm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 10:42:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39845 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731714AbgCPOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id j20so8100533pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8p0yeIcDDezmi9GbceAY0OPGEypVpr3xgacLi8Ixrk=;
        b=FbBFOHxZVS4/eT17oknt23ldgwClYWRrb2me4lpmyGfjwdEqsIXcGwt8R8yojEnAcT
         aWsQmKEdkj+B96AOdVFSSLv77HKthLpL5PChdOPDPFmiDrKniaFsPuDt72sqpJoWg7ge
         sIBFobDCEzQhlH+SDlaHsJ19gYJhaxRh5Mkm+sfCA7CGag0UUZHu9fSX0IG74JfPUH5u
         Rvtj9v7FDYYRYM95BTlG5cm+5qH+mnjZd6GAZ780TV1xN4TRPlBJd6bSnwZwemNUyF9P
         JP2OgWfNXCDFL32dgIuNCrmW0P06FhqOk1jrHsn5QOzgrc+QHo8833MQTdEeiRpP9qw+
         TEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8p0yeIcDDezmi9GbceAY0OPGEypVpr3xgacLi8Ixrk=;
        b=QZ9//EVB5BBog7J5PO7RA9VTiQpRZGscu0H+hLR7qwbnSDrv6vXnf5Nq7icEAFnkoJ
         DE/vACiHfpLVXnE5f7bHG0khVPt1NVySxCWnFVElkrYduXryWGXq8i2I4MmfPS85qGah
         wRRkv8nIfxFuA/jlyJU/eiyq4AVwEYzVVem+9Vaqi22upSK+fdQYYaNARIJ1OMIne6eL
         tCUPJwipMdLsfh+fkA8xZreWnMIG+kvJOHpTv0fZEYx0haNAOt67XZwpFZJA97uUM60+
         WuPJC9V1QJCf8iqb5moOQOyEMix6dWxoS72VhYHp8I3cwlSk+dRj6wJgbP3QEVSistpu
         n76A==
X-Gm-Message-State: ANhLgQ0VEKI/5pFn+/PQh7yGTf4LtwRsUmiDBquWEeehbaIIlyileDDC
        /U/NhNaYwgosTLXmIMxr8WRWYY3qNBy8Cw==
X-Google-Smtp-Source: ADFU+vt+0qWtNtxxBe5a1CCrXYAs58UnPli9XAxfj21ypYJQF2FNN0jslFB12cV030/A97i1PEhaDQ==
X-Received: by 2002:a17:90a:c301:: with SMTP id g1mr25095750pjt.88.1584369743054;
        Mon, 16 Mar 2020 07:42:23 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:42:22 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
Subject: [PATCHv2 36/50] um: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:39:02 +0000
Message-Id: <20200316143916.195608-37-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Introduce show_stack_loglvl(), that eventually will substitute
show_stack().

Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/um/kernel/sysrq.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index c831a1c2eb94..1b54b6431499 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -17,7 +17,9 @@
 
 static void _print_addr(void *data, unsigned long address, int reliable)
 {
-	pr_info(" [<%08lx>] %s%pS\n", address, reliable ? "" : "? ",
+	const char *loglvl = data;
+
+	printk("%s [<%08lx>] %s%pS\n", loglvl, address, reliable ? "" : "? ",
 		(void *)address);
 }
 
@@ -25,7 +27,8 @@ static const struct stacktrace_ops stackops = {
 	.address = _print_addr
 };
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		       const char *loglvl)
 {
 	struct pt_regs *segv_regs = current->thread.segv_regs;
 	int i;
@@ -39,17 +42,22 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 	if (!stack)
 		stack = get_stack_pointer(task, segv_regs);
 
-	pr_info("Stack:\n");
+	printk("%sStack:\n", loglvl);
 	for (i = 0; i < 3 * STACKSLOTS_PER_LINE; i++) {
 		if (kstack_end(stack))
 			break;
 		if (i && ((i % STACKSLOTS_PER_LINE) == 0))
-			pr_cont("\n");
+			printk("%s\n", loglvl);
 		pr_cont(" %08lx", *stack++);
 	}
-	pr_cont("\n");
+	printk("%s\n", loglvl);
+
+	printk("%sCall Trace:\n", loglvl);
+	dump_trace(current, &stackops, (void *)loglvl);
+	printk("%s\n", loglvl);
+}
 
-	pr_info("Call Trace:\n");
-	dump_trace(current, &stackops, NULL);
-	pr_info("\n");
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_INFO);
 }
-- 
2.25.1

