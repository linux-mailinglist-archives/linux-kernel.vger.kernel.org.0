Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C43C168085
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 15:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgBUOnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 09:43:00 -0500
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:37950 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728068AbgBUOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:42:59 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 815CD18224949;
        Fri, 21 Feb 2020 14:42:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2901:3138:3139:3140:3141:3142:3150:3351:3622:3865:3868:3870:3871:3872:3873:3874:4321:5007:7903:10004:10400:10848:11026:11232:11657:11658:11914:12043:12048:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21611:21627:21990:30054:30055:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: side25_19d6a506e5525
X-Filterd-Recvd-Size: 1548
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Feb 2020 14:42:57 +0000 (UTC)
Message-ID: <1247da797bc0a860e845989241385e124e589063.camel@perches.com>
Subject: Re: [PATCH] Intel: Skylake: Fix inconsistent IS_ERR and PTR_ERR
From:   Joe Perches <joe@perches.com>
To:     Xu Wang <vulab@iscas.ac.cn>, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 06:41:32 -0800
In-Reply-To: <20200221101112.3104-1-vulab@iscas.ac.cn>
References: <20200221101112.3104-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-21 at 18:11 +0800, Xu Wang wrote:
> PTR_ERR should access the value just tested by IS_ERR.
> In skl_clk_dev_probe(),it is inconsistent.
[]
> diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
[]
> @@ -384,7 +384,7 @@ static int skl_clk_dev_probe(struct platform_device *pdev)
>  				&clks[i], clk_pdata, i);
>  
>  		if (IS_ERR(data->clk[data->avail_clk_cnt])) {
> -			ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
> +			ret = PTR_ERR(data->clk[data->avail_clk_cnt]);

NAK.

This is not inconsistent and you are removing the ++
which is a post increment.  Likely that is necessary.

You could write the access and the increment as two
separate statements if it confuses you.


