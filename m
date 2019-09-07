Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18CAC900
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 21:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436625AbfIGT1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Sep 2019 15:27:20 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:56317 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404763AbfIGT1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 15:27:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A7C32181D33FB;
        Sat,  7 Sep 2019 19:27:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:152:355:379:599:800:960:969:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4552:4823:5007:7903:8531:9010:10004:10400:10848:11232:11658:11914:12050:12297:12663:12740:12895:13019:13069:13311:13357:13894:14096:14097:14659:14721:14777:21080:21433:21627:21740:21819:30054:30060:30070:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: day83_3fb643158d92c
X-Filterd-Recvd-Size: 2249
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat,  7 Sep 2019 19:27:17 +0000 (UTC)
Message-ID: <a99b7481f26138ea01de0d271e9aec2a525c0aed.camel@perches.com>
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sandro Volery <sandro@volery.com>
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com
Date:   Sat, 07 Sep 2019 12:27:16 -0700
In-Reply-To: <20190907174232.GA20070@kroah.com>
References: <20190907172944.GB18166@kroah.com>
         <B45E122D-2B8B-43DA-8658-889E30CB2F0F@volery.com>
         <20190907174232.GA20070@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-09-07 at 18:42 +0100, Greg KH wrote:
> On Sat, Sep 07, 2019 at 07:35:42PM +0200, Sandro Volery wrote:
> > 
> > > > > On 7 Sep 2019, at 19:29, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > ﻿On Sat, Sep 07, 2019 at 07:23:59PM +0200, Sandro Volery wrote:
> > > > Dear Greg,
> > > > I am pretty sure the issue was, that I did too many things at once. However, all the things I did are related to spaces / tabs, maybe that still works?
> > > 
> > > <snip>
> > > 
> > > For some reason you sent this only to me, which is a bit rude to
> > > everyone else on the mailing list.  I'll be glad to respond if you
> > > resend it to everyone.
> > 
> > I'm sorry, newbie here. I thought it'd be better to not annoy everyone with responses but learning things everyday I guess :)
> 
> No problem, but you should also line-wrap your emails :)
> 
> > I am pretty sure the issue with my patch was that there was too many changes, however all of them were spaces and tabs related, so I think this could be fine?
> 
> As the bot said, break it out into "one patch per logical change", and
> "fix all whitespace issues" is not "one logical change".

As long as git diff -w shows no difference and a compiled
object comparison before and after the change shows no
difference, I think it's fine.

In fact, it avoid multiple commits where the only changes
are whitespace.



