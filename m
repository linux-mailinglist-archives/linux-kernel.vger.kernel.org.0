Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB418ED0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 19:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfEIRTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 13:19:15 -0400
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:45651 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbfEIRTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:19:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 943FC100E86C7;
        Thu,  9 May 2019 17:19:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3872:4321:5007:7901:7903:10004:10400:10848:11026:11232:11473:11658:11914:12296:12555:12663:12740:12760:12895:13069:13311:13357:13439:14180:14181:14659:14721:21060:21080:21451:21627:30054:30060:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: fly20_3353c4314b71f
X-Filterd-Recvd-Size: 2401
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  9 May 2019 17:19:12 +0000 (UTC)
Message-ID: <b5e2a4d9eb49290d6dc3449c90cdf07797b1aba6.camel@perches.com>
Subject: Re: [Proposal] end of file checks by checkpatch.pl
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Thu, 09 May 2019 10:19:11 -0700
In-Reply-To: <CAK7LNAR5j1ygbq9TLqUhbJ+tkMdrtD3BgQoUWZErUrnEoWKYMw@mail.gmail.com>
References: <CAK7LNAR5j1ygbq9TLqUhbJ+tkMdrtD3BgQoUWZErUrnEoWKYMw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-10 at 00:27 +0900, Masahiro Yamada wrote:
> Hi Joe,
> 
> 
> Does it make sense to check the following
> by checkpatch.pl ?
> 
> 
> [1] blank line at end of file


> [2] no new line at end of file

I'm pretty sure checkpatch does one this already.
(around line 3175)

# check for adding lines without a newline.
		if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/) {
 			WARN("MISSING_EOF_NEWLINE",
 			     "adding a line without newline at end of file\n" . $herecurr);
 		}


> When I apply a patch,
> I sometimes see the following warning from 'git am'.
> 
> 
> Applying: kunit: test: add string_stream a std::stream like string builder
> .git/rebase-apply/patch:223: new blank line at EOF.
> +
> 
> 
> I just thought it could be checked
> before the patch submission.

perhaps:
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1c421ac42b07..ceb32c584ee5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3356,6 +3356,12 @@ sub process {
 			$last_blank_line = $linenr;
 		}
 
+# check the last line isn't blank
+		if ($linenr >= $#rawlines && $line =~ /^\+\s*$/) {
+			WARN("LINE_SPACING",
+			     "Avoid blank lines at EOF\n" . $herecurr);
+		}
+
 # check for missing blank lines after declarations
 		if ($sline =~ /^\+\s+\S/ &&			#Not at char 1
 			# actual declarations


