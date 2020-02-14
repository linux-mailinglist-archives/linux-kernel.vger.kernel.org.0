Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88ED915F221
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 19:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392121AbgBNSGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 13:06:55 -0500
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:36643 "EHLO
        15.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392088AbgBNSGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:06:52 -0500
Received: from player798.ha.ovh.net (unknown [10.108.57.211])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id 327952232F8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 18:27:50 +0100 (CET)
Received: from sk2.org (cre33-1_migr-88-122-126-116.fbx.proxad.net [88.122.126.116])
        (Authenticated sender: steve@sk2.org)
        by player798.ha.ovh.net (Postfix) with ESMTPSA id 96C63F80209B;
        Fri, 14 Feb 2020 17:27:38 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] s390: remove obsolete ieee_emulation_warnings
Date:   Fri, 14 Feb 2020 18:26:28 +0100
Message-Id: <20200214172628.3598516-1-steve@sk2.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 15606661560320675101
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrjedtgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucfkpheptddrtddrtddrtddpkeekrdduvddvrdduvdeirdduudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s390 math emulation was removed with commit 5a79859ae0f3 ("s390:
remove 31 bit support"), rendering ieee_emulation_warnings useless.
The code still built because it was protected by CONFIG_MATHEMU, which
was no longer selectable.

This patch removes the sysctl_ieee_emulation_warnings declaration and
the sysctl entry declaration.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 arch/s390/include/asm/processor.h | 1 -
 kernel/sysctl.c                   | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 361ef5eda468..aadb3d0e2adc 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -84,7 +84,6 @@ void s390_update_cpu_mhz(void);
 void cpu_detect_mhz_feature(void);
 
 extern const struct seq_operations cpuinfo_op;
-extern int sysctl_ieee_emulation_warnings;
 extern void execve_tail(void);
 extern void __bpon(void);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d396aaaf19a3..ad5b88a53c5a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -805,15 +805,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= &maxolduid,
 	},
 #ifdef CONFIG_S390
-#ifdef CONFIG_MATHEMU
-	{
-		.procname	= "ieee_emulation_warnings",
-		.data		= &sysctl_ieee_emulation_warnings,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 	{
 		.procname	= "userprocess_debug",
 		.data		= &show_unhandled_signals,

base-commit: 359c92c02bfae1a6f1e8e37c298e518fd256642c
-- 
2.24.1

