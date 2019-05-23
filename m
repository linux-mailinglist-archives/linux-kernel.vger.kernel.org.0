Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300DD28C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 23:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbfEWVCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 17:02:25 -0400
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:56005 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729797AbfEWVCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:02:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A6868182CED28;
        Thu, 23 May 2019 21:02:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:421:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2110:2198:2199:2393:2553:2559:2562:2828:2911:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4425:4470:5007:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13149:13230:13311:13357:13439:14096:14097:14181:14659:14721:21080:21324:21451:21627:30054:30060:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: brick10_31daacd83bf3d
X-Filterd-Recvd-Size: 1862
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 23 May 2019 21:02:22 +0000 (UTC)
Message-ID: <a3c036b12979ab7269917247a683eeb63df71d58.camel@perches.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Add entry for fieldbus subsystem
From:   Joe Perches <joe@perches.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 23 May 2019 14:02:16 -0700
In-Reply-To: <CAGngYiUnRSSPLDhXeAg5E0pM_-ZbNV9qpOarSemDdpwLPRZeqA@mail.gmail.com>
References: <20190523195313.31008-1-TheSven73@gmail.com>
         <1b741b25b973e049948b3e490c13aad48716d5b0.camel@perches.com>
         <CAGngYiUnRSSPLDhXeAg5E0pM_-ZbNV9qpOarSemDdpwLPRZeqA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-23 at 16:23 -0400, Sven Van Asbroeck wrote:
> On Thu, May 23, 2019 at 4:00 PM Joe Perches <joe@perches.com> wrote:
> > trivia: anybuss looks like a misspelling.
> > It might be better as anybus-s.
> This came up as well during the review process. When we insert a separator,
> the include files start looking like anybus-s-controller.h, and the structs
> become like struct anybus_s_ops. It then no longer looks like a misspelling,
> but becomes harder to read?
> 
> An alternative solution is to get rid of the 's' suffix altogether. Anybus-S
> is the only flavour we support right now. Although that may obviously
> change in the future.

anybuss just looked odd to me.

Whatever you choose is up to you and
no doubt you'll choose well.

cheers, Joe


