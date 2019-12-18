Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE05124D63
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 17:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfLRQZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 11:25:09 -0500
Received: from foss.arm.com ([217.140.110.172]:52306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfLRQZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:25:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9480111B3;
        Wed, 18 Dec 2019 08:25:05 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ED3D3F719;
        Wed, 18 Dec 2019 08:25:02 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH v17 14/23] mm: pagewalk: fix termination condition in walk_pte_range()
Date:   Wed, 18 Dec 2019 16:23:53 +0000
Message-Id: <20191218162402.45610-15-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218162402.45610-1-steven.price@arm.com>
References: <20191218162402.45610-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If walk_pte_range() is called with a 'end' argument that is beyond the
last page of memory (e.g. ~0UL) then the comparison between 'addr' and
'end' will always fail and the loop will be infinite. Instead change the
comparison to >= while accounting for overflow.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 mm/pagewalk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 4b5ee92ba079..6732fc7ac4c8 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -14,9 +14,9 @@ static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
 		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
 		if (err)
 		       break;
-		addr += PAGE_SIZE;
-		if (addr == end)
+		if (addr >= end - PAGE_SIZE)
 			break;
+		addr += PAGE_SIZE;
 		pte++;
 	}
 	return err;
-- 
2.20.1

