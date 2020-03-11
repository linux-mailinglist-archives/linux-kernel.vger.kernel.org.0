Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D8F18247F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 23:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgCKWLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 18:11:10 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:34216 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729518AbgCKWLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:11:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id F39FF181D330D;
        Wed, 11 Mar 2020 22:11:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2566:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3870:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4362:5007:9025:10004:10400:11232:11658:11914:12043:12297:12438:12555:12679:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21080:21433:21627:21740:21811:21939:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: loaf59_60ffb32fe5a07
X-Filterd-Recvd-Size: 1958
Received: from XPS-9350 (unknown [172.58.78.137])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 22:11:06 +0000 (UTC)
Message-ID: <3fc2c61e4c1c25d847fd7f284c818b664b64441c.camel@perches.com>
Subject: Re: [PATCH -next 023/491] AMD KFD: Use fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 11 Mar 2020 15:09:22 -0700
In-Reply-To: <12c75b17-1d0e-6cc4-4ed1-a6f5003772ae@amd.com>
References: <cover.1583896344.git.joe@perches.com>
         <3cfc40c8f750abc672d6a60418fe220cb663a0f5.1583896349.git.joe@perches.com>
         <12c75b17-1d0e-6cc4-4ed1-a6f5003772ae@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 17:50 -0400, Felix Kuehling wrote:
> On 2020-03-11 12:51 a.m., Joe Perches wrote:
> > Convert the various uses of fallthrough comments to fallthrough;
> > 
> > Done via script
> > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> 
> The link seems to be broken. This one works: 
> https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/

Thanks.

I neglected to use a backslash on the generating script.
In the script in 0/491,

Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/

likely should have been:

Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe\@perches.com/


