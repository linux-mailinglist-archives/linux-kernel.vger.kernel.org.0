Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C4EE783D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 19:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404347AbfJ1SRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 14:17:52 -0400
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:42030 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730690AbfJ1SRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:17:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5FFBA1801C405;
        Mon, 28 Oct 2019 18:17:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2692:2828:3138:3139:3140:3141:3142:3354:3865:3866:3867:3868:3871:3872:5007:6119:7903:10004:11026:11473:11658:11914:12043:12296:12297:12438:12555:12760:12895:13095:13161:13229:13255:13439:14096:14097:14181:14394:14659:14721:21080:21433:21451:21627:21795:21972:30003:30029:30051:30054:30070,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: queen23_6160776bf5133
X-Filterd-Recvd-Size: 5179
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Oct 2019 18:17:49 +0000 (UTC)
Message-ID: <07d3b90307f85267c7467fd329043a8790a2c332.camel@perches.com>
Subject: [PATCH V2] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Mon, 28 Oct 2019 11:17:43 -0700
In-Reply-To: <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
         <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
         <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid macro name collisions and improve portability use a
double underscore prefix and suffix on all __attribute__ #defines.

There are __CHECKER__ exceptions to these uses of attribute types
because sparse as of version 0.6.1 and earlier do not recognize
a few __<type>__ attributes.

Signed-off-by: Joe Perches <joe@perches.com>
---

v2: Do not modify the __CHECKER__ attribute #defines
    Add a comment describing why to the __CHECKER__ block.

 include/linux/compiler-clang.h |  2 +-
 include/linux/compiler-gcc.h   | 10 +++++-----
 include/linux/compiler_types.h | 11 ++++++++---
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 333a66..26d655f 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -19,7 +19,7 @@
 /* emulate gcc's __SANITIZE_ADDRESS__ flag */
 #define __SANITIZE_ADDRESS__
 #define __no_sanitize_address \
-		__attribute__((no_sanitize("address", "hwaddress")))
+		__attribute__((__no_sanitize__("address", "hwaddress")))
 #else
 #define __no_sanitize_address
 #endif
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d7ee4c..7a2dee 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -76,7 +76,7 @@
 #define __compiletime_error(message) __attribute__((__error__(message)))
 
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
-#define __latent_entropy __attribute__((latent_entropy))
+#define __latent_entropy __attribute__((__latent_entropy__))
 #endif
 
 /*
@@ -101,8 +101,8 @@
 	} while (0)
 
 #if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
-#define __randomize_layout __attribute__((randomize_layout))
-#define __no_randomize_layout __attribute__((no_randomize_layout))
+#define __randomize_layout __attribute__((__randomize_layout__))
+#define __no_randomize_layout __attribute__((__no_randomize_layout__))
 /* This anon struct can add padding, so only enable it under randstruct. */
 #define randomized_struct_fields_start	struct {
 #define randomized_struct_fields_end	} __randomize_layout;
@@ -140,7 +140,7 @@
 #endif
 
 #if __has_attribute(__no_sanitize_address__)
-#define __no_sanitize_address __attribute__((no_sanitize_address))
+#define __no_sanitize_address __attribute__((__no_sanitize_address__))
 #else
 #define __no_sanitize_address
 #endif
@@ -171,4 +171,4 @@
 #define __diag_GCC_8(s)
 #endif
 
-#define __no_fgcse __attribute__((optimize("-fno-gcse")))
+#define __no_fgcse __attribute__((__optimize__("-fno-gcse")))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 72393a..506b3a 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -5,6 +5,11 @@
 #ifndef __ASSEMBLY__
 
 #ifdef __CHECKER__
+/*
+ * sparse as of v0.6.1 does not understand several double underscore
+ * prefix and suffix forms of attribute types, so do not use them when
+ * sparse checking is enabled
+ */
 # define __user		__attribute__((noderef, address_space(1)))
 # define __kernel	__attribute__((address_space(0)))
 # define __safe		__attribute__((safe))
@@ -25,7 +30,7 @@ extern void __chk_io_ptr(const volatile void __iomem *);
 # define ACCESS_PRIVATE(p, member) (*((typeof((p)->member) __force *) &(p)->member))
 #else /* __CHECKER__ */
 # ifdef STRUCTLEAK_PLUGIN
-#  define __user __attribute__((user))
+#  define __user __attribute__((__user__))
 # else
 #  define __user
 # endif
@@ -111,9 +116,9 @@ struct ftrace_likely_data {
 #endif
 
 #if defined(CC_USING_HOTPATCH)
-#define notrace			__attribute__((hotpatch(0, 0)))
+#define notrace			__attribute__((__hotpatch__(0, 0)))
 #elif defined(CC_USING_PATCHABLE_FUNCTION_ENTRY)
-#define notrace			__attribute__((patchable_function_entry(0, 0)))
+#define notrace			__attribute__((__patchable_function_entry__(0, 0)))
 #else
 #define notrace			__attribute__((__no_instrument_function__))
 #endif


