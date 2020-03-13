Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F204184F97
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 20:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgCMTwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 15:52:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46118 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbgCMTwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id t13so8605560qtn.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t6w2I6q0OvGhRNUeLfz0oSM7U+Ex2GvUMSNIUYfuFaU=;
        b=H74k2KZfe2EXM2SgaQuOPgCIKd6Rm3J7KTdY6iUqqVUurvVSGrIKVzjYdQXcrrVJcL
         a7la9TUzyxZJrOZc8eLCRvTAEKaL8x95rPJPhLipvhqamyBT1YHB3ebBSP8WAp+nzuQJ
         Xh02BKs7FbETyT7/9ZyaHWlEPnyhWSMsu/ZSQyU5fSVh0rurxrnf621d9nkWNhlgDGHf
         vI3H4rdrxpVAL84R2dQq0gnecKplzHE4eVSiq1ngRcZ8wOJ7MkCmIP60REGa2mpbRN8q
         jWivH7nV72lqagXA7CRXBJBBhs7r/axXojqwCXlNV3Cy5Tohed3ChFwRKJQjBoDDhYJ1
         4etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t6w2I6q0OvGhRNUeLfz0oSM7U+Ex2GvUMSNIUYfuFaU=;
        b=nj0RyrHlRpLUS90FmT8cYwvfPns2E17YD6O30bwkkis9heh8Izx0n1g7fvf5vrfpl8
         47cT1EP4PUMPkSkRfzGM4uIP0cqapTcEnosoh7Vo9WDcLSlcvYG/EcqphiPhzDV4p0mr
         313CQs0K36FpIzJBgebi0bfY79vkCcz9Beks/76vkPv5qaqrU5hUDMTDYEhgxvTcvg7R
         CrIvcFcqYkopLKqR+g6POM86FQBDdKIfM6Vdo1wmW5hKoXVRvICBoH07sDh0StIPJfPs
         EGnqk7iR84lSF+pQDNom4v8yQ5Srf9x8bgHO05g15elAAltDiEQpByRPie6jC4dWaxhA
         H3Zw==
X-Gm-Message-State: ANhLgQ2XP9oOeM3q0P3NXChTvzxIFfnCYDeBp5CJdptQmHjc8jzscm16
        ysX87gwS55NqAxqPmyX2Lc6BJzk=
X-Google-Smtp-Source: ADFU+vtSZPtgTK/Wpkm7E49h5e9O3CmXMwJimniP8iD3nzN1pvBJ4VrPys5vJTxyLFpYnenOWiUvJA==
X-Received: by 2002:ac8:2fc1:: with SMTP id m1mr14041350qta.48.1584129143687;
        Fri, 13 Mar 2020 12:52:23 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:23 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 11/18] x86-64: Add __SYSCALL_COMMON()
Date:   Fri, 13 Mar 2020 15:51:37 -0400
Message-Id: <20200313195144.164260-12-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a __SYSCALL_COMMON() macro to the syscall table, which simplifies syscalltbl.sh.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/syscall_64.c           |  1 +
 arch/x86/entry/syscall_x32.c          |  3 +++
 arch/x86/entry/syscalls/syscalltbl.sh | 22 ++--------------------
 arch/x86/um/sys_call_table_64.c       |  3 +++
 4 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index bce4821a7e14..03645f9014d3 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -9,6 +9,7 @@
 #include <asm/syscall.h>
 
 #define __SYSCALL_X32(nr, sym)
+#define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
 
 #define __SYSCALL_64(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 21e306c5a401..57a151a3a4b4 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -11,10 +11,13 @@
 #define __SYSCALL_64(nr, sym)
 
 #define __SYSCALL_X32(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_COMMON(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_X32
+#undef __SYSCALL_COMMON
 
 #define __SYSCALL_X32(nr, sym) [nr] = sym,
+#define __SYSCALL_COMMON(nr, sym) [nr] = sym,
 
 asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
index b0519ddad8d7..6106ed37b8de 100644
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/arch/x86/entry/syscalls/syscalltbl.sh
@@ -25,7 +25,7 @@ emit() {
     fi
 
     # For CONFIG_UML, we need to strip the __x64_sys prefix
-    if [ "$abi" = "64" -a "${entry}" != "${entry#__x64_sys}" ]; then
+    if [ "${entry}" != "${entry#__x64_sys}" ]; then
 	    umlentry="sys${entry#__x64_sys}"
     fi
 
@@ -53,24 +53,6 @@ emit() {
 grep '^[0-9]' "$in" | sort -n | (
     while read nr abi name entry compat; do
 	abi=`echo "$abi" | tr '[a-z]' '[A-Z]'`
-	if [ "$abi" = "COMMON" -o "$abi" = "64" ]; then
-	    emit 64 "$nr" "$entry" "$compat"
-	    if [ "$abi" = "COMMON" ]; then
-		# COMMON means that this syscall exists in the same form for
-		# 64-bit and X32.
-		echo "#ifdef CONFIG_X86_X32_ABI"
-		emit X32 "$nr" "$entry" "$compat"
-		echo "#endif"
-	    fi
-	elif [ "$abi" = "X32" ]; then
-	    echo "#ifdef CONFIG_X86_X32_ABI"
-	    emit X32 "$nr" "$entry" "$compat"
-	    echo "#endif"
-	elif [ "$abi" = "I386" ]; then
-	    emit "$abi" "$nr" "$entry" "$compat"
-	else
-	    echo "Unknown abi $abi" >&2
-	    exit 1
-	fi
+	emit "$abi" "$nr" "$entry" "$compat"
     done
 ) > "$out"
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 7d057ea53d54..2e8544dafbb0 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -36,6 +36,9 @@
 #define stub_execveat sys_execveat
 #define stub_rt_sigreturn sys_rt_sigreturn
 
+#define __SYSCALL_X32(nr, sym)
+#define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
+
 #define __SYSCALL_64(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
 #include <asm/syscalls_64.h>
 
-- 
2.24.1

