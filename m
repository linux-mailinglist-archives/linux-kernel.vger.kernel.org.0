Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B40DE37CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 20:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfFFSy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 14:54:59 -0400
Received: from smtprelay0070.hostedemail.com ([216.40.44.70]:36818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726379AbfFFSy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:54:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7B1741801E326;
        Thu,  6 Jun 2019 18:54:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3743:3865:3866:3867:3870:4321:4433:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12438:12740:12760:12895:13069:13095:13311:13357:13439:14659:14721:21080:21212:21433:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: need53_2b3144507e744
X-Filterd-Recvd-Size: 1559
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Jun 2019 18:54:56 +0000 (UTC)
Message-ID: <4257c916c5db569c6182880e06ddc1230e80ddf0.camel@perches.com>
Subject: Re: [PATCH 1/2] habanalabs: add rate-limit to an error message
From:   Joe Perches <joe@perches.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jun 2019 11:54:55 -0700
In-Reply-To: <20190606122009.12471-1-oded.gabbay@gmail.com>
References: <20190606122009.12471-1-oded.gabbay@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 15:20 +0300, Oded Gabbay wrote:
> This patch changes the print of an error message about mis-configuration
> of the debug infrastructure to be rate-limited, to prevent flooding of
> kernel log, as these configuration requests can come at a high rate.
[]
> diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
[]
> @@ -255,7 +255,7 @@ static int hl_debug_ioctl(struct hl_fpriv *hpriv, void *data)
>  	case HL_DEBUG_OP_SPMU:
>  	case HL_DEBUG_OP_TIMESTAMP:
>  		if (!hdev->in_debug) {
> -			dev_err(hdev->dev,
> +			dev_err_ratelimited(hdev->dev,
>  				"Rejecting debug configuration request because device not in debug mode\n");
>  			return -EFAULT;
>  		}

Perhaps this should be dev_dbg


