Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBF5F0C84
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 04:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbfKFDHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 22:07:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38334 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387725AbfKFDHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:07:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id c13so17724567pfp.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLGrjQosLZG8AHjWDn6T7sZjbAuo85EaMbn+8AzIsvA=;
        b=nFDnOQimmLsCdYbzvwdZR3kSUFKSCbsDAcAhhLy1AfE+1h7HrFowUUat3j4zmKmMRs
         vwzll5hy/B6Mu794RrgX239Pj3JIVk56xQ/ws8tK+uBdJ1v0sCSCZYMH8l48XyoWWMfS
         zg+DAMyffxkpKb/kX9sujF5cbm8qvcRMO6lM/wYKYVAZUzA6W88Cr1zBF2P7by9WhrQB
         IJe7S3htDNq9cheKp8p4wEtqDH9FuoZAU5hkMYoPH64ci5PnXKpZiV3OcFGDIkjtNF3s
         89LihHClZaQnAJfvpB5wJd+J2n4Hzmyanj9jWy76c6s5mHdv+hT0ztUI9y5YKeuMq+79
         Zupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLGrjQosLZG8AHjWDn6T7sZjbAuo85EaMbn+8AzIsvA=;
        b=MhNMcBHrHRAwnf4OozKGmYItoIdSWWundApgUjCebGTX+UCQizAejYEv5Ks+tgOA9w
         qhLEQU8RwHtEOWBa/+llguLqOB4uXA12zVqsm9PDkFOZUsR+U/nMsFxEl0SqF/eCccb6
         JGFR6Ij/qUCNEJh6twL+vtAcUD3Iuae5qXZR0Q+e7l3CNT1HHxYHhEVNYxYLsuMjg0nt
         hlqylfAoTGciQTeY2IP5HSxriDoti6nptws6q/hVItWD3NWICTN33RQA2yi3UpUfvJ1A
         DBueEWeH8mGXIsDYC3OANlgodR/faSXJNh/Zmlp1CupJ7uRV7bRsqDgYo8QkzddM/hyK
         SEKw==
X-Gm-Message-State: APjAAAUgQfy/sABaJjidSFtBerdyeM6iPZ+HQYhzVg4BRelGExr0mPXp
        McrOaPiMBQq15nFmiYepaxB/JS/FqOI=
X-Google-Smtp-Source: APXvYqwZzJawIa8XHmLjpIkoPKKxJ5LPLMIed9NU/O2RBZWz40TcqGklpLg1gbhPjPOYH5TCQuFIzg==
X-Received: by 2002:a65:5a02:: with SMTP id y2mr76403pgs.104.1573009672260;
        Tue, 05 Nov 2019 19:07:52 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:51 -0800 (PST)
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
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 27/50] riscv: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:18 +0000
Message-Id: <20191106030542.868541-28-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
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

Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-riscv@lists.infradead.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/riscv/kernel/stacktrace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index a76892b48fff..5b414ba9848b 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -98,16 +98,23 @@ static void notrace walk_stackframe(struct task_struct *task,
 
 static bool print_trace_address(unsigned long pc, void *arg)
 {
-	print_ip_sym(KERN_DEFAULT, pc);
+	const char *loglvl = arg;
+
+	print_ip_sym(loglvl, pc);
 	return false;
 }
 
-void show_stack(struct task_struct *task, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	pr_cont("Call Trace:\n");
-	walk_stackframe(task, NULL, print_trace_address, NULL);
+	walk_stackframe(task, NULL, print_trace_address, (void *)loglvl);
 }
 
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
+}
 
 static bool save_wchan(unsigned long pc, void *arg)
 {
-- 
2.23.0

