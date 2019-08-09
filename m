Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B232188680
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 01:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfHIW6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 18:58:50 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:47251 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729533AbfHIW6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:58:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BC25C1801C4F4;
        Fri,  9 Aug 2019 22:58:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:334:355:379:599:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4384:4605:5007:6119:6691:8603:8957:9025:10004:10400:10450:10455:10848:11026:11232:11658:11914:12043:12297:12438:12555:12740:12760:12895:13019:13439:14093:14097:14180:14181:14659:14721:19904:19999:21060:21063:21080:21451:21627:30029:30054:30070:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: net87_4c35b90f10723
X-Filterd-Recvd-Size: 3471
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri,  9 Aug 2019 22:58:43 +0000 (UTC)
Message-ID: <7c4db60a2b1976a92b5c824c7d24c4c77aa57278.camel@perches.com>
Subject: Re: checkpatch.pl should suggest __section
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 09 Aug 2019 15:58:41 -0700
In-Reply-To: <CAKwvOdmNdvgv=+P1CU36fG+trETojmPEXSMmAmX2TY0e67X-Wg@mail.gmail.com>
References: <CAKwvOdmNdvgv=+P1CU36fG+trETojmPEXSMmAmX2TY0e67X-Wg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-09 at 15:21 -0700, Nick Desaulniers wrote:
> Hi Joe,
> While debugging:
> https://github.com/ClangBuiltLinux/linux/issues/619
> we found a bunch of places where __section is not used but could be,
> and uses a string literal when it probably should not be.
> 
> Just a thought that maybe checkpatch.pl could warn if
> `__attribute__((section` appeared in the added diff, and suggest
> __section? Then further warn to not use `""` for the section name?

Hmm, that makes me wonder about the existing __section uses
_with_ a quote are actually in the proper sections.

$ git grep -n -P '\b__section\s*\(\s*"'
arch/arm64/kernel/smp_spin_table.c:22:volatile unsigned long __section(".mmuoff.data.read")
arch/s390/boot/startup.c:49:static struct diag210 _diag210_tmp_dma __section(".dma.data");
include/linux/compiler.h:27:                            __section("_ftrace_annotated_branch")   \
include/linux/compiler.h:63:            __section("_ftrace_branch")             \
include/linux/compiler.h:121:#define __annotate_jump_table __section(".rodata..c_jump_table")
include/linux/compiler.h:158:   __section("___kentry" "+" #sym )                        \
include/linux/compiler.h:301:   static void * __section(".discard.addressable") __used \
include/linux/export.h:107:     static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
include/linux/srcutree.h:127:           __section("___srcu_struct_ptrs") = &name

Maybe there should also be a __section("<foo>") test too.

Anyway, how about:
---
 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1cdacb4fd207..8e6693ca772c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5901,6 +5901,15 @@ sub process {
 			     "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
 		}
 
+# Check for __attribute__ section, prefer __section (without quotes)
+		if ($realfile !~ m@\binclude/uapi/@ &&
+		    $line =~ /\b__attribute__\s*\(\s*\(.*_*section_*\s*\(\s*("[^"]*")/) {
+			my $old = substr($rawline, $-[1], $+[1] - $-[1]);
+			my $new = substr($old, 1, -1);
+			WARN("PREFER_SECTION",
+			     "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr);
+		}
+
 # Check for __attribute__ format(printf, prefer __printf
 		if ($realfile !~ m@\binclude/uapi/@ &&
 		    $line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf/) {



