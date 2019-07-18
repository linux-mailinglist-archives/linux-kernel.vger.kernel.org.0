Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC9A6D46E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 21:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391122AbfGRTKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 15:10:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37603 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfGRTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:10:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJAVkR2124193
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:10:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJAVkR2124193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477031;
        bh=VVZrK8XC1EDXz97I8f8S6DqnZv4qdr6FPsJHt33xAJY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nXQxeBQCkPxUq9RD29wAJb2ejzg/w78Oi43KAwd4FNZecH56Z6t05wK8l/qC9rlLf
         BuRabo+Qh/P706XVu5YbNZPKO95ClY7yojgd+HnGhjImYaGx8WJWrgNWo9dL4G3O9+
         lT/z8zuKr2VOCBQjdgmRJWJXOSpa7v4gmJk/6gRo0AOEOtAz2/J5sv2eSnvBCk7wkW
         TWVTh46gq1TUsFAdr+X/VLfhXNNozJ0UBMVM4ZsMygEKYY3JgevmNTlUQS65JN/ek+
         AzqykGiWscnl3VuZ0d+FBB4e9x4wfI7D3iS+OYzQcvOHpUdVAAh0HjxdUOC+gSBO3Y
         K8RwaV1xcac9w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJAUv52124190;
        Thu, 18 Jul 2019 12:10:30 -0700
Date:   Thu, 18 Jul 2019 12:10:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-e6dd47394493061c605285a868fc72eae2e9c866@git.kernel.org>
Cc:     hpa@zytor.com, jpoimboe@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
          peterz@infradead.org
In-Reply-To: <89c97adc9f6cc44a0f5d03cde6d0357662938909.1563413318.git.jpoimboe@redhat.com>
References: <89c97adc9f6cc44a0f5d03cde6d0357662938909.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] x86/entry: Fix thunk function ELF sizes
Git-Commit-ID: e6dd47394493061c605285a868fc72eae2e9c866
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_48_96,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e6dd47394493061c605285a868fc72eae2e9c866
Gitweb:     https://git.kernel.org/tip/e6dd47394493061c605285a868fc72eae2e9c866
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:40 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:04 +0200

x86/entry: Fix thunk function ELF sizes

Fix the following warnings:

  arch/x86/entry/thunk_64.o: warning: objtool: trace_hardirqs_on_thunk() is missing an ELF size annotation
  arch/x86/entry/thunk_64.o: warning: objtool: trace_hardirqs_off_thunk() is missing an ELF size annotation
  arch/x86/entry/thunk_64.o: warning: objtool: lockdep_sys_exit_thunk() is missing an ELF size annotation

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/89c97adc9f6cc44a0f5d03cde6d0357662938909.1563413318.git.jpoimboe@redhat.com

---
 arch/x86/entry/thunk_64.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index cfdca8b42c70..cc20465b2867 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -12,9 +12,7 @@
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
 	.macro THUNK name, func, put_ret_addr_in_rdi=0
-	.globl \name
-	.type \name, @function
-\name:
+	ENTRY(\name)
 	pushq %rbp
 	movq %rsp, %rbp
 
@@ -35,6 +33,7 @@
 
 	call \func
 	jmp  .L_restore
+	ENDPROC(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
 
