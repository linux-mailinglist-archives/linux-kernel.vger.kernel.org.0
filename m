Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB04A19771F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 10:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgC3I5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 04:57:01 -0400
Received: from smtprelay0169.hostedemail.com ([216.40.44.169]:39002 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729664AbgC3I5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:57:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id AF130100E8422;
        Mon, 30 Mar 2020 08:56:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2731:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3872:4321:5007:7903:10004:10400:10450:10455:10848:11026:11232:11658:11914:12043:12297:12555:12663:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:19904:19999:21080:21451:21627:30054:30056:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: debt11_5a093cf8cd63f
X-Filterd-Recvd-Size: 2019
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 30 Mar 2020 08:56:58 +0000 (UTC)
Message-ID: <27fadca7455ffa95779c33e546a57ea7906a1125.camel@perches.com>
Subject: Re: commit 23cb8490c0d3 ("MAINTAINERS: fix bad file pattern")
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 30 Mar 2020 01:55:04 -0700
In-Reply-To: <CAHp75VfJS4hAxdq67NwAXs8U+6UzL8=bqnCEpSy45R0Gj1L8NA@mail.gmail.com>
References: <f53fdf2283e1c847a4c44ea7bea4cb6600c06991.camel@perches.com>
         <CAHp75VfJS4hAxdq67NwAXs8U+6UzL8=bqnCEpSy45R0Gj1L8NA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-30 at 10:35 +0300, Andy Shevchenko wrote:
> On Mon, Mar 30, 2020 at 5:38 AM Joe Perches <joe@perches.com> wrote:
> >    MAINTAINERS: fix bad file pattern
> > 
> >     Testing 'parse-maintainers' due to the previous commit shows a bad file
> >     pattern for the "TI VPE/CAL DRIVERS" entry in the MAINTAINERS file.
> > 
> >     There's also a lot of mis-ordered entries, but I'm still a bit nervous
> >     about the inevitable and annoying merge problems it would probably cause
> >     to fix them up.
> 
> I'm wondering if order depends to current locale. If so, the script
> should override locale as well.

Perhaps:
---
diff --git a/scripts/parse-maintainers.pl b/scripts/parse-maintainers.pl
index 2ca4eb3..08db9b 100755
--- a/scripts/parse-maintainers.pl
+++ b/scripts/parse-maintainers.pl
@@ -3,6 +3,7 @@
 
 use strict;
 use Getopt::Long qw(:config no_auto_abbrev);
+no locale;
 
 my $input_file = "MAINTAINERS";
 my $output_file = "MAINTAINERS.new";


