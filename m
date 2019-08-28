Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33867A0500
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 16:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfH1Obm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 10:31:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47535 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfH1Obm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:31:42 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2yz6-00061v-5d; Wed, 28 Aug 2019 16:31:40 +0200
Message-Id: <20190828143123.971884723@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 28 Aug 2019 16:24:46 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Subject: [patch 1/2] x86/mm/pti: Handle unaligned address gracefully in
 pti_clone_pagetable()
References: <20190828142445.454151604@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

pti_clone_pmds() assumes that the supplied address is either:

 - properly PUD/PMD aligned
or
 - the address is actually mapped which means that independent
   of the mapping level (PUD/PMD/PTE) the next higher mapping
   exist.

If that's not the case the unaligned address can be incremented by PUD or
PMD size wrongly. All callers supply mapped and/or aligned addresses, but
for robustness sake, it's better to handle that case proper and to emit a
warning.

Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190820202314.1083149-1-songliubraving@fb.com

---
 arch/x86/mm/pti.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -330,13 +330,15 @@ pti_clone_pgtable(unsigned long start, u
 
 		pud = pud_offset(p4d, addr);
 		if (pud_none(*pud)) {
-			addr += PUD_SIZE;
+			WARN_ON_ONCE(addr & PUD_MASK);
+			addr = round_up(addr + 1, PUD_SIZE);
 			continue;
 		}
 
 		pmd = pmd_offset(pud, addr);
 		if (pmd_none(*pmd)) {
-			addr += PMD_SIZE;
+			WARN_ON_ONCE(addr & PMD_MASK);
+			addr = round_up(addr + 1, PMD_SIZE);
 			continue;
 		}
 


