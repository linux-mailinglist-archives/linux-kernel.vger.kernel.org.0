Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41E7194B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 15:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbfGWNdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 09:33:54 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:37552 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732181AbfGWNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:33:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D6461180273E0;
        Tue, 23 Jul 2019 13:33:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:10004:10400:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13071:13311:13357:13439:14180:14181:14659:14721:21060:21080:21627:21740:30046:30054:30060:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: boys93_78379f489d811
X-Filterd-Recvd-Size: 2231
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jul 2019 13:33:45 +0000 (UTC)
Message-ID: <269b4b895d64deef4a6d0033dcbed48da11fbce0.camel@perches.com>
Subject: Re: get_maintainers.pl subsystem output
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "Duda, Sebastian" <sebastian.duda@fau.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
Date:   Tue, 23 Jul 2019 06:33:44 -0700
In-Reply-To: <CAKXUXMym7Sd28gVxVXj60XS+aoqM4DAtEp2aA7BUUu06YQYufg@mail.gmail.com>
References: <2c912379f96f502080bfcc79884cdc35@fau.de>
         <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
         <2835dfa18922905ffabafb11fca7e1d2@fau.de>
         <CAKXUXMwfd133rv0bMert-BBftaqxxr_93dUHpaUjEwE8RE_wwA@mail.gmail.com>
         <8016ee9b5ee38fae0c782420ca449f863270cca9.camel@perches.com>
         <CAKXUXMym7Sd28gVxVXj60XS+aoqM4DAtEp2aA7BUUu06YQYufg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 15:25 +0200, Lukas Bulwahn wrote:
> Hi Joe,

Hi again.

> On Tue, Jul 23, 2019 at 1:18 PM Joe Perches <joe@perches.com> wrote:
> > On Tue, 2019-07-23 at 10:42 +0200, Lukas Bulwahn wrote:
> [...]
> > > Joe, would you support and would you accept if we extend
> > > get_maintainer.pl to provide output of the status in such a way that
> > > the status output can be clearly mapped to the subsystem?
> > 
> > Not really, no.  I don't see much value in your
> > request to others.  It seems you are doing some
> > academic work rather than actually using it for
> > sending patches.
> > 
> 
> Thank you for that indication. It is good to know that our use case is
> too special to be covered in the existing tool and serves no one else
> besides our research work.

Seems a bit harsh a description, and yes, I've
not ever seen a single request similar to yours
to use get_maintainer in such a manner.


