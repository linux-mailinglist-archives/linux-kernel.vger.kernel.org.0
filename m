Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A183733BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfGXQZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 12:25:58 -0400
Received: from foss.arm.com ([217.140.110.172]:43376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbfGXQZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:25:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F103E337;
        Wed, 24 Jul 2019 09:25:54 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DB073F71F;
        Wed, 24 Jul 2019 09:25:53 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, marc.zyngier@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v3 05/15] arm64/mm: Remove dependency on MM in new_context
Date:   Wed, 24 Jul 2019 17:25:24 +0100
Message-Id: <20190724162534.7390-6-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190724162534.7390-1-julien.grall@arm.com>
References: <20190724162534.7390-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function new_context will be part of a generic ASID allocator. At
the moment, the MM structure is only used to fetch the ASID.

To remove the dependency on MM, it is possible to just pass a pointer to
the current ASID.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/mm/context.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index b50f52a09baf..dfb0da35a541 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -140,10 +140,10 @@ static bool check_update_reserved_asid(struct asid_info *info, u64 asid,
 	return hit;
 }
 
-static u64 new_context(struct asid_info *info, struct mm_struct *mm)
+static u64 new_context(struct asid_info *info, atomic64_t *pasid)
 {
 	static u32 cur_idx = 1;
-	u64 asid = atomic64_read(&mm->context.id);
+	u64 asid = atomic64_read(pasid);
 	u64 generation = atomic64_read(&info->generation);
 
 	if (asid != 0) {
@@ -225,7 +225,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	/* Check that our ASID belongs to the current generation. */
 	asid = atomic64_read(&mm->context.id);
 	if ((asid ^ atomic64_read(&info->generation)) >> info->bits) {
-		asid = new_context(info, mm);
+		asid = new_context(info, &mm->context.id);
 		atomic64_set(&mm->context.id, asid);
 	}
 
-- 
2.11.0

