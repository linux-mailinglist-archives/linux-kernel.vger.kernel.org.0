Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FAA64EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 00:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfGJWag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 18:30:36 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:38004 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727222AbfGJWag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:30:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id F376B182CF67C;
        Wed, 10 Jul 2019 22:30:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3873:4250:4321:5007:7514:7875:9040:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12297:12438:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:21810:30012:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: group31_794d726ad7435
X-Filterd-Recvd-Size: 2043
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 22:30:33 +0000 (UTC)
Message-ID: <bc0f21dd8753190c6fbba0d3f7469a2d8c87b341.camel@perches.com>
Subject: Re: [PATCH] Staging: rtl8723bs: hal: rtl8723bs_recv.c: Fix code
 style
From:   Joe Perches <joe@perches.com>
To:     Fatih ALTINPINAR <fatihaltinpinar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Josenivaldo Benito Jr <jrbenito@benito.qsl.br>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Jul 2019 15:30:32 -0700
In-Reply-To: <20190708095652.18174-1-fatihaltinpinar@gmail.com>
References: <20190708095652.18174-1-fatihaltinpinar@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-08 at 12:56 +0300, Fatih ALTINPINAR wrote:
> Fixed a coding stlye issue. Removed braces from a single statement if
> block.
> 
> Signed-off-by: Fatih ALTINPINAR <fatihaltinpinar@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
> index e23b39ab16c5..71a4bcbeada9 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
> @@ -449,9 +449,8 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
>  				skb_reserve(precvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
>  			}
>  
> -			if (!precvbuf->pskb) {
> +			if (!precvbuf->pskb)
>  				DBG_871X("%s: alloc_skb fail!\n", __func__);
> -			}

You could delete the block instead.
alloc_skb failures already do a dump_stack()


