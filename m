Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85309186D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 15:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbgCPOlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 10:41:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33800 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731579AbgCPOlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:41:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id 23so10072258pfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R/bTQwUOG90VtsKBum9U3zSzv22t01bBu17KQ/JgogQ=;
        b=haZpj3nnoWxVdaIMwgxvAU/F9PiYgNTuq9GFb/vmABTSB/oW+Nv84m1y9m3v3wFMNd
         IaUpEpyt6JjOtYyCFsY9j/PEILRmIYnNftnYmkvg8etpW7IGeq0pq0688soKfHcZsDoX
         U6JGluL86DyqSoUEALlnxnW4+6s2PDXUR/kr/U0GY3gHwBZIuTfzRmGGBYnPRi8Q7Bko
         4XD6b7IBsEVYnfm3CVbe4Ciz0puLjxcIwSBs9Gi6YAwq047j6sk+quEn2cly/mePR2ga
         W5zpSSf1aiWI6O5W14zKS+cGvKlyoEiYFJPtPJwS+nP8KvVYk2tGmSDGIOpEgbLJzyNF
         XgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/bTQwUOG90VtsKBum9U3zSzv22t01bBu17KQ/JgogQ=;
        b=LQe4QGQgH2KXnhjCahPE41hHapL1hgktU/gJ25uTc2mbpM4phlSA5a8j7Yw1qX4mnx
         QhFLGosxU4gy5DcmpmGadlC5bJNKZXF7+zrBlU+V31W9hWSnd5b4AhKCwmNZ0B8HtYu1
         Y9dt6CkZq92q9QJz8tpzU2vLvMFI+4mJQ+P5UAnMV2quXMQtUTZYifzIicqWoZe0SJak
         Do/sHjui0kv0jMKGWcmmPplQ2cMHeeVPvKdH0JxEjjfbNahflKcnu2Nwk0+ZrSbzRYeT
         pG03Cyc5EljXTTYJUlxXGlNz7zyuEbUZTJwGFRaWzI3UmUhuIX40zlso1QJzaHSI+8Ae
         sF0Q==
X-Gm-Message-State: ANhLgQ1LiUDwCl8YctDjDO03/kJ7/UPUL5L/HeUaezECzPHEmC7jc+MT
        Krc1STWwFe6sdEamj3D6HiM1hvY+or1Jlw==
X-Google-Smtp-Source: ADFU+vuWJWA+c9SLF4PD/7/QFixZseHXoKiv9UQWtqYHjIhMQGDH+dGnGy1niZWdTPUnbe1yDynYmQ==
X-Received: by 2002:a63:f752:: with SMTP id f18mr208054pgk.196.1584369690090;
        Mon, 16 Mar 2020 07:41:30 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:41:29 -0700 (PDT)
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
        Jonas Bonn <jonas@southpole.se>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCHv2 24/50] openrisc: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:50 +0000
Message-Id: <20200316143916.195608-25-dima@arista.com>
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

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: openrisc@lists.librecores.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/openrisc/kernel/traps.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 932a8ec2b520..9d5a85dd1992 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -41,18 +41,26 @@ unsigned long __user *lwa_addr;
 
 void print_trace(void *data, unsigned long addr, int reliable)
 {
-	pr_emerg("[<%p>] %s%pS\n", (void *) addr, reliable ? "" : "? ",
+	const char *loglvl = data;
+
+	printk("%s[<%p>] %s%pS\n", loglvl, (void *) addr, reliable ? "" : "? ",
 	       (void *) addr);
 }
 
 /* displays a short stack trace */
-void show_stack(struct task_struct *task, unsigned long *esp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *esp,
+		const char *loglvl)
 {
 	if (esp == NULL)
 		esp = (unsigned long *)&esp;
 
-	pr_emerg("Call trace:\n");
-	unwind_stack(NULL, esp, print_trace);
+	printk("%sCall trace:\n", loglvl);
+	unwind_stack((void *)loglvl, esp, print_trace);
+}
+
+void show_stack(struct task_struct *task, unsigned long *esp)
+{
+	show_stack_loglvl(task, esp, KERN_EMERG);
 }
 
 void show_trace_task(struct task_struct *tsk)
-- 
2.25.1

