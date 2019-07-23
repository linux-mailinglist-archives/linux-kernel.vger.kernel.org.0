Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11971769
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 13:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbfGWLtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 07:49:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46839 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfGWLtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:49:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6NBnGib063219
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Jul 2019 04:49:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6NBnGib063219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563882556;
        bh=p1Etw7krL6uQykP6NhEeknasvHGapeeSGpZqH0Q43mE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=mOyiZFzhuNJCyJJoo8QFxS1bu+N6NZaaBO7tmoO/Hwhv3ySyxzdU/r2OaO6dwFbGV
         HSZSdXJSKGQuCaPrhwFjWEZnXHX72AbnMdFQOPaBxEmwOtksuf+Q3etwN637Z9JbvV
         OToXHFHULW+ezFzPQC/fOON1SjaqPrPMEMUeAAYW7H8cMsXQO7Li/suXFFdn+mn/NH
         IMSt6mZIuwMGa4misCcSHBnMCmjvBIox3mHy7kvAmheU4nDq1m9mAuTVa4Yc/P4n4o
         3mvttg33M+AKJzTiFfhBemrqldroePBdn9BJMvANaAWDH/O42fSUdnhNQm70DRjbZH
         URfLmpYLtxBCQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6NBnFZP063214;
        Tue, 23 Jul 2019 04:49:15 -0700
Date:   Tue, 23 Jul 2019 04:49:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-bdd50d7421b2f8fd99f953e1f747e0cb3f3bed64@git.kernel.org>
Cc:     yamada.masahiro@socionext.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org, yamada.masahiro@socionext.com
In-Reply-To: <20190723074415.26811-1-yamada.masahiro@socionext.com>
References: <20190723074415.26811-1-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/bitops: Use __builtin_constant_p() directly
 instead of IS_IMMEDIATE()
Git-Commit-ID: bdd50d7421b2f8fd99f953e1f747e0cb3f3bed64
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bdd50d7421b2f8fd99f953e1f747e0cb3f3bed64
Gitweb:     https://git.kernel.org/tip/bdd50d7421b2f8fd99f953e1f747e0cb3f3bed64
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue, 23 Jul 2019 16:44:15 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 23 Jul 2019 13:44:18 +0200

x86/bitops: Use __builtin_constant_p() directly instead of IS_IMMEDIATE()

__builtin_constant_p(nr) is used everywhere now. It does not make much
sense to define IS_IMMEDIATE() as its alias.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190723074415.26811-1-yamada.masahiro@socionext.com

---
 arch/x86/include/asm/bitops.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index ba15d53c1ca7..7d1f6a49bfae 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -45,14 +45,13 @@
  * We do the locked ops that don't return the old value as
  * a mask operation on a byte.
  */
-#define IS_IMMEDIATE(nr)		(__builtin_constant_p(nr))
 #define CONST_MASK_ADDR(nr, addr)	WBYTE_ADDR((void *)(addr) + ((nr)>>3))
 #define CONST_MASK(nr)			(1 << ((nr) & 7))
 
 static __always_inline void
 arch_set_bit(long nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr)) {
+	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "orb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" ((u8)CONST_MASK(nr))
@@ -72,7 +71,7 @@ arch___set_bit(long nr, volatile unsigned long *addr)
 static __always_inline void
 arch_clear_bit(long nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr)) {
+	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "andb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" ((u8)~CONST_MASK(nr)));
@@ -123,7 +122,7 @@ arch___change_bit(long nr, volatile unsigned long *addr)
 static __always_inline void
 arch_change_bit(long nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr)) {
+	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "xorb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" ((u8)CONST_MASK(nr)));
