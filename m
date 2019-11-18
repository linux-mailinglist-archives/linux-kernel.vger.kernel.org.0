Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6201007A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 15:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKROvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 09:51:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbfKROvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:51:07 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1607A2071B;
        Mon, 18 Nov 2019 14:51:06 +0000 (UTC)
Date:   Mon, 18 Nov 2019 09:51:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc ftrace broken due to "manual merge of the ftrace tree
 with the arm64 tree"
Message-ID: <20191118095104.0daebbc3@oasis.local.home>
In-Reply-To: <1573851994.5937.138.camel@lca.pw>
References: <1573849732.5937.136.camel@lca.pw>
        <20191115160230.78871d8f@gandalf.local.home>
        <1573851994.5937.138.camel@lca.pw>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 16:06:34 -0500
Qian Cai <cai@lca.pw> wrote:

> > Test this commit please: b83b43ffc6e4b514ca034a0fbdee01322e2f7022  
> 
> # git reset --hard b83b43ffc6e4b514ca034a0fbdee01322e2f7022
> 
> Yes, that one is bad.

Can you see if this patch fixes the issue for you?

Thanks!

-- Steve

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0f358be551cd..fd8f4dc661dc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -109,6 +109,13 @@
 #define MEM_DISCARD(sec) *(.mem##sec)
 #endif
 
+/* PowerPC defines ftrace_graph_stub in the code */
+#ifndef CONFIG_PPC
+# define DEFINE_FTRACE_GRAPH_STUB	ftrace_graph_stub = ftrace_stub;
+#else
+# define DEFINE_FTRACE_GRAPH_STUB
+#endif
+
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 #ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
 /*
@@ -120,17 +127,17 @@
 			__start_mcount_loc = .;			\
 			KEEP(*(__patchable_function_entries))	\
 			__stop_mcount_loc = .;			\
-			ftrace_graph_stub = ftrace_stub;
+			DEFINE_FTRACE_GRAPH_STUB
 #else
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			__start_mcount_loc = .;			\
 			KEEP(*(__mcount_loc))			\
 			__stop_mcount_loc = .;			\
-			ftrace_graph_stub = ftrace_stub;
+			DEFINE_FTRACE_GRAPH_STUB
 #endif
 #else
 # ifdef CONFIG_FUNCTION_TRACER
-#  define MCOUNT_REC()	ftrace_graph_stub = ftrace_stub;
+#  define MCOUNT_REC()	DEFINE_FTRACE_GRAPH_STUB
 # else
 #  define MCOUNT_REC()
 # endif
