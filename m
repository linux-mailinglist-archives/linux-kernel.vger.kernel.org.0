Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F52B459E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 12:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfFNKEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 06:04:24 -0400
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:33379 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbfFNKEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:04:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4A238100E86C6;
        Fri, 14 Jun 2019 10:04:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:3874:4250:4321:5007:6119:10004:10400:10848:11026:11232:11658:11914:12296:12740:12760:12895:13069:13153:13228:13255:13311:13357:13439:13972:14181:14659:14721:21080:21451:21627:30012:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: beast43_6032aa142690d
X-Filterd-Recvd-Size: 2014
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Jun 2019 10:04:20 +0000 (UTC)
Message-ID: <8eacbd27239ec5ce956309278beae9b499499108.camel@perches.com>
Subject: Re: [PATCH] bus: hisi_lpc: Don't use devm_kzalloc() to allocate
 logical PIO range
From:   Joe Perches <joe@perches.com>
To:     John Garry <john.garry@huawei.com>, xuwei5@huawei.com
Cc:     bhelgaas@google.com, linuxarm@huawei.com, arm@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 14 Jun 2019 03:04:19 -0700
In-Reply-To: <1560505624-39955-1-git-send-email-john.garry@huawei.com>
References: <1560505624-39955-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-14 at 17:47 +0800, John Garry wrote:
> If, after registering a logical PIO range, the driver probe later fails,
> the logical PIO range memory will be released automatically.
> 
> This causes an issue, in that the logical PIO range is not unregistered
> (that is not supported) and the released range memory may be later
> referenced
> 
> Allocate the logical PIO range with kzalloc() to avoid this potential
> issue.
> 
> Fixes: adf38bb0b5956 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings")
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
[]
> @@ -599,7 +599,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>  	if (IS_ERR(lpcdev->membase))
>  		return PTR_ERR(lpcdev->membase);
>  
> -	range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
> +	range = kzalloc(sizeof(*range), GFP_KERNEL);

If this is really necessary, it'd be useful to say so in the
code too with a comment so it doesn't get drive-by 'unfixed'
by someone well meaning but ill-uninformed.


