Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A0C166CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 03:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgBUC0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 21:26:05 -0500
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:57479 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729222AbgBUC0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:26:04 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id A7A1F181C965D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 02:26:03 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D4E4E100E7B44;
        Fri, 21 Feb 2020 02:26:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6119:7875:7903:7974:8531:8985:9025:10004:10400:10848:10967:11232:11657:11658:11854:11914:12043:12050:12291:12296:12297:12438:12555:12683:12740:12760:12895:13149:13161:13229:13230:13255:13439:14180:14181:14659:14721:14877:21080:21324:21433:21611:21627:21740:21811:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: kiss25_8bfb524244a5a
X-Filterd-Recvd-Size: 4638
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Feb 2020 02:26:01 +0000 (UTC)
Message-ID: <a588204afbfe4c8dd56d0cb00d8e6e14dc561a62.camel@perches.com>
Subject: Re: [PATCH] cvt_fallthrough: A tool to convert /* fallthrough */
 comments to fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Thu, 20 Feb 2020 18:24:38 -0800
In-Reply-To: <20200220162114.138f976ae16a5e58e13a51ae@linux-foundation.org>
References: <b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com>
         <20200220162114.138f976ae16a5e58e13a51ae@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-20 at 16:21 -0800, Andrew Morton wrote:
> On Thu, 20 Feb 2020 12:30:21 -0800 Joe Perches <joe@perches.com> wrote:
> 
> > Convert /* fallthrough */ style comments to the pseudo-keyword fallthrough
> > to allow clang 10 and higher to work at finding missing fallthroughs too.
> > 
> > Requires a git repository and overwrites the input files.
> > 
> > Typical command use:
> >     ./scripts/cvt_fallthrough.pl <path|file>
> > 
> > i.e.:
> > 
> >    $ ./scripts/cvt_fallthrough.pl block
> >      converts all files in block and its subdirectories
> >    $ ./scripts/cvt_fallthrough.pl drivers/net/wireless/zydas/zd1201.c
> >      converts a single file
> > 
> > A fallthrough comment with additional comments is converted akin to:
> > 
> > -		/* fall through - maybe userspace knows this conn_id. */
> > +		fallthrough;    /* maybe userspace knows this conn_id */
> > 
> > A fallthrough comment or fallthrough; between successive case statements
> > is deleted.
> > 
> > e.g.:
> > 
> >     case FOO:
> >     	/* fallthrough */ (or fallthrough;)
> >     case BAR:
> > 
> > is converted to:
> > 
> >     case FOO:
> >     case BAR:
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  scripts/cvt_fallthrough.pl | 215 +++++++++++++++++++++++++++++++++++++
> 
> Do we need this in the tree long-term?

Out-of-tree scripts aren't used by trivial patch submitters.

So no, not really.  I think it's a 'good to have, short term'
script useful until at least most all of the conversions occur.

And I think having multiple concurrent styles for fallthrough
isn't great.

And I don't have the patience of someone like Gustavo Silva to
painstakin
gly shepherd hundreds of little patches either.
(thanks Gustavo, good
work...)

And it would be nice though to have some mechanism to get
scripted patches applied, either by subsystem or treewide.

> Or is it a matters of "hey
> Linus, please run this" then something like add a checkpatch rule to
> catch future slipups?

The checkpatch rule was added a week ago.
https://lore.kernel.org/lkml/8b6c1b9031ab9f3cdebada06b8d46467f1492d68.camel@perches.com/

Adding a --fix option wouldn't work as well as this script
to do conversions as the script is moderately complicated.

It does seem a treewide conversion like this could have a
small impact on stable trees, so any conversion should
probably be done by subsystem.

Anyway, the script does a pretty reasonable job at
conversions of the various styles of fallthrough comments.

Though there are some conversion that are not done when a
/* fallthrough */ comment is followed by another comment
before another case like:

	case FOO:
		/* fall through */
		/* another comment */
	case BAR:

Anyway, using today's -next, a treewide diffstat is:

$ git diff --shortstat
 1861 files changed, 4113 insertions(+), 4762 deletions(-)

And these are the most common conversions:

   2278 /* fall through */
    441 /* Fall through */
    253 /* fallthrough */
    164 /* FALLTHROUGH */
    116 /* fall-through */
     84 /* Fallthrough */
     33 /* FALL THROUGH */
     31 /* Fall through */				\
     27 /* FALLTHRU */
     24 /*FALLTHRU*/
     24 /* fallthru */
     19 /* fall thru */
     19 /* Fall Through */
     19 /* Fall-through */
     16 /* Else, fall through */
     15 /* fall-thru */
     13 /* Intentional fallthrough */
     13 /*FALLTHROUGH*/
     12 /* Fall thru */
     12 /* else, fall through */
     10 /*lint -fallthrough */
      9 /* Fall through. */
      9 }	/* fallthrough */
      8 /*fall through*/


