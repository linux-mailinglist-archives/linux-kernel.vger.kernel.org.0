Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C98A168AA5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 01:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgBVACo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 19:02:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:43852 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729755AbgBVACn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:02:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 16:02:43 -0800
X-IronPort-AV: E=Sophos;i="5.70,470,1574150400"; 
   d="scan'208";a="383605949"
Received: from jbrandeb-desk.jf.intel.com ([10.166.244.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 16:02:43 -0800
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        andriy.shevchenko@intel.com, dan.j.williams@intel.com,
        peterz@infradead.org
Subject: [PATCH v4 1/2] x86: fix bitops.h warning with a moved cast
Date:   Fri, 21 Feb 2020 16:02:13 -0800
Message-Id: <20200222000214.2169531-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix many sparse warnings when building with C=1.

When the kernel is compiled with C=1, there are lots of messages like:
  arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)

CONST_MASK() is using a signed integer "1" to create the mask which
is later cast to (u8) when used. Move the cast to the definition and
clean up the calling sites to prevent sparse from warning.

The reason the warning was occurring is because certain bitmasks that
end with a mask next to a natural boundary like 7, 15, 23, 31, end up
with a mask like 0x7f, which then results in sign extension when doing
an invert (but I'm not a compiler expert). It was really only
"clear_bit" that was having problems, and it was only on bit checks next
to a byte boundary (top bit).

Verified with a test module (see next patch) and assembly inspection
that the patch doesn't introduce any change in generated code.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
v4: reverse argument order as suggested by David Laight, added reviewed-by
v3: Clean up the header file changes as per peterz.
v2: use correct CC: list
---
 arch/x86/include/asm/bitops.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 062cdecb2f24..fed152434ed0 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -46,7 +46,7 @@
  * a mask operation on a byte.
  */
 #define CONST_MASK_ADDR(nr, addr)	WBYTE_ADDR((void *)(addr) + ((nr)>>3))
-#define CONST_MASK(nr)			(1 << ((nr) & 7))
+#define CONST_MASK(nr)			((u8)1 << ((nr) & 7))
 
 static __always_inline void
 arch_set_bit(long nr, volatile unsigned long *addr)
@@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "orb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" ((u8)CONST_MASK(nr))
+			: "iq" (CONST_MASK(nr))
 			: "memory");
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
@@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
 	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "andb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
-			: "iq" ((u8)~CONST_MASK(nr)));
+			: "iq" (CONST_MASK(nr) ^ 0xff));
 	} else {
 		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
 			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");

base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
-- 
2.24.1

