Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518A0D0A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfJIIn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 04:43:26 -0400
Received: from foss.arm.com ([217.140.110.172]:56776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfJIInZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:43:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85D57337;
        Wed,  9 Oct 2019 01:43:24 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E419C3F68E;
        Wed,  9 Oct 2019 01:43:19 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com,
        Jia He <justin.he@arm.com>
Subject: [PATCH v11 3/4] x86/mm: implement arch_faults_on_old_pte() stub on x86
Date:   Wed,  9 Oct 2019 16:42:45 +0800
Message-Id: <20191009084246.123354-4-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009084246.123354-1-justin.he@arm.com>
References: <20191009084246.123354-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_faults_on_old_pte is a helper to indicate that it might cause page
fault when accessing old pte. But on x86, there is feature to setting
pte access flag by hardware. Hence implement an overriding stub which
always returns false.

Signed-off-by: Jia He <justin.he@arm.com>
Suggested-by: Will Deacon <will@kernel.org>
---
 arch/x86/include/asm/pgtable.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0bc530c4eb13..ad97dc155195 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1463,6 +1463,12 @@ static inline bool arch_has_pfn_modify_check(void)
 	return boot_cpu_has_bug(X86_BUG_L1TF);
 }
 
+#define arch_faults_on_old_pte arch_faults_on_old_pte
+static inline bool arch_faults_on_old_pte(void)
+{
+	return false;
+}
+
 #include <asm-generic/pgtable.h>
 #endif	/* __ASSEMBLY__ */
 
-- 
2.17.1

