Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39A855B18
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 00:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFYW3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 18:29:34 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:55295 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726077AbfFYW3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:29:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 294F1100E86C4;
        Tue, 25 Jun 2019 22:29:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2691:2828:2919:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4605:5007:6238:6742:7875:7904:10004:10400:10848:11026:11232:11473:11658:11914:12043:12295:12296:12297:12438:12555:12660:12740:12760:12895:13018:13019:13069:13141:13230:13311:13357:13439:14181:14659:14721:21063:21080:21451:21627:21740:30054:30055:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: part49_6fe907977cd1a
X-Filterd-Recvd-Size: 3628
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Jun 2019 22:29:28 +0000 (UTC)
Message-ID: <1336988f46fb7ffda925ab86a6e4d5437cfdb275.camel@perches.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shawn Landden <shawn@git.icu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Chandler Carruth <chandlerc@google.com>
Date:   Tue, 25 Jun 2019 15:29:27 -0700
In-Reply-To: <CAKwvOdn5j8Hkc_jrLMbhg-4jbNya+agtMJi=c9o01RPCno1Q+w@mail.gmail.com>
References: <20190624161913.GA32270@embeddedor>
         <20190624193123.GI3436@hirez.programming.kicks-ass.net>
         <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
         <20190624203737.GL3436@hirez.programming.kicks-ass.net>
         <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
         <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
         <20190625071846.GN3436@hirez.programming.kicks-ass.net>
         <CANiq72=zzZ+Cx8uM+5UW7HeB9XtbXRhXmC2y2tz5EzPX77gHMw@mail.gmail.com>
         <CAKwvOdn5j8Hkc_jrLMbhg-4jbNya+agtMJi=c9o01RPCno1Q+w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 11:15 -0700, Nick Desaulniers wrote:
> Unreleased versions of Clang built from source can; the latest release
> of Clang-8 doesn't have asm goto support required for
> CONFIG_JUMP_LABEL.  Things can get complicated based on which kernel
> tree/branch (mainline, -next, stable), arch, and configs, but I think
> we just have a few long tail bugs left.

At some point, when clang generically compiles the kernel,
I believe it'd be good to remove the various bits that
are unusual like CONFIG_CC_HAS_ASM_GOTO in Makefile
and the scripts/clang-version.sh and the like.

This could help when compiling a specific .config on
different systems.

Maybe add the equivalent compiler-gcc.h #define below
even before the removals

(whatever minor/patchlevel appropriate)
---
 include/linux/compiler-clang.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 333a6695a918..b46aece0f9ca 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -5,6 +5,14 @@
 
 /* Compiler specific definitions for Clang compiler */
 
+#define CLANG_VERSION (__clang_major__ * 10000	\
+		       + __clang_minor__ * 100	\
+		       + __clang_patchlevel__)
+
+#if CLANG_VERSION < 90000
+# error Sorry, your compiler is too old - please upgrade it.
+#endif
+
 #define uninitialized_var(x) x = *(&(x))
 
 /* same as gcc, this was present in clang-2.6 so we can assume it works




