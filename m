Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88ACA41D4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 04:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfHaC6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 22:58:13 -0400
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:58380 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726406AbfHaC6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 22:58:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3E89718224508;
        Sat, 31 Aug 2019 02:58:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:2919:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:3873:4321:4384:4605:5007:7904:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:13523:13524:14659:14721:21080:21627:30009:30054:30091,0,RBL:23.242.70.174:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: mouth58_2a3e073eed542
X-Filterd-Recvd-Size: 1882
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat, 31 Aug 2019 02:58:10 +0000 (UTC)
Message-ID: <3dc5ac616a3c2bfc48b8b3dfa1213532610b6431.camel@perches.com>
Subject: Re: [PATCH v3] staging: rts5208: Fix checkpath warning
From:   Joe Perches <joe@perches.com>
To:     P SAI PRASANTH <saip2823@gmail.com>, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 19:58:09 -0700
In-Reply-To: <20190831022515.GA4917@dell-inspiron>
References: <20190831022515.GA4917@dell-inspiron>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-31 at 07:55 +0530, P SAI PRASANTH wrote:
> This patch fixes the following checkpath warning
> in the file drivers/staging/rts5208/rtsx_transport.c:546
> 
> WARNING: line over 80 characters
> +                               option = RTSX_SG_VALID | RTSX_SG_END |
> RTSX_SG_TRANS_DATA;
[]
> diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
[]
> @@ -540,11 +540,10 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
>  
>  			dev_dbg(rtsx_dev(chip), "DMA addr: 0x%x, Len: 0x%x\n",
>  				(unsigned int)addr, len);
> -
> +

This same line delete then insert the same blank line
is very unusual.

What did you use to create this patch?

> +			option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
>  			if (j == (sg_cnt - 1))
> -				option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
> -			else
> -				option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
> +				option |= RTSX_SG_END;
>  
>  			rtsx_add_sg_tbl(chip, (u32)addr, (u32)len, option);
>  

