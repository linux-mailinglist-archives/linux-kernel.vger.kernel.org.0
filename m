Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4D486F40
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 03:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405344AbfHIBZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 21:25:37 -0400
Received: from foss.arm.com ([217.140.110.172]:40424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404978AbfHIBZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 21:25:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 038DF1596;
        Thu,  8 Aug 2019 18:25:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82E6F3F575;
        Thu,  8 Aug 2019 18:25:34 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>, Jia He <justin.he@arm.com>
Subject: [PATCH 1/2] vsprintf: Prevent crash when dereferencing invalid pointers for %pD
Date:   Fri,  9 Aug 2019 09:24:56 +0800
Message-Id: <20190809012457.56685-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid
pointers") prevents most crash except for %pD.
There is an additional pointer dereferencing before dentry_name.

At least, vma->file can be NULL and be passed to printk %pD in 
print_bad_pte, which can cause crash.

This patch fixes it with introducing a new file_dentry_name.

Signed-off-by: Jia He <justin.he@arm.com>
---
 lib/vsprintf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 63937044c57d..b4a119176fdb 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -869,6 +869,15 @@ char *dentry_name(char *buf, char *end, const struct dentry *d, struct printf_sp
 	return widen_string(buf, n, end, spec);
 }
 
+static noinline_for_stack
+char *file_dentry_name(char *buf, char *end, const struct file *f,
+			struct printf_spec spec, const char *fmt)
+{
+	if (check_pointer(&buf, end, f, spec))
+		return buf;
+
+	return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
+}
 #ifdef CONFIG_BLOCK
 static noinline_for_stack
 char *bdev_name(char *buf, char *end, struct block_device *bdev,
@@ -2166,9 +2175,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'C':
 		return clock(buf, end, ptr, spec, fmt);
 	case 'D':
-		return dentry_name(buf, end,
-				   ((const struct file *)ptr)->f_path.dentry,
-				   spec, fmt);
+		return file_dentry_name(buf, end, ptr, spec, fmt);
 #ifdef CONFIG_BLOCK
 	case 'g':
 		return bdev_name(buf, end, ptr, spec, fmt);
-- 
2.17.1

