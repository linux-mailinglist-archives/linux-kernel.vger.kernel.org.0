Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9475D56FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfFZRlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 13:41:46 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:43102 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbfFZRlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:41:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id DA62C18038B43;
        Wed, 26 Jun 2019 17:41:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3874:4321:4384:4605:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12295:12296:12297:12438:12740:12895:13069:13255:13311:13357:13439:13894:14659:14721:21080:21627:30012:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:33,LUA_SUMMARY:none
X-HE-Tag: roof68_8382be6ddc757
X-Filterd-Recvd-Size: 2396
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Jun 2019 17:41:43 +0000 (UTC)
Message-ID: <0ecf55be612b2ac5f40045796e54bb1ee758d3e4.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: rts5208: Rewrite redundant if statement to
 improve code style
From:   Joe Perches <joe@perches.com>
To:     Tobias =?ISO-8859-1?Q?Nie=DFen?= 
        <tobias.niessen@stud.uni-hannover.de>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de, Sabrina Gaube <sabrina-gaube@web.de>
Date:   Wed, 26 Jun 2019 10:41:41 -0700
In-Reply-To: <20190626142857.30155-2-tobias.niessen@stud.uni-hannover.de>
References: <20190626142857.30155-1-tobias.niessen@stud.uni-hannover.de>
         <20190626142857.30155-2-tobias.niessen@stud.uni-hannover.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-26 at 16:28 +0200, Tobias Nießen wrote:
> This commit uses the fact that
> 
>     if (a) {
>             if (b) {
>                     ...
>             }
>     }
> 
> can instead be written as
> 
>     if (a && b) {
>             ...
>     }
> 
> without any change in behavior, allowing to decrease the indentation
> of the contained code block and thus reducing the average line length.

unrelated and trivially:

> diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
[]
> @@ -4507,20 +4507,19 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
[]
> +			if (sd_lock_state &&
> +			    (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE)) {
> +				sd_card->sd_lock_status |= (
> +					SD_UNLOCK_POW_ON | SD_SDR_RST);

This could go on a single line like the &= ~() equivalent below.
It hardly matters if it's > 80 chars.

> +				if (CHK_SD(sd_card)) {
> +					retval = reset_sd(chip);
> +					if (retval != STATUS_SUCCESS) {
> +						sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
> +						goto sd_execute_write_cmd_failed;
>  					}
> -
> -					sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
>  				}
> +
> +				sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
>  			}
>  		}
>  	}

