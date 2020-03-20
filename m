Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4EA18C6A6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 05:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCTEyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 00:54:38 -0400
Received: from foss.arm.com ([217.140.110.172]:44384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCTEyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 00:54:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9C29101E;
        Thu, 19 Mar 2020 21:54:37 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 41CAD3F52E;
        Thu, 19 Mar 2020 21:54:35 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/mm: Drop platform defined pmd_mknotpresent()
Date:   Fri, 20 Mar 2020 10:24:16 +0530
Message-Id: <1584680057-13753-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584680057-13753-1-git-send-email-anshuman.khandual@arm.com>
References: <1584680057-13753-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform needs to define pmd_mknotpresent() for generic pmdp_invalidate()
only when __HAVE_ARCH_PMDP_INVALIDATE is not subscribed. Otherwise platform
specific pmd_mknotpresent() is not required. Hence just drop it.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 201a69e6a355..5d4bc19c2a3c 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1168,10 +1168,6 @@ static inline int pmd_large(pmd_t pmd)
 	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
 }
 
-static inline pmd_t pmd_mknotpresent(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
-}
 /*
  * For radix we should always find H_PAGE_HASHPTE zero. Hence
  * the below will work for radix too
-- 
2.20.1

