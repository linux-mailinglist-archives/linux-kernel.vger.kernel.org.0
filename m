Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 394F2E5E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 19:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfJZRS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 13:18:57 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:46015 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726210AbfJZRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 13:18:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id ED97F182CED34;
        Sat, 26 Oct 2019 17:18:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4321:4385:5007:7903:9010:10004:10400:10848:11026:11232:11657:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:21080:21627:30012:30054:30070:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: maid80_30be03369d63b
X-Filterd-Recvd-Size: 1939
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat, 26 Oct 2019 17:18:54 +0000 (UTC)
Message-ID: <2bc9e96ec06fe94505b5e7d967d1453f072738a6.camel@perches.com>
Subject: Re: [PATCH 7/7] staging: rtl8188eu: reduce indentation level in
 rtw_alloc_stainfo
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 26 Oct 2019 10:18:51 -0700
In-Reply-To: <20191026121135.181897-7-straube.linux@gmail.com>
References: <20191026121135.181897-1-straube.linux@gmail.com>
         <20191026121135.181897-7-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-10-26 at 14:11 +0200, Michael Straube wrote:
> Remove else-arm from if-else statement. Move the else code out of the
> if-else and skip it by adding goto exit to the if block. The exit label
> was directly after the else-arm, so there is no change in behaviour.
> Reduces indentation level and clears a line over 80 characters
> checkpatch warning.
[]
> diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
[]
> @@ -181,70 +181,71 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
>  					struct sta_info, list);
>  	if (!psta) {
>  		spin_unlock_bh(&pfree_sta_queue->lock);

Because exit does no cleanup, it's probably simpler as
		return NULL;
and then remove the exit label

> +	if (index >= NUM_STA) {
> +		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_,
> +			 ("ERROR => %s: index >= NUM_STA", __func__));
> +		psta = NULL;
> +		goto exit;

here too

[]

> +
>  exit:
>  	return psta;
>  }


