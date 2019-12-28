Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 272BA12BD07
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 09:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfL1Irx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Dec 2019 03:47:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40408 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbfL1Irx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 03:47:53 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E3173902610BA9CE06EE;
        Sat, 28 Dec 2019 16:47:50 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Sat, 28 Dec 2019
 16:47:41 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <mark.rutland@arm.com>, <hch@infradead.org>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <yangyingliang@huawei.com>,
        <bobo.shaobowang@huawei.com>, <guohanjun@huawei.com>,
        <wcohen@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mtk.manpages@gmail.com>, <wezhang@redhat.com>
Subject: [PATCH] sys_personality: Add a optional arch hook arch_check_personality()
Date:   Sat, 28 Dec 2019 16:43:59 +0800
Message-ID: <20191228084359.133745-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently arm64 use __arm64_sys_arm64_personality() as its default
syscall. Now using a normal hook arch_check_personality() can reject
personality settings for special case of different archs.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 arch/arm64/kernel/sys.c |  6 +++---
 kernel/exec_domain.c    | 11 +++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index d5ffaaab31a7..751fbd57eb1e 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -28,12 +28,13 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
 }
 
-SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
+int arch_check_personality(unsigned int personality)
 {
 	if (personality(personality) == PER_LINUX32 &&
 		!system_supports_32bit_el0())
 		return -EINVAL;
-	return ksys_personality(personality);
+
+	return 0;
 }
 
 asmlinkage long sys_ni_syscall(void);
@@ -46,7 +47,6 @@ asmlinkage long __arm64_sys_ni_syscall(const struct pt_regs *__unused)
 /*
  * Wrappers to pass the pt_regs argument.
  */
-#define __arm64_sys_personality		__arm64_sys_arm64_personality
 
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	asmlinkage long __arm64_##sym(const struct pt_regs *);
diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
index f7a0512ddc23..ec6b16e30ed1 100644
--- a/kernel/exec_domain.c
+++ b/kernel/exec_domain.c
@@ -35,7 +35,18 @@ static int __init proc_execdomains_init(void)
 module_init(proc_execdomains_init);
 #endif
 
+static int __weak arch_check_personality(unsigned int personality)
+{
+	return 0;
+}
+
 SYSCALL_DEFINE1(personality, unsigned int, personality)
 {
+	int check;
+
+	check = arch_check_personality(personality);
+	if (check)
+		return check;
+
 	return ksys_personality(personality);
 }
-- 
2.20.1

