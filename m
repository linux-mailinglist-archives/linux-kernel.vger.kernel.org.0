Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB1012995
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 10:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfECIMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 04:12:13 -0400
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:35864 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbfECIMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:12:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 709E1837F27B;
        Fri,  3 May 2019 08:12:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3867:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6642:9025:10004:10400:10848:11232:11658:11914:12043:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21080:21365:21627:30054:30069:30091,0,RBL:84.16.30.4:@perches.com:.lbl8.mailshell.net-62.14.6.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: silk87_12ba163999c4b
X-Filterd-Recvd-Size: 1189
Received: from XPS-9350 (unknown [84.16.30.4])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 May 2019 08:12:08 +0000 (UTC)
Message-ID: <cf6948fb8ab8e395e139a3440f3600a6050c1efa.camel@perches.com>
Subject: Re: [PATCH] powerpc/powernv/ioda2: Add __printf format/argument
 verification
From:   Joe Perches <joe@perches.com>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 03 May 2019 01:12:05 -0700
In-Reply-To: <44wNKc0KZFz9sPd@ozlabs.org>
References: <44wNKc0KZFz9sPd@ozlabs.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-03 at 16:59 +1000, Michael Ellerman wrote:
> On Thu, 2017-03-30 at 10:19:25 UTC, Joe Perches wrote:
> > Fix fallout too.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/1e496391a8452101308a23b7395cdd49

2+ years later.


