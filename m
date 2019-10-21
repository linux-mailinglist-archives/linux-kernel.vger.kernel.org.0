Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD0DE726
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 10:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfJUIyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 04:54:18 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:39391 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726977AbfJUIyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:54:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id BB416182CF665;
        Mon, 21 Oct 2019 08:54:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7903:8985:9025:10004:10400:10903:11232:11658:11914:12043:12297:12663:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:21788:30012:30054:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: plate39_8105bbb6e644
X-Filterd-Recvd-Size: 2086
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 21 Oct 2019 08:54:15 +0000 (UTC)
Message-ID: <c6d923e10359746095d820ef19bd82cacc523b79.camel@perches.com>
Subject: Re: [PATCH v1 1/5] staging: wfx: fix warnings of no space is
 necessary
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Date:   Mon, 21 Oct 2019 01:54:14 -0700
In-Reply-To: <alpine.DEB.2.21.1910210850080.2959@hadrien>
References: <20191019140719.2542-1-jbi.octave@gmail.com>
          <20191019140719.2542-2-jbi.octave@gmail.com>
         <20191019142443.GH24678@kadam>
          <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>
          <20191019180514.GI24678@kadam>
          <336960fdf88dbed69dd3ed2689a5fb1d2892ace8.camel@perches.com>
         <20191020191759.GJ24678@kadam>
         <6e6bc92cac0858fe5bd37b28f688d3da043f4bef.camel@perches.com>
         <alpine.DEB.2.21.1910210850080.2959@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-21 at 08:52 +0200, Julia Lawall wrote:
> > btw2:
> > 
> > I really dislike all the code inconsistencies and
> > unnecessary code duplication with miscellaneous changes
> > in the rtl staging drivers....
> > 
> > Horrid stuff.
> 
> I'm not sure what you mean by "miscellaneous changes".  Do you mean that
> all issues should be fixed for one file before moving on to another one?
> 
> Or that there are code clones, and all of the clones should be updated at
> the same time?

Neither really.

But realtek drivers are basically code clones where
realtek should prefer to have a single library used
for multiple drivers.

And staging is basically a dumping ground for realtek
wireless drivers.

https://lkml.org/lkml/2019/5/15/1405


