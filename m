Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7F883AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 23:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfHFVP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 17:15:59 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:53456 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726016AbfHFVP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:15:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4B4CD8368EF7;
        Tue,  6 Aug 2019 21:15:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:4321:4605:5007:6119:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:21080:21451:21627:30054:30060:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: tray62_16bee76040d3f
X-Filterd-Recvd-Size: 2426
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Aug 2019 21:15:56 +0000 (UTC)
Message-ID: <a687a6d29d4cc928a6aa128bcada5f55b26f41a4.camel@perches.com>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK
 inputs
From:   Joe Perches <joe@perches.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 06 Aug 2019 14:15:54 -0700
In-Reply-To: <20190806192727.GA11773@rikard>
References: <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
         <2b782cf609330f53b6ecc5b75a8a4b49898483eb.camel@perches.com>
         <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com>
         <20190802181853.GA809@rikard>
         <CAK7LNAT+cNxna4SER04MdkBsq_LDg4TwYR_U1ioNNxYOZWXigA@mail.gmail.com>
         <CAK7LNAQv-5epL8DYDaUdHsQEQ=Va676t_6TgsaSYC30Eix=iyw@mail.gmail.com>
         <20190803183637.GA831@rikard>
         <CAK7LNASBndh4yJKVdeMb7RQGopUzEUSNXPQcUgQdB8PiJetMuQ@mail.gmail.com>
         <20190805195526.GA869@rikard>
         <CAK7LNATpQDWoMv+hnPrb1DTu4HravUhuhANnQkayxaJw99_ajQ@mail.gmail.com>
         <20190806192727.GA11773@rikard>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-06 at 21:27 +0200, Rikard Falkeborn wrote:
> On Wed, Aug 07, 2019 at 12:19:36AM +0900, Masahiro Yamada wrote:
> > How about this?
> > #define GENMASK_INPUT_CHECK(high, low) \
> >        BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> >               __builtin_constant_p((low) > (high)), (low) > (high), 0))
> Thanks for the feedback, your version looks much cleaner than mine. I
> *think* I had a reason for using __is_constexpr() instead of
> __builtin_constant_p but I'll try a full rebuild to see if something
> comes up.

Perhaps a statement expression so high and low aren't possibly
evaluated multiple times?

#define GENMASK_INPUT_CHECK(high, low)				\
({								\
	typeof(high) _high = high;				\
	typeof(low) _low = low;					\
	BUILD_BUG_ON_ZERO(__builtin_constant_p(_low > _high,	\
					       _low > _high,	\
					       0))		\
})


