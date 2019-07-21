Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6627D6F484
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 20:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfGUSEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 14:04:10 -0400
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:46445 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbfGUSEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 14:04:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8D5AC18029122;
        Sun, 21 Jul 2019 18:04:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3867:4321:5007:6642:7514:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12295:12297:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: care78_23d5a97d6b148
X-Filterd-Recvd-Size: 1889
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun, 21 Jul 2019 18:04:06 +0000 (UTC)
Message-ID: <4154c43331e4d1d361db41194587d3d41cf991b0.camel@perches.com>
Subject: Re: [PATCH] slimbus: fix duplicated argument to ||
From:   Joe Perches <joe@perches.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Sun, 21 Jul 2019 11:04:04 -0700
In-Reply-To: <20190721174715.GA10747@hari-Inspiron-1545>
References: <20190721174715.GA10747@hari-Inspiron-1545>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-07-21 at 23:17 +0530, Hariprasad Kelam wrote:
> Remove duplicate argument SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION.
> 
> fix below issue reported by coccicheck
> ./drivers/slimbus/slimbus.h:440:3-46: duplicated argument to && or ||
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/slimbus/slimbus.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
> index 9be4108..46a6441 100644
> --- a/drivers/slimbus/slimbus.h
> +++ b/drivers/slimbus/slimbus.h
> @@ -438,8 +438,7 @@ static inline bool slim_tid_txn(u8 mt, u8 mc)
>  	return (mt == SLIM_MSG_MT_CORE &&
>  		(mc == SLIM_MSG_MC_REQUEST_INFORMATION ||
>  		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION ||
> -		 mc == SLIM_MSG_MC_REQUEST_VALUE ||
> -		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION));
> +		 mc == SLIM_MSG_MC_REQUEST_VALUE));
>  }

Perhaps this was intended to be
		mc ==  SLIM_MSG_MC_REQUEST_CHANGE_VALUE ?


