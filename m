Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5205B6497B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfGJPZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 11:25:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37529 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfGJPZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:25:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6AFP3SF2477761
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Jul 2019 08:25:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6AFP3SF2477761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562772303;
        bh=iEh2pz6PIDbm4ws6R1XTs5nVHRi6d1QzlH+xLKepvJo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=v/lKp/WG3oczgkvO6hv6gSUTTCa1sSudxu/3CoBfq3LM5TnmeIGBIez+JfiM+jHxk
         8aq1kzFDJrYNVMUNVrBnsTdd5i/U4/UPIPVa00P9KXUyRst11e1N4d+YKyEqCSW14V
         jtfucYARaaYCeJTuWSILe7l2QcWlUJ8WWeUuT+8mgD/9UdNsC4pCIrKLvNOwq9bG+w
         PaSHSScNSpTzAolL/GyZWL7yC940mtG9EMgn4RiqHd5Oyq7BVGCCYIIpSNIgLc89HG
         /PKLaTYIcwYDz8zPuLDMKuxNL/4nUXtjttHvgAi7XplkQ3TQxANtvTEefhNkpqUKyw
         YT8l1aYd2uxuQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6AFP2F62477753;
        Wed, 10 Jul 2019 08:25:02 -0700
Date:   Wed, 10 Jul 2019 08:25:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-26515699863d68058e290e18e83f444925920be5@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de,
        hpa@zytor.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, arnd@arndb.de, mingo@kernel.org,
          hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190710130522.1802800-1-arnd@arndb.de>
References: <20190710130522.1802800-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/pgtable/32: Fix LOWMEM_PAGES constant
Git-Commit-ID: 26515699863d68058e290e18e83f444925920be5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  26515699863d68058e290e18e83f444925920be5
Gitweb:     https://git.kernel.org/tip/26515699863d68058e290e18e83f444925920be5
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Wed, 10 Jul 2019 15:04:55 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 10 Jul 2019 17:19:58 +0200

x86/pgtable/32: Fix LOWMEM_PAGES constant

clang points out that the computation of LOWMEM_PAGES causes a signed
integer overflow on 32-bit x86:

arch/x86/kernel/head32.c:83:20: error: signed shift result (0x100000000) requires 34 bits to represent, but 'int' only has 32 bits [-Werror,-Wshift-overflow]
                (PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
                                 ^~~~~~~~~~~~
arch/x86/include/asm/pgtable_32.h:109:27: note: expanded from macro 'LOWMEM_PAGES'
 #define LOWMEM_PAGES ((((2<<31) - __PAGE_OFFSET) >> PAGE_SHIFT))
                         ~^ ~~
arch/x86/include/asm/pgtable_32.h:98:34: note: expanded from macro 'PAGE_TABLE_SIZE'
 #define PAGE_TABLE_SIZE(pages) ((pages) / PTRS_PER_PGD)

Use the _ULL() macro to make it a 64-bit constant.

Fixes: 1e620f9b23e5 ("x86/boot/32: Convert the 32-bit pgtable setup code from assembly to C")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190710130522.1802800-1-arnd@arndb.de

---
 arch/x86/include/asm/pgtable_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 4fe9e7fc74d3..c78da8eda8f2 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -106,6 +106,6 @@ do {						\
  * with only a host target support using a 32-bit type for internal
  * representation.
  */
-#define LOWMEM_PAGES ((((2<<31) - __PAGE_OFFSET) >> PAGE_SHIFT))
+#define LOWMEM_PAGES ((((_ULL(2)<<31) - __PAGE_OFFSET) >> PAGE_SHIFT))
 
 #endif /* _ASM_X86_PGTABLE_32_H */
