Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 098CB6B213
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 00:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389160AbfGPWqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 18:46:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43823 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389121AbfGPWqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:46:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6GMk3O01257486
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Jul 2019 15:46:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6GMk3O01257486
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563317163;
        bh=h/BoJLRwBdQRWlDTWpUGhDBM0wjQPpz92au9Y4MOr/Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JLLiS5SQd/0uD5lsuvohpo/bsQzP9PGylCUQtMtrCOon6f23AJAGnRGoSVNFvuFMM
         VTKJaL9yzk4rWInpsv4xRlggluxwycHoJil1zQrqAXeS+BIpfNzNmZdEEVb7zGyFRo
         /Kp4n9+F883Ww45WQ1B60q0C6DLcvvrpwvGAs5edsO0o6egO1vy0UV/9kF1Km6bWrn
         fo5AesvKhXXP1A93o6+8Id1KdYdEb5T1X046x3kQS0U+Vy0oHKbVrXPLxnvlWcorAK
         liYwvAFELjkTvpz+0waf+IFH8+yMbylJXSCq9zukWeLukofg3fjwhUuFnKYJVtvVyb
         z95urGN9klVqg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6GMk2xF1257482;
        Tue, 16 Jul 2019 15:46:02 -0700
Date:   Tue, 16 Jul 2019 15:46:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-29e7e9664aec17b94a9c8c5a75f8d216a206aa3a@git.kernel.org>
Cc:     arnd@arndb.de, mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, arnd@arndb.de
In-Reply-To: <20190712090816.350668-1-arnd@arndb.de>
References: <20190712090816.350668-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86: math-emu: Hide clang warnings for 16-bit
 overflow
Git-Commit-ID: 29e7e9664aec17b94a9c8c5a75f8d216a206aa3a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  29e7e9664aec17b94a9c8c5a75f8d216a206aa3a
Gitweb:     https://git.kernel.org/tip/29e7e9664aec17b94a9c8c5a75f8d216a206aa3a
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 12 Jul 2019 11:08:05 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 17 Jul 2019 00:42:26 +0200

x86: math-emu: Hide clang warnings for 16-bit overflow

clang warns about a few parts of the math-emu implementation
where a 16-bit integer becomes negative during assignment:

arch/x86/math-emu/poly_tan.c:88:35: error: implicit conversion from 'int' to 'short' changes value from 49216 to -16320 [-Werror,-Wconstant-conversion]
                                      (0x41 + EXTENDED_Ebias) | SIGN_Negative);
                                      ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
arch/x86/math-emu/fpu_emu.h:180:58: note: expanded from macro 'setexponent16'
 #define setexponent16(x,y)  { (*(short *)&((x)->exp)) = (y); }
                                                      ~  ^
arch/x86/math-emu/reg_constant.c:37:32: error: implicit conversion from 'int' to 'short' changes value from 49085 to -16451 [-Werror,-Wconstant-conversion]
FPU_REG const CONST_PI2extra = MAKE_REG(NEG, -66,
                               ^~~~~~~~~~~~~~~~~~
arch/x86/math-emu/reg_constant.c:21:25: note: expanded from macro 'MAKE_REG'
                ((EXTENDED_Ebias+(e)) | ((SIGN_##s != 0)*0x8000)) }
                 ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/math-emu/reg_constant.c:48:28: error: implicit conversion from 'int' to 'short' changes value from 65535 to -1 [-Werror,-Wconstant-conversion]
FPU_REG const CONST_QNaN = MAKE_REG(NEG, EXP_OVER, 0x00000000, 0xC0000000);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/math-emu/reg_constant.c:21:25: note: expanded from macro 'MAKE_REG'
                ((EXTENDED_Ebias+(e)) | ((SIGN_##s != 0)*0x8000)) }
                 ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~

The code is correct as is, so add a typecast to shut up the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190712090816.350668-1-arnd@arndb.de


---
 arch/x86/math-emu/fpu_emu.h      | 2 +-
 arch/x86/math-emu/reg_constant.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/math-emu/fpu_emu.h b/arch/x86/math-emu/fpu_emu.h
index a5a41ec58072..0c122226ca56 100644
--- a/arch/x86/math-emu/fpu_emu.h
+++ b/arch/x86/math-emu/fpu_emu.h
@@ -177,7 +177,7 @@ static inline void reg_copy(FPU_REG const *x, FPU_REG *y)
 #define setexponentpos(x,y) { (*(short *)&((x)->exp)) = \
   ((y) + EXTENDED_Ebias) & 0x7fff; }
 #define exponent16(x)         (*(short *)&((x)->exp))
-#define setexponent16(x,y)  { (*(short *)&((x)->exp)) = (y); }
+#define setexponent16(x,y)  { (*(short *)&((x)->exp)) = (u16)(y); }
 #define addexponent(x,y)    { (*(short *)&((x)->exp)) += (y); }
 #define stdexp(x)           { (*(short *)&((x)->exp)) += EXTENDED_Ebias; }
 
diff --git a/arch/x86/math-emu/reg_constant.c b/arch/x86/math-emu/reg_constant.c
index 8dc9095bab22..742619e94bdf 100644
--- a/arch/x86/math-emu/reg_constant.c
+++ b/arch/x86/math-emu/reg_constant.c
@@ -18,7 +18,7 @@
 #include "control_w.h"
 
 #define MAKE_REG(s, e, l, h) { l, h, \
-		((EXTENDED_Ebias+(e)) | ((SIGN_##s != 0)*0x8000)) }
+		(u16)((EXTENDED_Ebias+(e)) | ((SIGN_##s != 0)*0x8000)) }
 
 FPU_REG const CONST_1 = MAKE_REG(POS, 0, 0x00000000, 0x80000000);
 #if 0
