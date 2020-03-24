Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 393041915D9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgCXQNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:13:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36916 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgCXQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=heV7ZlB/DHsLTcnEevfvbwvxgJhlctXESkT1ov9n8cQ=; b=E/MzrpCvIY4vx/iWg4yKwVEaBl
        esQCicKROBFlHX2+qToZ9J06Lzyc3u2V6i2a+ClL9xcYTgBENGaxOfW4zzuZvfGypozolIXm1PgUO
        5ZPQ4NlzP5kDRuVbnNZa3gYCDX1qm+jRAfAjy4h0is45IUCawvgud1IQb/Mb96+V2CejWHjpaSCmd
        nzVJmE25adVP41bZ0NMdaHvyQHteUHWgnIuHE+ow9j8yMPSrfhP/Kcuo2VcHVjed/9R4UGPGjCVJZ
        NXeh4zCDhQ0pzmTFWF7xJ0dk2L/EIS7uxHc984uThBSdDQsoVcfCx51vMuv/ISjr86MbySmL8K0f5
        89GlrPWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9J-0006bO-Or; Tue, 24 Mar 2020 16:11:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33FB130610C;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2364D29A490F3; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160924.143334345@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 04/26] x86/kexec: Use RIP relative addressing
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally identity_mapped is not visible to objtool, due to:

  arch/x86/kernel/Makefile:OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o := y

However, when we want to run objtool on vmlinux.o there is no hiding
it:

  vmlinux.o: warning: objtool: .text+0x4c0f1: unsupported intra-function call

Replace the (i386 inspired) pattern:

	call 1f
  1:	popq %r8
	subq $(1b - relocate_kernel), %r8

With a x86_64 RIP-relative LEA:

	leaq relocate_kernel(%rip), %r8

Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/relocate_kernel_64.S |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -196,10 +196,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_ma
 
 	/* get the re-entry point of the peer system */
 	movq	0(%rsp), %rbp
-	call	1f
-1:
-	popq	%r8
-	subq	$(1b - relocate_kernel), %r8
+	leaq	relocate_kernel(%rip), %r8
 	movq	CP_PA_SWAP_PAGE(%r8), %r10
 	movq	CP_PA_BACKUP_PAGES_MAP(%r8), %rdi
 	movq	CP_PA_TABLE_PAGE(%r8), %rax


