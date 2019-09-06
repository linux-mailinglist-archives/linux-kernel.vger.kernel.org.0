Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AE5AC1DE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 23:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbfIFVLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 17:11:55 -0400
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:36182 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728338AbfIFVLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 17:11:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 678358368F02;
        Fri,  6 Sep 2019 21:11:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:69:355:379:559:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6235:7557:8957:9025:10004:10400:10848:11232:11658:11914:12043:12219:12297:12438:12555:12679:12683:12760:13161:13229:13255:13439:14093:14096:14097:14181:14394:14659:14721:14773:21080:21433:21626:21939:30012:30054:30074,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: team46_2d769cac3b337
X-Filterd-Recvd-Size: 2775
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Sep 2019 21:11:52 +0000 (UTC)
Message-ID: <a68114afb134b8633905f5a25ae7c4e6799ce8f1.camel@perches.com>
Subject: [PATCH] docs: printk-formats: Stop encouraging use of unnecessary
 %h[xudi] and %hh[xudi]
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Louis Taylor <louis@kragniz.eu>
Date:   Fri, 06 Sep 2019 14:11:51 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

As Linus said in:
Link: https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/

It's a pointless warning, making for more complex code, and
making people remember esoteric printf format details that have no
reason for existing.

The "h" and "hh" things should never be used. The only reason for them
being used if if you have an "int", but you want to print it out as a
"char" (and honestly, that is a really bad reason, you'd be better off
just using a proper cast to make the code more obvious).

So if what you have a "char" (or unsigned char) you should always just
print it out as an "int", knowing that the compiler already did the
proper type conversion.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/core-api/printk-formats.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index c6224d039bcb..ecbebf4ca8e7 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -13,10 +13,10 @@ Integer types
 
 	If variable is of Type,		use printk format specifier:
 	------------------------------------------------------------
-		char			%hhd or %hhx
-		unsigned char		%hhu or %hhx
-		short int		%hd or %hx
-		unsigned short int	%hu or %hx
+		char			%d or %x
+		unsigned char		%u or %x
+		short int		%d or %x
+		unsigned short int	%u or %x
 		int			%d or %x
 		unsigned int		%u or %x
 		long			%ld or %lx
@@ -25,10 +25,10 @@ Integer types
 		unsigned long long	%llu or %llx
 		size_t			%zu or %zx
 		ssize_t			%zd or %zx
-		s8			%hhd or %hhx
-		u8			%hhu or %hhx
-		s16			%hd or %hx
-		u16			%hu or %hx
+		s8			%d or %x
+		u8			%u or %x
+		s16			%d or %x
+		u16			%u or %x
 		s32			%d or %x
 		u32			%u or %x
 		s64			%lld or %llx


