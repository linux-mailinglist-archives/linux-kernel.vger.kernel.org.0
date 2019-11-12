Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC38DF99B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 20:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKLTaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 14:30:01 -0500
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:45973 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726970AbfKLTaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:30:01 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9E42318030167;
        Tue, 12 Nov 2019 19:29:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3868:3870:3871:3872:3874:4321:4605:4823:5007:6691:7576:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21611:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:44,LUA_SUMMARY:none
X-HE-Tag: women58_9143341421351
X-Filterd-Recvd-Size: 2254
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Nov 2019 19:29:58 +0000 (UTC)
Message-ID: <dfb2c158308e0e9cb790ad3c17eb2563ac192f2b.camel@perches.com>
Subject: Re: [PATCH][next] ASoC: tas2770: clean up an indentation issue
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Nov 2019 11:29:41 -0800
In-Reply-To: <20191112190218.282337-1-colin.king@canonical.com>
References: <20191112190218.282337-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-12 at 19:02 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a block that is indented too deeply, remove
> the extraneous tabs.
[]
> diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
[]
> @@ -761,12 +761,12 @@ static int tas2770_i2c_probe(struct i2c_client *client,
>  	tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev,
>  							  "reset-gpio",
>  						      GPIOD_OUT_HIGH);
> -		if (IS_ERR(tas2770->reset_gpio)) {
> -			if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
> -				tas2770->reset_gpio = NULL;
> -				return -EPROBE_DEFER;
> -			}
> +	if (IS_ERR(tas2770->reset_gpio)) {
> +		if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
> +			tas2770->reset_gpio = NULL;
> +			return -EPROBE_DEFER;
>  		}
> +	}

This could remove the IS_ERR and and also remove another indentation level

	if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
		tas2770->reset_gpio = NULL;
		return -EPROBE_DEFER;
	}

or if _really_ desired, (but it seems not really necessary)
but this form is used in a few other sound drivers:

	if (IS_ERR(tas2770->reset_gpio) &&
	    PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
		tas2770->reset_gpio = NULL;
		return -EPROBE_DEFER;
	}

