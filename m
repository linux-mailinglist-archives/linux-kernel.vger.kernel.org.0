Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1EC7CCB6E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 18:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfJEQrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 12:47:00 -0400
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:60491 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725826AbfJEQrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:47:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 7ABF9182CED34;
        Sat,  5 Oct 2019 16:46:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:967:973:988:989:1260:1345:1359:1437:1534:1541:1711:1730:1747:1777:1792:1801:2194:2199:2393:2525:2559:2563:2682:2685:2859:2898:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3865:3866:3867:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6119:6261:6742:7903:9025:9121:10004:10848:11026:11233:11658:11914:12043:12114:12297:12346:12438:12555:12895:12986:13069:13255:13311:13357:14181:14384:14394:14581:14721:21063:21080:21433:21451:21627:30054:30055:30070,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:36,LUA_SUMMARY:none
X-HE-Tag: event87_23423d2c3c01
X-Filterd-Recvd-Size: 3388
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat,  5 Oct 2019 16:46:55 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux@googlegroups.com
Subject: [PATCH 2/4] compiler_attributes.h: Add 'fallthrough' pseudo keyword for switch/case use
Date:   Sat,  5 Oct 2019 09:46:42 -0700
Message-Id: <79237afe056af8d81662f183491e3589922b8ddd.1570292505.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1570292505.git.joe@perches.com>
References: <cover.1570292505.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve the pseudo keyword 'fallthrough' for the ability to convert the
various case block /* fallthrough */ style comments to appear to be an
actual reserved word with the same gcc case block missing fallthrough
warning capability.

All switch/case blocks now must end in one of:

	break;
	fallthrough;
	goto <label>;
	return [expression];
	continue;

fallthough is gcc's __attribute__((__fallthrough__)) which was introduced
in gcc version 7..

fallthrough devolves to an empty "do {} while (0)" if the compiler
version (any version less than gcc 7) does not support the attribute.

Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/compiler_attributes.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 6b318efd8a74..cdf016596659 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -40,6 +40,7 @@
 # define __GCC4_has_attribute___noclone__             1
 # define __GCC4_has_attribute___nonstring__           0
 # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
+# define __GCC4_has_attribute___fallthrough__         0
 #endif
 
 /*
@@ -185,6 +186,22 @@
 # define __noclone
 #endif
 
+/*
+ * Add the pseudo keyword 'fallthrough' so case statement blocks
+ * must end with any of these keywords:
+ *   break;
+ *   fallthrough;
+ *   goto <label>;
+ *   return [expression];
+ *
+ *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
+ */
+#if __has_attribute(__fallthrough__)
+# define fallthrough                    __attribute__((__fallthrough__))
+#else
+# define fallthrough                    do {} while (0)  /* fallthrough */
+#endif
+
 /*
  * Note the missing underscores.
  *
-- 
2.15.0

