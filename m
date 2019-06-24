Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB31B50DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 16:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfFXO1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 10:27:51 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:58485 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727742AbfFXO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:27:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2872E180A68A0;
        Mon, 24 Jun 2019 14:27:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:1981:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3866:3867:3872:4321:5007:7903:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13072:13172:13229:13311:13357:13439:14659:14777:21080:21433:21451:21627:21819:30003:30022:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:31,LUA_SUMMARY:none
X-HE-Tag: music70_444d31ab65a3e
X-Filterd-Recvd-Size: 1449
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 14:27:49 +0000 (UTC)
Message-ID: <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Add --cc option
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 07:27:47 -0700
In-Reply-To: <20190624133333.GW3419@hirez.programming.kicks-ass.net>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
         <20190624133333.GW3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-24 at 15:33 +0200, Peter Zijlstra wrote:
> On Mon, Jun 24, 2019 at 03:03:23PM +0200, Sebastian Andrzej Siewior wrote:
> > The --cc adds a Cc: prefix infront of the email address so it can be
> > used by other Scripts directly instead of adding another wrapper for
> > this.

Not sure I like the "--cc" option naming.
Maybe "--prefix [string]" to be a bit more generic.

> Would it make sense to make '--cc' imply --no-roles --no-rolestats ?

Maybe.

It's also unlikely to be sensibly used with mailing
lists so maybe --nol too.


