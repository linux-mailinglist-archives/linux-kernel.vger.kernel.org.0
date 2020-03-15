Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A41F185A13
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 05:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgCOEeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 00:34:17 -0400
Received: from smtprelay0212.hostedemail.com ([216.40.44.212]:33592 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726136AbgCOEeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 00:34:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 8B2AC837F24C;
        Sun, 15 Mar 2020 04:34:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:10004:10400:10848:11232:11658:11914:12048:12297:12740:12760:12895:13069:13255:13311:13357:13439:13972:14096:14097:14659:14721:21080:21627:21990:30054:30056:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: blood54_7c668a58d7328
X-Filterd-Recvd-Size: 1907
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun, 15 Mar 2020 04:34:14 +0000 (UTC)
Message-ID: <1c31f0e1a0fe8ee268f27289f6f820c7e48596d5.camel@perches.com>
Subject: Re: [Outreachy kernel] [PATCH v2] Staging: rtl8723bs: rtw_mlme:
 Remove unnecessary conditions
From:   Joe Perches <joe@perches.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        Larry.Finger@lwfinger.net
Date:   Sat, 14 Mar 2020 21:32:29 -0700
In-Reply-To: <4deeaef8f8e0f23a9adbfd7d98840624e2994cf2.camel@gmail.com>
References: <20200313102912.17218-1-shreeya.patel23498@gmail.com>
         <25a1aca2c993ecb70ba7cd9c9e38bce9170a98b0.camel@perches.com>
         <4deeaef8f8e0f23a9adbfd7d98840624e2994cf2.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-03-14 at 16:58 +0530, Shreeya Patel wrote:
> This could be:
> >  	if ((!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable ==
> > 1)) ||
> > 	    pregistrypriv->ampdu_enable == 2)
> > 		phtpriv->ampdu_enable = true;
> > 
> > Though it is probably more sensible to just set
> > phtpriv->ampdu_enable without testing whether or
> > not it's already set:
> > 
> > 	if (pregistrypriv->ampdu_enable == 1 ||
> > 	    pregistrypriv->ampdu_enable == 2)
> > 		phtpriv->ampdu_enable = true;
> 
> But the else-if block which I removed in v2 of this patch had nothing
> in the block.
> It was not assigning any value to "phtpriv->ampdu_enable". ( basically
> it was empty and useless)

Right, I misread the deletions from patch.


