Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D71E3C75A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 11:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404511AbfFKJic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 05:38:32 -0400
Received: from foss.arm.com ([217.140.110.172]:56334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404137AbfFKJi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:38:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF141C15;
        Tue, 11 Jun 2019 02:38:26 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28D8D3F73C;
        Tue, 11 Jun 2019 02:38:25 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, james.morse@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        liwei391@huawei.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v4 3/8] arm64: irqflags: Add condition flags to inline asm clobber list
Date:   Tue, 11 Jun 2019 10:38:08 +0100
Message-Id: <1560245893-46998-4-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560245893-46998-1-git-send-email-julien.thierry@arm.com>
References: <1560245893-46998-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the inline assembly instruction use the condition flags and need
to include "cc" in the clobber list.

Fixes: commit 4a503217ce37 ("arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking")
Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/irqflags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 9c93152..fbe1aba 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -92,7 +92,7 @@ static inline unsigned long arch_local_save_flags(void)
 			ARM64_HAS_IRQ_PRIO_MASKING)
 		: "=&r" (flags), "+r" (daif_bits)
 		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
-		: "memory");
+		: "cc", "memory");

 	return flags;
 }
@@ -136,7 +136,7 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 			ARM64_HAS_IRQ_PRIO_MASKING)
 		: "=&r" (res)
 		: "r" ((int) flags)
-		: "memory");
+		: "cc", "memory");

 	return res;
 }
--
1.9.1
