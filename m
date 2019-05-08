Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37C017EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfEHRCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 13:02:50 -0400
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:48850 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728351AbfEHRCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:02:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id AC1F5180A887B;
        Wed,  8 May 2019 17:02:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3873:3874:4250:4321:5007:8603:10004:10400:10848:11232:11658:11914:12294:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21627:30029:30034:30054:30083:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: wall32_8c725d4b2633f
X-Filterd-Recvd-Size: 1823
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 May 2019 17:02:44 +0000 (UTC)
Message-ID: <49e0fb2cd3b0a80848f67212167fdbab4b5b8a97.camel@perches.com>
Subject: Re: [PATCH 4/4] checkpatch: replace magic value for TAB size
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Date:   Wed, 08 May 2019 10:02:42 -0700
In-Reply-To: <CAAj6DX3LahQK_t0paVzcTfTsavANXnatgc_vX_1VLPJ9RhsdHQ@mail.gmail.com>
References: <20190508122721.7513-1-borneo.antonio@gmail.com>
         <20190508122721.7513-4-borneo.antonio@gmail.com>
         <73a79b49d0183468a63876b170d1318d38c78d73.camel@perches.com>
         <CAAj6DX3LahQK_t0paVzcTfTsavANXnatgc_vX_1VLPJ9RhsdHQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 17:32 +0200, Antonio Borneo wrote:
> On Wed, May 8, 2019 at 4:52 PM Joe Perches <joe@perches.com> wrote:
> ...
> > > In these cases the script will be probably modified and adapted,
> > > so there is no need (at least for the moment) to expose this
> > > setting on the script's command line.
> > 
> > Disagree.  Probably getter to add a --tabsize=<foo> option now.
> 
> Ok, will send a V2 including the command line option.
> Exposing TAB size, makes the option name relevant; should I keep
> "--tabsize" or is "--tab-stop" more appropriate?

--tabsize is probably more appropriate as tab stops are not
always a multiple of a single number.

Unless you really want to get funky and support something like
--tab-stops=7,13,17,...

I don't suggest that.


