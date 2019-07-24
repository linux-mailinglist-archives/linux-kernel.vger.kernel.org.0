Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA77733D0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 18:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfGXQ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 12:26:02 -0400
Received: from foss.arm.com ([217.140.110.172]:43390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728869AbfGXQZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:25:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 198EF15A1;
        Wed, 24 Jul 2019 09:25:58 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA34C3F71F;
        Wed, 24 Jul 2019 09:25:56 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, marc.zyngier@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v3 07/15] arm64/mm: Introduce NUM_ASIDS
Date:   Wed, 24 Jul 2019 17:25:26 +0100
Message-Id: <20190724162534.7390-8-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190724162534.7390-1-julien.grall@arm.com>
References: <20190724162534.7390-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment ASID_FIRST_VERSION is used to know the number of ASIDs
supported. As we are going to move the ASID allocator in a separate, it
would be better to use a different name for external users.

This patch adds NUM_ASIDS and implements ASID_FIRST_VERSION using it.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/mm/context.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 2e1e495cd1d8..3b40ac4a2541 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -37,7 +37,9 @@ static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
 
 #define ASID_MASK(info)			(~GENMASK((info)->bits - 1, 0))
-#define ASID_FIRST_VERSION(info)	(1UL << ((info)->bits))
+#define NUM_ASIDS(info)			(1UL << ((info)->bits))
+
+#define ASID_FIRST_VERSION(info)	NUM_ASIDS(info)
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 #define ASID_PER_CONTEXT		2
@@ -45,7 +47,7 @@ static DEFINE_PER_CPU(u64, reserved_asids);
 #define ASID_PER_CONTEXT		1
 #endif
 
-#define NUM_CTXT_ASIDS(info)		(ASID_FIRST_VERSION(info) >> (info)->ctxt_shift)
+#define NUM_CTXT_ASIDS(info)		(NUM_ASIDS(info) >> (info)->ctxt_shift)
 #define asid2idx(info, asid)		(((asid) & ~ASID_MASK(info)) >> (info)->ctxt_shift)
 #define idx2asid(info, idx)		(((idx) << (info)->ctxt_shift) & ~ASID_MASK(info))
 
-- 
2.11.0

