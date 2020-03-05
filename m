Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FCA17A244
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 10:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCEJeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 04:34:01 -0500
Received: from m97134.mail.qiye.163.com ([220.181.97.134]:12473 "EHLO
        m97134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgCEJeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:34:00 -0500
Received: from localhost.localdomain (unknown [101.207.233.66])
        by smtp5 (Coremail) with SMTP id huCowAD39vRrx2BelXvUAA--.376S2;
        Thu, 05 Mar 2020 17:33:31 +0800 (CST)
From:   Yu Chen <chen.yu@easystack.cn>
To:     tglx@linutronix.de, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        yuchen1988@aliyun.com, Yu Chen <chen.yu@easystack.cn>
Subject: [PATCH] x86/cpuid: Use macro instead of number in cpuid_read()
Date:   Thu,  5 Mar 2020 17:33:18 +0800
Message-Id: <20200305093318.12235-1-chen.yu@easystack.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: huCowAD39vRrx2BelXvUAA--.376S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUPna9UUUUU
X-Originating-IP: [101.207.233.66]
X-CM-SenderInfo: hfkh0h11x6vtxv1v3tlfnou0/1tbiHQvdoFpciCeLTQAAsE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make and use macro CHUNK_SIZE, instead of numeric value 16 in
cpuid_read().

Signed-off-by: Yu Chen <chen.yu@easystack.cn>
---
 arch/x86/kernel/cpuid.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index 3492aa36b..f7d7e0ef7 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -48,6 +48,9 @@ struct cpuid_regs_done {
 	struct completion done;
 };
 
+/* cpuid must be read in chunks of 16 bytes */
+#define CHUNK_SIZE	16
+
 static void cpuid_smp_cpuid(void *cmd_block)
 {
 	struct cpuid_regs_done *cmd = cmd_block;
@@ -69,11 +72,11 @@ static ssize_t cpuid_read(struct file *file, char __user *buf,
 	ssize_t bytes = 0;
 	int err = 0;
 
-	if (count % 16)
+	if (count % CHUNK_SIZE)
 		return -EINVAL;	/* Invalid chunk size */
 
 	init_completion(&cmd.done);
-	for (; count; count -= 16) {
+	for (; count; count -= CHUNK_SIZE) {
 		call_single_data_t csd = {
 			.func = cpuid_smp_cpuid,
 			.info = &cmd,
@@ -86,12 +89,12 @@ static ssize_t cpuid_read(struct file *file, char __user *buf,
 		if (err)
 			break;
 		wait_for_completion(&cmd.done);
-		if (copy_to_user(tmp, &cmd.regs, 16)) {
+		if (copy_to_user(tmp, &cmd.regs, CHUNK_SIZE)) {
 			err = -EFAULT;
 			break;
 		}
-		tmp += 16;
-		bytes += 16;
+		tmp += CHUNK_SIZE;
+		bytes += CHUNK_SIZE;
 		*ppos = ++pos;
 		reinit_completion(&cmd.done);
 	}
-- 
2.17.1


