Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401FD194EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 03:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgC0C2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 22:28:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47832 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgC0C2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:28:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHejd-003hG3-Up; Fri, 27 Mar 2020 02:28:37 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 6/8] x86: don't reload after cmpxchg in unsafe_atomic_op2() loop
Date:   Fri, 27 Mar 2020 02:28:34 +0000
Message-Id: <20200327022836.881203-6-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327022836.881203-1-viro@ZenIV.linux.org.uk>
References: <x86: unsafe_put-style macro for sigmask>
 <20200327022836.881203-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

lock cmpxchg leaves the current value in eax; no need to reload it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/futex.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index 53c07ab63762..d5d36f408ad0 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -34,17 +34,17 @@ do {								\
 do {								\
 	int oldval = 0, ret, tem;				\
 	asm volatile("1:\tmovl	%2, %0\n"			\
-		     "\tmovl\t%0, %3\n"				\
+		     "2:\tmovl\t%0, %3\n"			\
 		     "\t" insn "\n"				\
-		     "2:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"	\
-		     "\tjnz\t1b\n"				\
-		     "3:\n"					\
+		     "3:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"	\
+		     "\tjnz\t2b\n"				\
+		     "4:\n"					\
 		     "\t.section .fixup,\"ax\"\n"		\
-		     "4:\tmov\t%5, %1\n"			\
+		     "5:\tmov\t%5, %1\n"			\
 		     "\tjmp\t3b\n"				\
 		     "\t.previous\n"				\
-		     _ASM_EXTABLE_UA(1b, 4b)			\
-		     _ASM_EXTABLE_UA(2b, 4b)			\
+		     _ASM_EXTABLE_UA(1b, 5b)			\
+		     _ASM_EXTABLE_UA(3b, 5b)			\
 		     : "=&a" (oldval), "=&r" (ret),		\
 		       "+m" (*uaddr), "=&r" (tem)		\
 		     : "r" (oparg), "i" (-EFAULT), "1" (0));	\
-- 
2.11.0

