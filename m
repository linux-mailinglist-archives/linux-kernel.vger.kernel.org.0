Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C8AD4C06
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 04:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfJLCHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 22:07:12 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:44011 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727016AbfJLCHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 22:07:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8DE79182CED2A;
        Sat, 12 Oct 2019 02:07:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 80,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:4321:4605:5007:8957:10004:10400:11232:11658:11914:12043:12048:12296:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21451:21627:30003:30054:30091,0,RBL:23.242.70.174:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: bite17_4300371d6934
X-Filterd-Recvd-Size: 2049
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sat, 12 Oct 2019 02:07:08 +0000 (UTC)
Message-ID: <8886b98ca936e7150abf36aa3c9d167073eaba86.camel@perches.com>
Subject: Re: [PATCH] staging: sm750fb: align arguments with open parenthesis
From:   Joe Perches <joe@perches.com>
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Date:   Fri, 11 Oct 2019 19:07:06 -0700
In-Reply-To: <20191012011956.9452-1-gabrielabittencourt00@gmail.com>
References: <20191012011956.9452-1-gabrielabittencourt00@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-11 at 22:19 -0300, Gabriela Bittencourt wrote:
> Cleans up checks of "Alignment should match open parenthesis" in tree sm750fb
[]
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
[]
> @@ -289,7 +289,7 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
>  }
>  
>  int sm750_hw_imageblit(struct lynx_accel *accel,
> -		 const char *pSrcbuf, /* pointer to start of source buffer in system memory */
> +		       const char *pSrcbuf, /* pointer to start of source buffer in system memory */
>  		 u32 srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */

checkpatch only warns on the first unaligned argument, but
all statement lines are meant to align to the open parenthesis.

>  		 u32 startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
>  		 u32 dBase,    /* Address of destination: offset in frame buffer */


