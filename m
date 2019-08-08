Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F3186225
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 14:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbfHHMqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 08:46:03 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:47603 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbfHHMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:46:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9E96F18225E01;
        Thu,  8 Aug 2019 12:46:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:152:355:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3653:3865:3870:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6248:8985:9025:10004:10400:10848:10967:11232:11658:11914:12043:12297:12438:12555:12740:12895:13069:13160:13229:13311:13357:13894:14181:14659:14721:14777:21080:21433:21611:21627:21811:30054:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: jewel76_347d3c036ea1e
X-Filterd-Recvd-Size: 1590
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Aug 2019 12:46:00 +0000 (UTC)
Message-ID: <fe704b1c159849037e394283b6318fdbc981ca0e.camel@perches.com>
Subject: Re: [PATCH] scripts/checkpatch.pl - fix *_NOTIFIER_HEAD handling
From:   Joe Perches <joe@perches.com>
To:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 08 Aug 2019 05:45:59 -0700
In-Reply-To: <56763.1565244495@turing-police>
References: <33485.1565228181@turing-police>
         <33e3b8748959b2f56b906b0bfd790df322f1ed3c.camel@perches.com>
         <56763.1565244495@turing-police>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-08 at 02:08 -0400, Valdis Klētnieks wrote:
> On Wed, 07 Aug 2019 22:50:47 -0700, Joe Perches said:
> > On Wed, 2019-08-07 at 21:36 -0400, Valdis Kltnieks wrote:
> > >  				^.DEFINE_$Ident\(\Q$name\E\)|
> > >  				^.DECLARE_$Ident\(\Q$name\E\)|
> > >  				^.LIST_HEAD\(\Q$name\E\)|
> > > -				^.{$Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
> > > +				^.${Ident}_NOTIFIER_HEAD\(\Q$name\E\)|

oops.

I did reply with the correct form for Gilad's original patch.
https://lore.kernel.org/lkml/613b7f1dd7244df22f677777cc946758cbd7e61c.camel@perches.com/

My mistake not noticing again in Gilad's v2.
Oh well.

