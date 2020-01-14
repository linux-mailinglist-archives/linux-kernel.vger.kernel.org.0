Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06DE7139F20
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 02:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgANBhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 20:37:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60630 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729081AbgANBhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:37:34 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 31963EB1957F3B2A33A1;
        Tue, 14 Jan 2020 09:37:33 +0800 (CST)
Received: from huawei.com (10.175.104.193) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 09:37:22 +0800
From:   Cheng Jian <cj.chengjian@huawei.com>
To:     <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <rostedt@goodmis.org>, <tglx@linutronix.de>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cj.chengjian@huawei.com>, <bobo.shaobowang@huawei.com>
Subject: [PATCH] x86/ftrace: use ftrace_write to simplify code
Date:   Tue, 14 Jan 2020 01:52:17 +0000
Message-ID: <20200114015217.9246-1-cj.chengjian@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace_write() can be used in ftrace_modify_code_direct(),
that make the code more brief.

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 arch/x86/kernel/ftrace.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 024c3053dbba..6b36ed2fd04d 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -114,6 +114,16 @@ static const unsigned char *ftrace_nop_replace(void)
 	return ideal_nops[NOP_ATOMIC5];
 }
 
+static int ftrace_write(unsigned long ip, const char *val, int size)
+{
+	ip = text_ip_addr(ip);
+
+	if (probe_kernel_write((void *)ip, val, size))
+		return -EPERM;
+
+	return 0;
+}
+
 static int
 ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
 		   unsigned const char *new_code)
@@ -138,10 +148,8 @@ ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
 	if (memcmp(replaced, old_code, MCOUNT_INSN_SIZE) != 0)
 		return -EINVAL;
 
-	ip = text_ip_addr(ip);
-
 	/* replace the text with the new text */
-	if (probe_kernel_write((void *)ip, new_code, MCOUNT_INSN_SIZE))
+	if (ftrace_write(ip, new_code, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
 	sync_core();
@@ -326,16 +334,6 @@ int ftrace_int3_handler(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(ftrace_int3_handler);
 
-static int ftrace_write(unsigned long ip, const char *val, int size)
-{
-	ip = text_ip_addr(ip);
-
-	if (probe_kernel_write((void *)ip, val, size))
-		return -EPERM;
-
-	return 0;
-}
-
 static int add_break(unsigned long ip, const char *old)
 {
 	unsigned char replaced[MCOUNT_INSN_SIZE];
-- 
2.17.1

