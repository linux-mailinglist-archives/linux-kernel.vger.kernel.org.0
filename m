Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBAF43B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfFMP3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:29:04 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:36476 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbfFML0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:26:22 -0400
Received: from [2a01:e35:39f2:1220:9dd7:c176:119b:4c9d] (helo=test.quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1hbNs2-00087D-OI; Thu, 13 Jun 2019 13:26:19 +0200
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Elena Reshetova <elena.reshetova@intel.com>
Date:   Thu, 13 Jun 2019 13:26:06 +0200
Message-Id: <cbabb2af40e5f0bdb516cf07aea6e8269d1df89a.1560423331.git.ydroneaud@opteya.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560423331.git.ydroneaud@opteya.com>
References: <cover.1560423331.git.ydroneaud@opteya.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:39f2:1220:9dd7:c176:119b:4c9d
X-SA-Exim-Mail-From: ydroneaud@opteya.com
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on ou.quest-ce.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham version=3.3.2
Subject: [PATCH 3/3] binfmt/elf: randomize padding between ELF interp info
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As AT_RANDOM is on top of the stack, retrieving AT_RANDOM value
through getauxval() could help, if needed, an attacker accesses
interesting locations in program stack, if offset from top of the
stack is fixed/known beforehand.

As a pure cargo-cult feature, inspired by "x86/entry/64: randomize
kernel stack offset upon syscall" [1], this patch adds small
random offsets between the top of the stack, AT_RANDOM array,
AT_PLAFORM strings, AT_BASE_PLATFORM strings, and the auxiliary
vector (aka. ELF interpretor info)

It introduces 16 possible different locations for AT_RANDOM array,
16 possible different locations for AT_PLATFORM, same for AT_BASE_PLATFORM,
and 16 more for the auxiliary vector.

Thus, at most 544 bytes (256 + 16 + 16 + 256) can be wasted in
padding.

This patch also enforces an 16bytes aligned AT_RANDOM array as
elf_stack_align() is used, regardless of arch_align_stack().

It should be noted, per ABI, it's not possible to insert random
padding between auxiliary vector and environment variables, nor
between environment variables and program arguments, nor before
programs arguments. (It should be possible to shuffle values
within auxillay and environment variables, if someone want to
scare userspace).

[1] https://www.openwall.com/lists/kernel-hardening/2019/03/29/3

Link: https://lore.kernel.org/lkml/cover.1560423331.git.ydroneaud@opteya.com
Cc: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 fs/binfmt_elf.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index cfcc01fff4ae..c84ef81f0639 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -182,6 +182,26 @@ static inline elf_addr_t __user *elf_stack_alloc(unsigned long *pp,
 	return sp;
 }
 
+static inline void elf_stack_randomize(unsigned long *pp, size_t range)
+{
+	u32 offset;
+	unsigned long p;
+
+	if (!(current->flags & PF_RANDOMIZE))
+		return;
+
+	offset = prandom_u32() % range;
+	p = *pp;
+
+#ifdef CONFIG_STACK_GROWSUP
+	p += offset;
+#else
+	p -= offset;
+#endif
+
+	*pp = p;
+}
+
 #ifndef ELF_BASE_PLATFORM
 /*
  * AT_BASE_PLATFORM indicates the "real" hardware/microarchitecture.
@@ -219,6 +239,9 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 
 	p = arch_align_stack(p);
 
+	elf_stack_randomize(&p, 256);
+	elf_stack_align(&p);
+
 	/*
 	 * Generate 16 random bytes for userspace PRNG seeding.
 	 */
@@ -237,6 +260,8 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	if (k_platform) {
 		size_t len = strlen(k_platform) + 1;
 
+		elf_stack_randomize(&p, 16);
+
 		u_platform = elf_stack_alloc(&p, len);
 		if (__copy_to_user(u_platform, k_platform, len))
 			return -EFAULT;
@@ -250,11 +275,16 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	if (k_base_platform) {
 		size_t len = strlen(k_base_platform) + 1;
 
+		elf_stack_randomize(&p, 16);
+
 		u_base_platform = elf_stack_alloc(&p, len);
 		if (__copy_to_user(u_base_platform, k_base_platform, len))
 			return -EFAULT;
 	}
 
+	elf_stack_randomize(&p, 256);
+	elf_stack_align(&p);
+
 	/* Create the ELF interpreter info */
 	elf_info = (elf_addr_t *)current->mm->saved_auxv;
 	/* update AT_VECTOR_SIZE_BASE if the number of NEW_AUX_ENT() changes */
-- 
2.21.0

