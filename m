Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225FB182C95
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 10:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgCLJjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 05:39:17 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:35044 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbgCLJjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:39:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2FF6710FA8;
        Thu, 12 Mar 2020 09:39:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1434:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:8531:9025:10004:10400:10848:11026:11232:11658:11914:12043:12297:12438:12555:12740:12760:12895:12986:13069:13161:13229:13311:13357:13439:14181:14659:14721:21080:21433:21451:21611:21627:21811:21939:30054:30060:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: match59_8af9430b5bd5c
X-Filterd-Recvd-Size: 3208
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 09:39:14 +0000 (UTC)
Message-ID: <fa07756217b3c033c7e5af495a03ff5655947450.camel@perches.com>
Subject: Re: [PATCH -next 005/491] ARM/UNIPHIER ARCHITECTURE: Use
 fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Mar 2020 02:37:31 -0700
In-Reply-To: <CAK7LNAS98yeCeFZpKgNRRKcFhXSKWQ7Ka4vP90YcY=ufScZRCw@mail.gmail.com>
References: <cover.1583896344.git.joe@perches.com>
         <dae0878058223a42c77d725b8d7c5845a7ef9dc0.1583896348.git.joe@perches.com>
         <CAK7LNAS7GAk9yXkPhbS3ByU+n9Gb-rk0PeLcXLCNwpW1B22aeg@mail.gmail.com>
         <891a42ad8d8fd7beca911845108e1ded022ef3f7.camel@perches.com>
         <20200312085606.GA154268@kroah.com>
         <CAK7LNAS98yeCeFZpKgNRRKcFhXSKWQ7Ka4vP90YcY=ufScZRCw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-12 at 18:02 +0900, Masahiro Yamada wrote:
> On Thu, Mar 12, 2020 at 5:56 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Wed, Mar 11, 2020 at 07:31:07AM -0700, Joe Perches wrote:
> > > On Wed, 2020-03-11 at 14:15 +0900, Masahiro Yamada wrote:
> > > > On Wed, Mar 11, 2020 at 2:07 PM Joe Perches <joe@perches.com> wrote:
> > > > > Convert the various uses of fallthrough comments to fallthrough;
> > > > > 
> > > > > Done via script
> > > > > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> > > > > 
> > > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > > 
> > > > Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > 
> > > > 
> > > > But, I think the patch subject should be prefixed:
> > > > "serial: 8250_uniphier:"
> > > 
> > > Yeah thanks, that's difficult to script though.
> > > 
> > > 
> > 
> > Kernel development is hard :)
> 
> It is strange to process this per-platform
> and to send out a giant series that
> consists of 491 patches.
> 
> This is very trivial conversion.
> 
> I think it is better to have a single patch
> to convert all files under drivers/tty/serial/,
> with the patch subject "serial:".

The difficulty there is determining where these
subsystem spanning blocks should begin and end.

That could not be done for instance with drivers/net.

As I have suggested a few times, better still
would be to have a mechanism for scripted patches
applied possibly as single treewide patch.

Likely applied only at an -rc1.

The stated negatives to a treewide mechanism
have been difficulty to backport to -stable.

Perhaps a mechanism like

	git format-patch --stdout <treewide_commit_to_backport> | \
	git apply --include=<specific_files>

with some automated rewrite of the treewide patch subject
then commit could help.


