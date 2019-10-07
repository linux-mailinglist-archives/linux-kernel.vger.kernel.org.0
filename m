Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2687CE033
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 13:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfJGLXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 07:23:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJGLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=anCtZSSKBswa15L3XwFcRjCLWE8G9OZyId+z8B3LRsc=; b=PnxfdJUfUDqQL5YEhzYC1O8ac/
        qxcu2MNk7Aes3tF/5ZH3UfUIkoZllR93yeSOndtsdwLpEYv6PmoJzEymE6MB+OgKSEIJK8fLjdS6d
        jt4O8lSwRrFZcs6ObnT9Qte2FWZKbDVhQUaACupsDDMBPb6qAtJJFJPrxzBPE4psl+yiQwO336w6Z
        k0zMmOQ4HIBXIdWVYBlv7Fi6e6p12f5rrvNRoDhVQJWEeBoUbJ0uLBI8a1936vcmFg8+zT5HTsg93
        V5ctrFGgand9p2wtkK8OfUhkzP0i1zW4twIpO4vY7zRSlxzxCc6rXi0kBM8p7B8JGmAvxVio5cRWP
        y+8yl6CQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6y-0003Gu-0x; Mon, 07 Oct 2019 11:23:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47CD930735B;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F044320244E44; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007090011.89165316.6@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:44:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, hjl.tools@gmail.com
Subject: [RFC][PATCH 2/9] jump_label, x86: Factor out the __jump_table generation
References: <20191007084443.79370128.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both arch_static_branch() and arch_static_branch_jump() have the same
blurb to generate the __jump_table entry, share it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/jump_label.h |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -20,15 +20,19 @@
 #include <linux/stringify.h>
 #include <linux/types.h>
 
+#define JUMP_TABLE_ENTRY				\
+	".pushsection __jump_table,  \"aw\" \n\t"	\
+	_ASM_ALIGN "\n\t"				\
+	".long 1b - . \n\t"				\
+	".long %l[l_yes] - . \n\t"			\
+	_ASM_PTR "%c0 + %c1 - .\n\t"			\
+	".popsection \n\t"
+
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
 		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
+		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
@@ -39,13 +43,9 @@ static __always_inline bool arch_static_
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
-		"2:\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
+		".byte 0xe9 \n\t"
+		".long %l[l_yes] - (. + 4) \n\t"
+		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;


