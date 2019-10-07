Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B46CE04F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 13:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfJGLXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 07:23:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfJGLXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1efpZnVQQzD6GRHRUJyg8lH/vE8q9Zxv48ymnMf9emI=; b=Kk5DvWGtx51ReU9ycEshqMPfke
        biXP2OeC/csBuxHx3nQL4sZRcy0PCsuunWU3ASNIRYvQlpDI8JWDJlTp3SaIIdTr0BQi9CaVMojbv
        M7xLcw+uWLQBSDzWoXccpJWli4oW+h1WNxbGtv2LjGmD9LsIbQ+JvTwFvu46sfrvFviOpbvDR8JvL
        ZCnwldfC7OD4IGTlp99kTDzW5Qmjob8QP/9q0u+ACoJEP+eO/yjHsN0z+EaUV1/1/wWlBDCzWate1
        j/KaQk9FGKxihiaqwczokQrx5AnPEMeYObYHVzbl7yDkJI0UczlA+dWf+UDdjcemwDHp6GTjfiHu1
        Dom1rapw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6y-0003HC-LT; Mon, 07 Oct 2019 11:23:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 537A73073C4;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 06BA220244E4A; Mon,  7 Oct 2019 13:23:27 +0200 (CEST)
Message-Id: <20191007090012.06154679.7@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:44:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, hjl.tools@gmail.com
Subject: [RFC][PATCH 5/9] jump_label, x86: Introduce jump_entry_size()
References: <20191007084443.79370128.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows architectures to have variable sized jumps.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/jump_label.h |    4 ++--
 arch/x86/kernel/jump_label.c      |    5 +++++
 include/linux/jump_label.h        |    9 +++++++++
 kernel/jump_label.c               |    2 +-
 4 files changed, 17 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -4,8 +4,6 @@
 
 #define HAVE_JUMP_LABEL_BATCH
 
-#define JUMP_LABEL_NOP_SIZE 5
-
 #ifdef CONFIG_X86_64
 # define STATIC_KEY_INIT_NOP P6_NOP5_ATOMIC
 #else
@@ -53,6 +51,8 @@ static __always_inline bool arch_static_
 	return true;
 }
 
+extern int arch_jump_entry_size(struct jump_entry *entry);
+
 #else	/* __ASSEMBLY__ */
 
 .macro STATIC_BRANCH_FALSE_LIKELY target, key
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -16,6 +16,11 @@
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
 
+int arch_jump_entry_size(struct jump_entry *entry)
+{
+	return JMP32_INSN_SIZE;
+}
+
 static const void *
 __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
 {
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -176,6 +176,15 @@ static inline void jump_entry_set_init(s
 	entry->key |= 2;
 }
 
+static inline int jump_entry_size(struct jump_entry *entry)
+{
+#ifdef JUMP_LABEL_NOP_SIZE
+	return JUMP_LABEL_NOP_SIZE;
+#else
+	return arch_jump_entry_size(entry);
+#endif
+}
+
 #endif
 #endif
 
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(jump_label_rate_limit)
 static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 {
 	if (jump_entry_code(entry) <= (unsigned long)end &&
-	    jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
+	    jump_entry_code(entry) + jump_entry_size(entry) > (unsigned long)start)
 		return 1;
 
 	return 0;


