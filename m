Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D25E7B916
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 07:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfGaFf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 01:35:26 -0400
Received: from smtprelay0125.hostedemail.com ([216.40.44.125]:40647 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbfGaFfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 01:35:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D4EF0181D33FB;
        Wed, 31 Jul 2019 05:35:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:967:973:988:989:1260:1345:1359:1437:1534:1542:1711:1730:1747:1777:1792:1801:2194:2199:2393:2525:2559:2564:2682:2685:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3865:3866:3867:3870:3871:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6119:6120:6261:6742:7903:9025:9121:10004:10848:11026:11232:11233:11658:11914:12043:12114:12297:12346:12438:12555:12895:12986:13255:13845:14181:14721:21063:21080:21433:21451:21627:21811:30054,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: baby82_2eaba44e31115
X-Filterd-Recvd-Size: 3569
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Jul 2019 05:35:20 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo keyword for switch/case use
Date:   Tue, 30 Jul 2019 22:35:18 -0700
Message-Id: <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
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

fallthough is gcc's __attribute__((__fallthrough__)) which was introduced
in gcc version 7..

fallthrough devolves to an empty "do {} while (0)" if the compiler version
(any version less than gcc 7) does not support the attribute.

Signed-off-by: Joe Perches <joe@perches.com>
---

For allow compilation of a kernel that includes net/sctp, this patch
also requires a rename of the use of fallthrough as a label in
net/sctp/sm_make_chunk.c that was submitted as:

https://lore.kernel.org/lkml/e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com/

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

