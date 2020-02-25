Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230EC16B8D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 06:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgBYFNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 00:13:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46022 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBYFNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:13:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so6527299pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 21:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtFhZmUGg25ckYL+Nj/gQvxOaU7nm2sSSfbBJDheRi8=;
        b=cYoKF8t4ZKo9npvA7QP9XflS8FuxXhlRBK6xAEmgOI8SDB3qsyrUamZa+IZxIQeHEl
         hic9kuq1J+X/MvlwBhVTB5UE5AibQJRe0f4VCVIgnILVgGTTdcdSXyNKEVybEbiEpVNI
         KIqP3vXsNrYdk9Oin86blNR1kimWfFn+e1wBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtFhZmUGg25ckYL+Nj/gQvxOaU7nm2sSSfbBJDheRi8=;
        b=sJL7cc7chdDmvOGVQBn8sDc35W1vkE7u5XEVKiOpPF7CXxY1DMkrfD1W2jxZ0x9RX8
         MxqVftCH1SxkL7mFdQcO/7a2l2k7QyY+IXvFVmCcg9yhmEOwzmCjmhBSbUZ4U+GNKP8V
         XPJU04w1GUtmEeMwjfulvb61s5qJmN1Jeykn+28auyaFdWouiwCH5KupNU9M+k9UOZA0
         gOCvUVvENOBrbRvJ/1CrXSUyfmczbCjlS3hmK9lDQu+ZCCtDqng73vFneLWHjS9XTdCU
         a7jii81LuUrsYl0kc2Hr8cBSRCeOF65LBYZVKlLjnrVRwIex3jmuIOwc5qkGCrQAE48v
         BIUw==
X-Gm-Message-State: APjAAAUgYcoKOP286QJmLFZjfGByG59TVaQ4UTp07nzcewM+AGTpXKzX
        9qGphyy1Hyd9B0h4q8EVvvJAgg==
X-Google-Smtp-Source: APXvYqwODtU4FUfT5WxcMcB9c17YZwUi3dfzZeLH4lgWsLytNLFPaPcQmbSyyLc8Ik4xhECJhuDusg==
X-Received: by 2002:a63:d40d:: with SMTP id a13mr57785788pgh.9.1582607593779;
        Mon, 24 Feb 2020 21:13:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c19sm15219696pfc.144.2020.02.24.21.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:13:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] x86/elf: Split READ_IMPLIES_EXEC from executable GNU_STACK
Date:   Mon, 24 Feb 2020 21:13:03 -0800
Message-Id: <20200225051307.6401-3-keescook@chromium.org>
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

[1] https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
[2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=54ee14b3882
[3] https://lkml.kernel.org/r/20190423192534.GN23599@brightrain.aerifal.cx

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 arch/x86/include/asm/elf.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 733f69c2b053..a7035065377c 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -288,12 +288,13 @@ extern u32 elf_hwcap2;
  * ELF:              |            |                  |                |
  * -------------------------------|------------------|----------------|
  * missing GNU_STACK | exec-all   | exec-all         | exec-all       |
- * GNU_STACK == RWX  | exec-all   | exec-all         | exec-all       |
+ * GNU_STACK == RWX  | exec-stack | exec-stack       | exec-stack     |
  * GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |
  *
  *  exec-all  : all PROT_READ user mappings are executable, except when
  *              backed by files on a noexec-filesystem.
  *  exec-none : only PROT_EXEC user mappings are executable.
+ *  exec-stack: only the stack and PROT_EXEC user mappings are executable.
  *
  *  *this column has no architectural effect: NX markings are ignored by
  *   hardware, but may have behavioral effects when "wants X" collides with
@@ -302,7 +303,7 @@ extern u32 elf_hwcap2;
  *
  */
 #define elf_read_implies_exec(ex, executable_stack)	\
-	(executable_stack != EXSTACK_DISABLE_X)
+	(executable_stack == EXSTACK_DEFAULT)
 
 struct task_struct;
 
-- 
2.20.1

