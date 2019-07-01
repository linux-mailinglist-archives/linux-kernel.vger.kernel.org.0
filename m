Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79353278CC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 11:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfEWJGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 05:06:41 -0400
Received: from foss.arm.com ([217.140.101.70]:40776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbfEWJGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:06:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C296015BF;
        Thu, 23 May 2019 02:06:39 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A698E3F575;
        Thu, 23 May 2019 02:06:37 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>
Subject: [PATCH v4 3/4] arm64: add PTRACE_SYSEMU{,SINGLESTEP} definations to uapi headers
Date:   Thu, 23 May 2019 10:06:17 +0100
Message-Id: <20190523090618.13410-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523090618.13410-1-sudeep.holla@arm.com>
References: <20190523090618.13410-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 and um use 31 and 32 for PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP
while powerpc uses different value maybe for legacy reasons.

Though handling of PTRACE_SYSEMU can be made architecture independent,
it's hard to make these definations generic. To add to this existing
mess few architectures like arm, c6x and sh use 31 for PTRACE_GETFDPIC
(get the ELF fdpic loadmap address). It's not possible to move the
definations to generic headers.

So we unfortunately have to duplicate the same defination to ARM64 if
we need to support PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/include/uapi/asm/ptrace.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index d78623acb649..627ac57c1581 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -62,6 +62,9 @@
 #define PSR_x		0x0000ff00	/* Extension		*/
 #define PSR_c		0x000000ff	/* Control		*/
 
+/* syscall emulation path in ptrace */
+#define PTRACE_SYSEMU		  31
+#define PTRACE_SYSEMU_SINGLESTEP  32
 
 #ifndef __ASSEMBLY__
 
-- 
2.17.1

