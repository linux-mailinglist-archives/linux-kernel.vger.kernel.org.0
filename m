Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D659866A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 18:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404090AbfHHQJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 12:09:06 -0400
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:57227 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732662AbfHHQJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:09:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8CE79181D33FB;
        Thu,  8 Aug 2019 16:09:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3870:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:8531:8985:9025:10004:10400:10848:11232:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:12986:13069:13149:13230:13311:13357:13439:14096:14097:14181:14659:14721:21067:21080:21627:21811:30046:30054:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: hair31_4f1ae28119a43
X-Filterd-Recvd-Size: 1962
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Aug 2019 16:09:03 +0000 (UTC)
Message-ID: <77939c33095725515c73b04586e105916ce4b1e5.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: mark wusbcore and UWB as obsolete
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Date:   Thu, 08 Aug 2019 09:09:02 -0700
In-Reply-To: <20190808112358.GA25286@kroah.com>
References: <20190806101509.GA11280@kroah.com>
         <b73f09c944625a40b2589e9bac7f8bd22a711ed3.camel@perches.com>
         <20190806113501.GA18443@kroah.com> <20190808092509.GA20173@kroah.com>
         <20190808094158.GA22635@kroah.com>
         <92ed89b0346a54fb06d3e08585a8d0b4175842f0.camel@perches.com>
         <20190808112358.GA25286@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-08 at 13:23 +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 08, 2019 at 04:15:44AM -0700, Joe Perches wrote:
> > On Thu, 2019-08-08 at 11:41 +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Aug 08, 2019 at 11:25:09AM +0200, Greg Kroah-Hartman wrote:
> > > > Joe rightly points out that we should be using the "Obsolete" status for
> > > > these two subsystems.
> > > 
> > > Even with that change, I don't see get_maintainers.pl tell me I
> > > shouldn't be sending a patch in for this area:
> > 
> > Nor should you.  It's checkpatch that should warn.
> 
> Ah, wrong tool.  Yes, it does, let's see if anyone actually notices that
> when sending checkpatch changes for these files in the future :)

Maybe mark the isdn block obsolete too.

https://lore.kernel.org/lkml/2ecfbf8dda354fe47912446bf5c3fe30ca905aa0.camel@perches.com/


