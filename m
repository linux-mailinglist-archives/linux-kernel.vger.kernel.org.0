Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0B808F746
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 00:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbfHOWzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 18:55:44 -0400
Received: from smtprelay0173.hostedemail.com ([216.40.44.173]:52055 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730124AbfHOWzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:55:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 22CA2100E86C3;
        Thu, 15 Aug 2019 22:55:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:69:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7903:8985:9025:10004:10400:10848:11232:11658:11914:12043:12291:12297:12438:12555:12683:12698:12737:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14157:14181:14659:14721:21080:21365:21433:21627:30012:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: jail27_6bd326141ea25
X-Filterd-Recvd-Size: 2556
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 15 Aug 2019 22:55:40 +0000 (UTC)
Message-ID: <29743c8d0a5e5f4a1ead55bc614ed53079a42597.camel@perches.com>
Subject: Re: [PATCH] afs: Move comments after /* fallthrough */
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-afs@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 15 Aug 2019 15:55:39 -0700
In-Reply-To: <CAKwvOdmuReaFgFK+=aib6rRfAb_GTGubLyJ3sAH-tnkKYHASqQ@mail.gmail.com>
References: <e77b0f32a2ce97c872eede52c88b84aa78094ae5.1565836130.git.joe@perches.com>
         <CAKwvOdmuReaFgFK+=aib6rRfAb_GTGubLyJ3sAH-tnkKYHASqQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-15 at 15:34 -0700, Nick Desaulniers wrote:
> On Wed, Aug 14, 2019 at 7:36 PM Joe Perches <joe@perches.com> wrote:
> > Make the code a bit easier for a script to appropriately convert
> > case statement blocks with /* fallthrough */ comments to a macro by
> > moving comments describing the next case block to the case statement.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  fs/afs/cmservice.c | 10 +++-------
> >  fs/afs/fsclient.c  | 51 +++++++++++++++++----------------------------------
> >  fs/afs/vlclient.c  | 50 +++++++++++++++++++++++++-------------------------
> >  fs/afs/yfsclient.c | 51 +++++++++++++++++----------------------------------
> 
> So these changes are across just fs/afs, how many patches like this
> would you need across the whole tree to solve this problem?

No idea.  I only looked at afs when Nathan Chancellor showed
there were 350 or so changes necessary in the kernel tree.
The afs entries were 50 of them so I just looked and saw why.

I haven't looked at all the others.

https://gist.github.com/nathanchance/ffbd71b48ba197837e1bdd9bb863b85f

But probably most of the others are missing a fallthrough to
a break like:

	switch {foo} {
	case 1:
		<bar>;
	default:
		break;
	}

where gcc does not emit a warning but clang apparently does.

I do think gcc should emit a warning here too so I filed a
gcc bugzilla entry.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91432


