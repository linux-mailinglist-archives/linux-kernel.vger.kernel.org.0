Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B8466170
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 00:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfGKWAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 18:00:35 -0400
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:59254 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726181AbfGKWAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:00:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 87C83909A;
        Thu, 11 Jul 2019 22:00:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3150:3352:3622:3865:3867:3868:4321:5007:6737:7514:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12295:12297:12438:12555:12740:12760:12895:13069:13095:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21451:21627:30054:30070:30091,0,RBL:172.58.35.165:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: bean07_3ea908f224563
X-Filterd-Recvd-Size: 2260
Received: from XPS-9350 (unknown [172.58.35.165])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jul 2019 22:00:30 +0000 (UTC)
Message-ID: <eeeb09518c8967ffd48606c3d1222553752e895d.camel@perches.com>
Subject: Re: [PATCH] sound: soc: codecs: wcd9335: fix "conversion to bool
 not needed here"
From:   Joe Perches <joe@perches.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Gen Zhang <blackgod016574@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Jul 2019 15:00:00 -0700
In-Reply-To: <20190711174906.GA10867@hari-Inspiron-1545>
References: <20190711174906.GA10867@hari-Inspiron-1545>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-11 at 23:19 +0530, Hariprasad Kelam wrote:
> Fix below issue reported by coccicheck
> sound/soc/codecs/wcd9335.c:3991:25-30: WARNING: conversion to bool not
> needed here
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  sound/soc/codecs/wcd9335.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> index 1bbbe42..85a8d10 100644
> --- a/sound/soc/codecs/wcd9335.c
> +++ b/sound/soc/codecs/wcd9335.c
> @@ -3988,12 +3988,7 @@ static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
>  		regmap_read(wcd->if_regmap,
>  				WCD9335_SLIM_PGD_PORT_INT_RX_SOURCE0 + j, &val);
>  		if (val) {
> -			if (!tx)
> -				reg = WCD9335_SLIM_PGD_PORT_INT_EN0 +
> -					(port_id / 8);
> -			else
> -				reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 +
> -					(port_id / 8);
> +			reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 + (port_id / 8);
>  			regmap_read(
>  				wcd->if_regmap, reg, &int_val);
>  			/*

This change makes no sense and doesn't match the commit message.


