Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D45BF18041F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 17:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgCJQ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 12:59:05 -0400
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:55651 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbgCJQ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:59:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4BA3D100FBB16;
        Tue, 10 Mar 2020 16:59:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:2892:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7514:7875:7903:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12555:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21451:21627:30012:30029:30054:30070:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:13,LUA_SUMMARY:none
X-HE-Tag: coat13_4ecf5281c8248
X-Filterd-Recvd-Size: 2756
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Mar 2020 16:59:01 +0000 (UTC)
Message-ID: <3b19da8cb94aeb1e77452348dc528dd3b8a52a2a.camel@perches.com>
Subject: Re: [Outreachy kernel] [PATCH v2] Staging: rtl8188eu: rtw_mlme: Add
 space around operators
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, sbrivio@redhat.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl
Date:   Tue, 10 Mar 2020 09:57:20 -0700
In-Reply-To: <alpine.DEB.2.21.2003101554530.26409@hadrien>
References: <20200310144702.14653-1-shreeya.patel23498@gmail.com>
         <alpine.DEB.2.21.2003101554530.26409@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-10 at 15:57 +0100, Julia Lawall wrote:
> On Tue, 10 Mar 2020, Shreeya Patel wrote:
> 
> > Add space around operators for improving the code
> > readability.
> > 
> > Reported by checkpatch.pl
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > ---
> > 
> > rtw_mlme_old.o - Previously produced object file before making any
> > changes to the source code.
> > rtw_mlme.o - Object file produced after compiling the changes done in source
> > file.
> > 
> > Following is the output of diff between the previously produced object
> > file and the object file produced after compiling the changes.
> > 
> > shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/core$ diff rtw_mlme_old.o rtw_mlme.o
> > shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/core$
> > 
> > Following output shows that there was no other change in the source
> > code except for whitespace.
> > 
> > shreeya@Shreeya-Patel:~git/kernels/staging$ git diff -w drivers/staging/rtl8188eu/core/
> > shreeya@Shreeya-Patel:~git/kernels/staging$
> 
> If this information is importamt, it should be above the line.  On the
> other hand, it is much too detailed, making it hard to figure out what is
> being said.  It would be better to just say diff of the .o files before
> and after the changes shows no difference.  Likewise git diff -w shows no
> difference.  That way one can quickly see what tests you did, without
> being distracted by the machine name, the directory name, etc.

Exactly right.

Keep at it Shreeya.  Almost done.

[It's also nice to trim your replies Julia]


