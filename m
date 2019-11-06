Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680E4F1E19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 20:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbfKFTCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 14:02:14 -0500
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:36857 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732219AbfKFTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:02:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D8FA918021E46;
        Wed,  6 Nov 2019 19:02:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3871:3872:3873:3874:3876:4321:5007:6691:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21324:21451:21627:30012:30054:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: pipe51_86cd89710ff50
X-Filterd-Recvd-Size: 1661
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Nov 2019 19:02:06 +0000 (UTC)
Message-ID: <7b6295e48dbb4b5b9c578516f40b61ad2afd115b.camel@perches.com>
Subject: Re: s390/pkey: Use memdup_user() rather than duplicating its
 implementation
From:   Joe Perches <joe@perches.com>
To:     Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     Christian =?ISO-8859-1?Q?Borntr=E4ger?= <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 06 Nov 2019 11:01:53 -0800
In-Reply-To: <cba4068c-0d63-fc0a-44bb-2664b690f126@web.de>
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
         <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
         <0f90b278-7b3e-6509-1633-301d16513c5d@web.de>
         <47c55ab899aafe10898e6581582363aa446b2091.camel@perches.com>
         <cba4068c-0d63-fc0a-44bb-2664b690f126@web.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-06 at 19:55 +0100, Markus Elfring wrote:
> > There is no bug here.
> 
> Do you find duplicated source code questionable?

No.  It is something that can be improved through
code consolidation though.

> Is this also an error item?

Definitely not.  It is _only_ an error if there is
some logic defect.  There is no logic defect here.


