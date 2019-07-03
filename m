Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D068E5C8D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 07:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfGBFd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 01:33:26 -0400
Received: from foss.arm.com ([217.140.110.172]:44232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfGBFd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 01:33:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B01A928;
        Mon,  1 Jul 2019 22:33:25 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA2113F703;
        Mon,  1 Jul 2019 22:35:15 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <Steve.Capper@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop pte_huge()
Date:   Tue,  2 Jul 2019 11:02:55 +0530
Message-Id: <1562045575-8742-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper is required from generic huge_pte_alloc() which is available
when arch subscribes ARCH_WANT_GENERAL_HUGETLB. arm64 implements it's own
huge_pte_alloc() and does not depend on the generic definition. Drop this
helper which is redundant on arm64.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Steve Capper <Steve.Capper@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 87a4b2ddc1a1..3f5461f7b560 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -301,7 +301,6 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
 /*
  * Huge pte definitions.
  */
-#define pte_huge(pte)		(!(pte_val(pte) & PTE_TABLE_BIT))
 #define pte_mkhuge(pte)		(__pte(pte_val(pte) & ~PTE_TABLE_BIT))
 
 /*
-- 
2.20.1

