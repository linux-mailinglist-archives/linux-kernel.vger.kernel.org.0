Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB399015D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 14:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfHPMY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 08:24:59 -0400
Received: from foss.arm.com ([217.140.110.172]:55858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfHPMY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:24:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E38B360;
        Fri, 16 Aug 2019 05:24:57 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 051553F706;
        Fri, 16 Aug 2019 05:24:55 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Cc:     peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC v4 12/18] arm64: assembler: Add macro to annotate asm function having non standard stack-frame.
Date:   Fri, 16 Aug 2019 13:23:57 +0100
Message-Id: <20190816122403.14994-13-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816122403.14994-1-raphael.gault@arm.com>
References: <20190816122403.14994-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions don't have standard stack-frames but are intended
this way. In order for objtool to ignore those particular cases
we add a macro that enables us to annotate the cases we chose
to mark as particular.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 include/linux/frame.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/frame.h b/include/linux/frame.h
index 02d3ca2d9598..1e35e58ab259 100644
--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -11,14 +11,31 @@
  *
  * For more information, see tools/objtool/Documentation/stack-validation.txt.
  */
+#ifndef __ASSEMBLY__
 #define STACK_FRAME_NON_STANDARD(func) \
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func
+#else
+	/*
+	 * This macro is the arm64 assembler equivalent of the
+	 * macro STACK_FRAME_NON_STANDARD define at
+	 * ~/include/linux/frame.h
+	 */
+	.macro	asm_stack_frame_non_standard	func
+	.pushsection ".discard.func_stack_frame_non_standard"
+	.quad	\func
+	.popsection
+	.endm
 
+#endif /* __ASSEMBLY__ */
 #else /* !CONFIG_STACK_VALIDATION */
 
+#ifndef __ASSEMBLY__
 #define STACK_FRAME_NON_STANDARD(func)
-
+#else
+	.macro	asm_stack_frame_non_standard	func
+	.endm
+#endif /* __ASSEMBLY__ */
 #endif /* CONFIG_STACK_VALIDATION */
 
 #endif /* _LINUX_FRAME_H */
-- 
2.17.1

