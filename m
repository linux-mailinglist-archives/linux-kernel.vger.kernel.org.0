Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F92F01DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 16:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390009AbfKEPtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 10:49:14 -0500
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:39927 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389506AbfKEPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:49:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 98CB618224D6E;
        Tue,  5 Nov 2019 15:49:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2110:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:4043:4321:5007:10004:10400:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13071:13311:13357:13439:14180:14659:14721:21060:21080:21451:21627:21939:30003:30054:30070:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: bells35_8a71c36980a62
X-Filterd-Recvd-Size: 2812
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Nov 2019 15:49:11 +0000 (UTC)
Message-ID: <1beaa707511e1ef6b1e2fe408a61a35d4cd0b5ba.camel@perches.com>
Subject: Re: [PATCH v3 3/5] bus: hisi_lpc: Clean some types
From:   Joe Perches <joe@perches.com>
To:     John Garry <john.garry@huawei.com>, xuwei5@huawei.com
Cc:     linuxarm@huawei.com, linux-kernel@vger.kernel.org, olof@lixom.net,
        bhelgaas@google.com, arnd@arndb.de
Date:   Tue, 05 Nov 2019 07:48:43 -0800
In-Reply-To: <d6c8521c-30c0-7a2c-b658-8734f7b180d3@huawei.com>
References: <1572888139-47298-1-git-send-email-john.garry@huawei.com>
         <1572888139-47298-4-git-send-email-john.garry@huawei.com>
         <a391e4df7c080c6a4d7eac58708967d02f0449fa.camel@perches.com>
         <d6c8521c-30c0-7a2c-b658-8734f7b180d3@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 09:50 +0000, John Garry wrote:
> On 04/11/2019 18:39, Joe Perches wrote:
> > On Tue, 2019-11-05 at 01:22 +0800, John Garry wrote:
> > > Sparse complains of these:
> > > drivers/bus/hisi_lpc.c:82:38: warning: incorrect type in argument 1 (different address spaces)
> > > drivers/bus/hisi_lpc.c:82:38:    expected void const volatile [noderef] <asn:2>*addr
> > > drivers/bus/hisi_lpc.c:82:38:    got unsigned char *
> > > drivers/bus/hisi_lpc.c:131:35: warning: incorrect type in argument 1 (different address spaces)
> > > drivers/bus/hisi_lpc.c:131:35:    expected unsigned char *mbase
> > > drivers/bus/hisi_lpc.c:131:35:    got void [noderef] <asn:2>*membase
> > > drivers/bus/hisi_lpc.c:186:35: warning: incorrect type in argument 1 (different address spaces)
> > > drivers/bus/hisi_lpc.c:186:35:    expected unsigned char *mbase
> > > drivers/bus/hisi_lpc.c:186:35:    got void [noderef] <asn:2>*membase
> > > drivers/bus/hisi_lpc.c:228:16: warning: cast to restricted __le32
> > > drivers/bus/hisi_lpc.c:251:13: warning: incorrect type in assignment (different base types)
> > > drivers/bus/hisi_lpc.c:251:13:    expected unsigned int [unsigned] [usertype] val
> > > drivers/bus/hisi_lpc.c:251:13:    got restricted __le32 [usertype] <noident>
> > > 
> > > Clean them up.
> > 
> > OK, it might also be good to change the _in and _out functions
> > to use void * and not unsigned char * for buf
> 
> Hi Joe,

Hi John.

> In fact, using unsigned char * is the right thing to do, and really the 
> upper layer prob should not be passing void *. I'll look at this as a 
> follow up.

Maybe so, but it looks like the generic readsb and writesb routines
take void * so it might be a lot of other files to modify.

g'luck and cheers, Joe

