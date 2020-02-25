Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B5816B8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 06:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgBYFNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 00:13:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44869 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgBYFNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:13:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id y5so6533412pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 21:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2lIWrB2rl2fls1DP3gLk6fTzwbihtKCjsTFZYdDbGQ4=;
        b=DPDiTUn9mHAJPUVeuO6O/4+ZWGT7CXMflUkvN2DOGwNzNVpUoWmOyBDAPPODhXWKny
         NAGKI6c4hPVF4ebdPpwklU4evW4Jv0T46fb90WvXFEfUBpzH+zSH2ffMjDvLcQk8cmtw
         yow7naoX3eK49OZ2mSrrxi/CmK2iPRw64SR2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2lIWrB2rl2fls1DP3gLk6fTzwbihtKCjsTFZYdDbGQ4=;
        b=VJK18KDyxxTMioZDmtXYnQe+qlNTgCN9RcmYMmzwDIhrBo/QER9E9kCUqOByFW8csg
         8VjF8FwBpsn2R0Cpq+qUccedC50SKBAP9g7lzwgqGV/N0h/g5dDrrjoANB2d9m9tmFN5
         cKmSiYsZRFgBcHUkYqPL2Pwv3ZBOR4zrYXiqren/hMxe1xj43cfKa7cA9clwbRD9jylj
         4FifdeLu5sbJiwrRmN7JAnjIKtRfE7UwKnyGg/4q1GJRNPZbRH9B8JKoLMn+p+3dzTo8
         VqjvUNJRExGWXT+Wjy2JubWgRlkZCzYKj1T6bI9lQLY6amvzyfd6eGKk2+uVMFTlM9CX
         45Cg==
X-Gm-Message-State: APjAAAUK9WhKPJn4x6LBvitRFVNHt0iLNcLNJINXovxWgKUSnMFYLWR5
        hm2jxe8ZraM374LYt5pLOUYJZw==
X-Google-Smtp-Source: APXvYqypIEhUi0EJIgMKTYt0m4YMRHeIhF58LfEi+94S8qvARJ0jimCVUlM03w63T/gtF6c3CH2Xsg==
X-Received: by 2002:aa7:8101:: with SMTP id b1mr56045649pfi.105.1582607596919;
        Mon, 24 Feb 2020 21:13:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 23sm15084529pfh.28.2020.02.24.21.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:13:15 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] arm32/64, elf: Split READ_IMPLIES_EXEC from executable GNU_STACK
Date:   Mon, 24 Feb 2020 21:13:06 -0800
Message-Id: <20200225051307.6401-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225051307.6401-1-keescook@chromium.org>
References: <20200225051307.6401-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The READ_IMPLIES_EXEC work-around was designed for old toolchains that
lacked the ELF PT_GNU_STACK marking under the assumption that toolchains
that couldn't specify executable permission flags for the stack may not
know how to do it correctly for any memory region.

This logic is sensible for having ancient binaries coexist in a system
with possibly NX memory, but was implemented in a way that equated having
a PT_GNU_STACK marked executable as being as "broken" as lacking the
PT_GNU_STACK marking entirely. Things like unmarked assembly and stack
trampolines may cause PT_GNU_STACK to need an executable bit, but they
do not imply all mappings must be executable.

This confusion has led to situations where modern programs with explicitly
marked executable stack are forced into the READ_IMPLIES_EXEC state when
no such thing is needed. (And leads to unexpected failures when mmap()ing
regions of device driver memory that wish to disallow VM_EXEC[1].)

In looking for other reasons for the READ_IMPLIES_EXEC behavior, Jann
Horn noted that glibc thread stacks have always been marked RWX (until
2003 when they started tracking the PT_GNU_STACK flag instead[2]). And
musl doesn't support executable stacks at all[3]. As such, no breakage
for multithreaded applications is expected from this change.

This changes arm32 and arm64 compat together, to keep behavior the same.

[1] https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
[2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=54ee14b3882
[3] https://lkml.kernel.org/r/20190423192534.GN23599@brightrain.aerifal.cx

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/elf.c        | 5 +++--
 arch/arm64/include/asm/elf.h | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index 2f69cf978fe3..6965a673a141 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -87,12 +87,13 @@ EXPORT_SYMBOL(elf_set_personality);
  * ELF:              |            |            |
  * -------------------------------|------------|
  * missing GNU_STACK | exec-all   | exec-all   |
- * GNU_STACK == RWX  | exec-all   | exec-all   |
+ * GNU_STACK == RWX  | exec-all   | exec-stack |
  * GNU_STACK == RW   | exec-all   | exec-none  |
  *
  *  exec-all  : all PROT_READ user mappings are executable, except when
  *              backed by files on a noexec-filesystem.
  *  exec-none : only PROT_EXEC user mappings are executable.
+ *  exec-stack: only the stack and PROT_EXEC user mappings are executable.
  *
  *  *this column has no architectural effect: NX markings are ignored by
  *   hardware, but may have behavioral effects when "wants X" collides with
@@ -102,7 +103,7 @@ EXPORT_SYMBOL(elf_set_personality);
  */
 int arm_elf_read_implies_exec(int executable_stack)
 {
-	if (executable_stack != EXSTACK_DISABLE_X)
+	if (executable_stack == EXSTACK_DEFAULT)
 		return 1;
 	if (cpu_architecture() < CPU_ARCH_ARMv6)
 		return 1;
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 7fc779e3f1ec..03ada29984a7 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -106,17 +106,18 @@
  * ELF:              |            |            |
  * -------------------------------|------------|
  * missing GNU_STACK | exec-all   | exec-all   |
- * GNU_STACK == RWX  | exec-all   | exec-all   |
+ * GNU_STACK == RWX  | exec-stack | exec-stack |
  * GNU_STACK == RW   | exec-none  | exec-none  |
  *
  *  exec-all  : all PROT_READ user mappings are executable, except when
  *              backed by files on a noexec-filesystem.
  *  exec-none : only PROT_EXEC user mappings are executable.
+ *  exec-stack: only the stack and PROT_EXEC user mappings are executable.
  *
  *  *all arm64 CPUs support NX, so there is no "lacks NX" column.
  *
  */
-#define elf_read_implies_exec(ex,stk)	(stk != EXSTACK_DISABLE_X)
+#define elf_read_implies_exec(ex,stk)	(stk == EXSTACK_DEFAULT)
 
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
-- 
2.20.1

