Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81542A4429
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 12:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfHaKyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 06:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbfHaKyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:54:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D7892343A;
        Sat, 31 Aug 2019 10:54:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i411G-0001LU-PP; Sat, 31 Aug 2019 06:54:10 -0400
Message-Id: <20190831105410.678550292@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 31 Aug 2019 06:53:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [for-linus][PATCH 6/7] ftrace/x86: Remove mcount() declaration
References: <20190831105329.122820332@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Commit 562e14f72292 ("ftrace/x86: Remove mcount support") removed the
support for using mcount, so we could remove the mcount() declaration
to clean up.

Link: http://lkml.kernel.org/r/20190826170150.10f101ba@xhacker.debian

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/include/asm/ftrace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 287f1f7b2e52..c38a66661576 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -16,7 +16,6 @@
 #define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
 #ifndef __ASSEMBLY__
-extern void mcount(void);
 extern atomic_t modifying_ftrace_code;
 extern void __fentry__(void);
 
-- 
2.20.1


