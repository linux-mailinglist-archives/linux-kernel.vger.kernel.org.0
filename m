Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE35E25683
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 19:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfEURV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 13:21:56 -0400
Received: from foss.arm.com ([217.140.101.70]:39098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbfEURVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:21:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38877374;
        Tue, 21 May 2019 10:21:55 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 005B03F718;
        Tue, 21 May 2019 10:21:52 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        james.morse@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        ard.biesheuvel@linaro.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v5 1/3] arm64/fpsimd: Remove the prototype for sve_flush_cpu_state()
Date:   Tue, 21 May 2019 18:21:37 +0100
Message-Id: <20190521172139.21277-2-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190521172139.21277-1-julien.grall@arm.com>
References: <20190521172139.21277-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function sve_flush_cpu_state() has been removed in commit 21cdd7fd76e3
("KVM: arm64: Remove eager host SVE state saving").

So remove the associated prototype in asm/fpsimd.h.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>

---
    Changes in v3:
        - Add Dave's reviewed-by
        - Fix checkpatch style error when mentioning a commit

    Changes in v2:
        - Patch added
---
 arch/arm64/include/asm/fpsimd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index df62bbd33a9a..b73d12fcc7f9 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -64,7 +64,6 @@ extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
 extern void fpsimd_flush_cpu_state(void);
-extern void sve_flush_cpu_state(void);
 
 /* Maximum VL that SVE VL-agnostic software can transparently support */
 #define SVE_VL_ARCH_MAX 0x100
-- 
2.11.0

