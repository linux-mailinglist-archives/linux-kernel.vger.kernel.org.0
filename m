Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08632E57ED
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 03:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfJZBud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 21:50:33 -0400
Received: from smtprelay0031.hostedemail.com ([216.40.44.31]:37245 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725954AbfJZBuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 21:50:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 45A38180A55F2;
        Sat, 26 Oct 2019 01:50:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 80,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:4321:4385:4605:5007:6119:7903:9010:10004:10400:11026:11232:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21627:30012:30054:30070:30091,0,RBL:23.242.70.174:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: earth15_5ba9bbbc1535a
X-Filterd-Recvd-Size: 2324
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat, 26 Oct 2019 01:50:29 +0000 (UTC)
Message-ID: <25960b2a5dfe3f5f2c6579ef718f90a139ba84d7.camel@perches.com>
Subject: Re: [RESEND PATCH 1/2] staging: rtl8712: Fix Alignment of open
 parenthesis
From:   Joe Perches <joe@perches.com>
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>,
        outreachy-kernel@googlegroups.com
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Oct 2019 18:50:25 -0700
In-Reply-To: <e3842148b6dd01c47678f517a07772c75046c50f.1572051351.git.cristianenavescardoso09@gmail.com>
References: <cover.1572051351.git.cristianenavescardoso09@gmail.com>
         <e3842148b6dd01c47678f517a07772c75046c50f.1572051351.git.cristianenavescardoso09@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-25 at 22:09 -0300, Cristiane Naves wrote:
> Fix alignment should match open parenthesis.Issue found by checkpatch.

Beyond doing style cleanups, please always try
to make the code more readable.

> diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
[]
> @@ -61,13 +61,13 @@ void r8712_init_recv_priv(struct recv_priv *precvpriv,
>  		precvbuf->ref_cnt = 0;
>  		precvbuf->adapter = padapter;
>  		list_add_tail(&precvbuf->list,
> -				 &(precvpriv->free_recv_buf_queue.queue));
> +			      &(precvpriv->free_recv_buf_queue.queue));

Please remove the unnecessary parentheses too

>  		precvbuf++;
>  	}
>  	precvpriv->free_recv_buf_queue_cnt = NR_RECVBUFF;
>  	tasklet_init(&precvpriv->recv_tasklet,
> -	     (void(*)(unsigned long))recv_tasklet,
> -	     (unsigned long)padapter);
> +		     (void(*)(unsigned long))recv_tasklet,
> +		     (unsigned long)padapter);

It's probably better to change the recv_tasklet function
declaration to
use the more common style of

static void recv_tasklet(unsigned long priv)

and do the cast in the recv_tasklet function.


