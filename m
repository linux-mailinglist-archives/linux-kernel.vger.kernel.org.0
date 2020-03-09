Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E0017EC83
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 00:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCIXOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 19:14:08 -0400
Received: from smtprelay0151.hostedemail.com ([216.40.44.151]:38113 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbgCIXOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:14:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2F0F96125;
        Mon,  9 Mar 2020 23:14:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:7903:9108:10004:10400:10848:11232:11658:11914:12297:12663:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14659:21080:21627:21939:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: vest79_5dc54df15e11b
X-Filterd-Recvd-Size: 2015
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Mar 2020 23:14:04 +0000 (UTC)
Message-ID: <69ed8a468b3e4776d277292a2e4b2f9b3c266f23.camel@perches.com>
Subject: Re: [PATCH RFC] MAINTAINERS: include GOOGLE FIRMWARE entry
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 09 Mar 2020 16:12:24 -0700
In-Reply-To: <alpine.DEB.2.21.2003092035300.2953@felia>
References: <20200308195116.12836-1-lukas.bulwahn@gmail.com>
         <CABXOdTcrxoBCz24Ap=YJYZnr+oLAmaR10xZ9ar2mYbE1=RAoug@mail.gmail.com>
         <5129f7dbd8506cc9fd5a8f76dc993d789566af6c.camel@perches.com>
         <alpine.DEB.2.21.2003090702440.3325@felia>
         <20200309070534.GA4093795@kroah.com>
         <alpine.DEB.2.21.2003092035300.2953@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 22:03 +0100, Lukas Bulwahn wrote:
> I am starting with the "bigger" clustered files in drivers, and then try 
> > > to look at files in include and Documentation/ABI/.

If you want to spend the time tracking stuff down,
it may be best to to
start with include/

> > > Here is a rough statistics on how many files from each directory are in
> > > THE REST:
> > > 
> > >    1368 include

There are very likely some files there that should
actually be listed as part of a subsystem.

> > >     327 lib

Not many that aren't trivial or ancient.

> > >     321 Documentation

Probably a few

> > >     100 drivers

What's not already maintained is probably ancient.

Everything else may not matter much.

