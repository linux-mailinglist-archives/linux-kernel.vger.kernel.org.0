Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 971CBF5C92
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 01:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfKIAzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 19:55:15 -0500
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:33453 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbfKIAzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 19:55:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1D52A182CED2A;
        Sat,  9 Nov 2019 00:55:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2559:2567:2570:2682:2685:2703:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3622:3865:3867:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7514:7974:9025:10004:10400:11658:12048:12740:13069,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: woman68_84de4be6cd92a
X-Filterd-Recvd-Size: 1721
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat,  9 Nov 2019 00:55:12 +0000 (UTC)
Message-ID: <c6c9bd718c4cbee34b13a0b2c9dfefeee00bada5.camel@perches.com>
Subject: Re: [PATCH 1/5] random: remove unnecessary unlikely()
From:   Joe Perches <joe@perches.com>
To:     Frank Lee <tiny.windzz@gmail.com>, tytso@mit.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 08 Nov 2019 16:54:59 -0800
In-Reply-To: <4454ca6d4648a41ca6435eba24bf565625bbfd68.camel@perches.com>
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
         <CAEExFWvh9HMWNKeDNhx1vqTbUB=_117qCP1TjCxEFwiYV4N_FA@mail.gmail.com>
         <4454ca6d4648a41ca6435eba24bf565625bbfd68.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-29 at 00:14 -0700, Joe Perches wrote:
> On Thu, 2019-07-11 at 22:49 +0800, Frank Lee wrote:
> > ping...
> 
> Ted?
> 
> Is there some reason this patch series was not applied?
> 
> https://lore.kernel.org/lkml/20190607182517.28266-1-tiny.windzz@gmail.com/
> https://lore.kernel.org/lkml/20190607182517.28266-2-tiny.windzz@gmail.com/
> https://lore.kernel.org/lkml/20190607182517.28266-3-tiny.windzz@gmail.com/
> https://lore.kernel.org/lkml/20190607182517.28266-4-tiny.windzz@gmail.com/
> https://lore.kernel.org/lkml/20190607182517.28266-5-tiny.windzz@gmail.com/

Ted?

Do you object to this series going into the tree at all?
If not, do you want someone else to pick it up?


