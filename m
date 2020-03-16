Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DACC186D67
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 15:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbgCPOlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 10:41:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39435 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731622AbgCPOlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:41:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so2050767pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVarNpQRd3enJr5skp5lLNjTv2pf6YOr11ML5pu2Yek=;
        b=ZF3Y52u0OpJFPh48STHyOdMrekImctJYB/6uj1vEXJ0lk+iSEJXgw2qkzr1AWPELv+
         ngBiNYbxAbLJ5lTSqe8ljYaFGBMDfeMWeh7Se4+hRCjx1JfWdZgDmtyUt2BGjUUgRQK0
         dU1ciDrApj/+1TcPtjLR7fk8i7FtEq/8zl+inlyUw9CRUHOLFocsVZmFGW5RejO+mYQ9
         YyYmKU5mdojSRhRKJBCpnJLqnIzuAKOYmCwk+HnkxLVx9gtQ9DvEXQ/qOv+3VH5iiNc5
         KNJdUQVpy1XWJtF/3e8WeAiStQOJXJ7dvvst4q3caxZ0rKwBHxGtRKEjy/d8RCyrlezL
         08Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVarNpQRd3enJr5skp5lLNjTv2pf6YOr11ML5pu2Yek=;
        b=U7s6pqTAnSJHbu9QUnOXUUNuoAK2Sb7xP90xC11NmClVfgEp76V6DY8yVtGLoHjeW2
         1jcyqxfRrc6/v46zYsteLK9f/UeYfDhJLNFeZZj+a9VXx3mx2D67qU1u1rWKNeqU/+hK
         eVYidyz19iZaBg3jSopE3oBjbLVL3FzQKyY4eEyGC86KHk4lwzQUli2Fk1hzHR+TY4r3
         GvWKIjWNpPbAirqa382Zrw+CbggcZEDi874Bq9xRspHJGGRLTS4mWJLuYzu/NqtJzZ2E
         zx1f2ExUcULJF0JNLJV6T6msJPJXXUiCGRBVlbOfNyBCCrbFSlhLlkG9ymiI0eUE+XK9
         kM0A==
X-Gm-Message-State: ANhLgQ0ADnDhpsiA46timCHtlVvYdj/JtNj+cRSVj8g6l+viUnp5CDfV
        CMk4Rx+bvl9iYqpbmKx0Uml11VAyZx84zw==
X-Google-Smtp-Source: ADFU+vvrqZsjgKaBKROAwghGj2fq8+QLQkRmkD+WDTlJ3KuKLvlnh4/ky0QMhz20b0zlLt+YBMTwXA==
X-Received: by 2002:a65:6446:: with SMTP id s6mr186277pgv.5.1584369671473;
        Mon, 16 Mar 2020 07:41:11 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:41:10 -0700 (PDT)
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
        Michal Simek <monstr@monstr.eu>
Subject: [PATCHv2 20/50] microblaze: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:46 +0000
Message-Id: <20200316143916.195608-21-dima@arista.com>
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

Cc: Michal Simek <monstr@monstr.eu>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/microblaze/kernel/traps.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/microblaze/kernel/traps.c b/arch/microblaze/kernel/traps.c
index be726ee120fb..149ae534937e 100644
--- a/arch/microblaze/kernel/traps.c
+++ b/arch/microblaze/kernel/traps.c
@@ -31,7 +31,8 @@ static int __init kstack_setup(char *s)
 }
 __setup("kstack=", kstack_setup);
 
-void show_stack(struct task_struct *task, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	unsigned long words_to_show;
 	u32 fp = (u32) sp;
@@ -50,7 +51,7 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	if (kstack_depth_to_print && (words_to_show > kstack_depth_to_print))
 		words_to_show = kstack_depth_to_print;
 
-	pr_info("Kernel Stack:\n");
+	printk("%sKernel Stack:\n", loglvl);
 
 	/*
 	 * Make the first line an 'odd' size if necessary to get
@@ -65,14 +66,19 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 			words_to_show -= line1_words;
 		}
 	}
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 32, 4, (void *)fp,
+	print_hex_dump(loglvl, "", DUMP_PREFIX_ADDRESS, 32, 4, (void *)fp,
 		       words_to_show << 2, 0);
-	pr_info("\n\nCall Trace:\n");
-	microblaze_unwind(task, NULL, KERN_INFO);
-	pr_info("\n");
+	printk("%s\n\nCall Trace:\n", loglvl);
+	microblaze_unwind(task, NULL, loglvl);
+	printk("%s\n", loglvl);
 
 	if (!task)
 		task = current;
 
 	debug_show_held_locks(task);
 }
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_INFO);
+}
-- 
2.25.1

