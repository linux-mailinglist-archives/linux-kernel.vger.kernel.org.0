Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48D0E6DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 09:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfJ1IJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 04:09:47 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:42770 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729786AbfJ1IJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:09:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 596B3181D3052;
        Mon, 28 Oct 2019 08:09:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:966:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3874:4321:4385:4605:5007:6119:7903:9010:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30012:30054:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: stew80_1ac8e633b015e
X-Filterd-Recvd-Size: 2274
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Oct 2019 08:09:43 +0000 (UTC)
Message-ID: <67386d9dec115d8eccaa6407a29c525eafd7811c.camel@perches.com>
Subject: Re: [RESEND PATCH 1/2] staging: rtl8712: Fix Alignment of open
 parenthesis
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Cristiane Naves <cristianenavescardoso09@gmail.com>,
        outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Date:   Mon, 28 Oct 2019 01:09:38 -0700
In-Reply-To: <20191028080113.GD1944@kadam>
References: <cover.1572051351.git.cristianenavescardoso09@gmail.com>
         <e3842148b6dd01c47678f517a07772c75046c50f.1572051351.git.cristianenavescardoso09@gmail.com>
         <25960b2a5dfe3f5f2c6579ef718f90a139ba84d7.camel@perches.com>
         <20191028080113.GD1944@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-28 at 11:01 +0300, Dan Carpenter wrote:
> On Fri, Oct 25, 2019 at 06:50:25PM -0700, Joe Perches wrote:
> > On Fri, 2019-10-25 at 22:09 -0300, Cristiane Naves wrote:
> > > Fix alignment should match open parenthesis.Issue found by checkpatch.
> > 
> > Beyond doing style cleanups, please always try
> > to make the code more readable.
> > 
> > > diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
> > []
> > > @@ -61,13 +61,13 @@ void r8712_init_recv_priv(struct recv_priv *precvpriv,
> > >  		precvbuf->ref_cnt = 0;
> > >  		precvbuf->adapter = padapter;
> > >  		list_add_tail(&precvbuf->list,
> > > -				 &(precvpriv->free_recv_buf_queue.queue));
> > > +			      &(precvpriv->free_recv_buf_queue.queue));
> > 
> > Please remove the unnecessary parentheses too
> > 
> 
> Removing the parentheses increases your chance of the patch being
> rejected on the one thing per patch rule...

Which for people that actually know how to
read and write code is a silly rule.


