Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C65016531B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 10:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfGKI0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 04:26:50 -0400
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:40729 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbfGKI0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:26:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9D6DB100E86C8;
        Thu, 11 Jul 2019 08:26:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3867:3868:3870:4321:5007:7875:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: suit25_5871eab84d660
X-Filterd-Recvd-Size: 1586
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jul 2019 08:26:47 +0000 (UTC)
Message-ID: <acf9141ed9e4c33585a9784d14a6b95ec58558c8.camel@perches.com>
Subject: Re: [PATCH v2] gnss: core: added logging statement when kfifo_alloc
 fails
From:   Joe Perches <joe@perches.com>
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Date:   Thu, 11 Jul 2019 01:26:46 -0700
In-Reply-To: <20190709235957.2481-1-iamkeyur96@gmail.com>
References: <61c2ba4e229a6971e90627433bedae2dd28ea6a1.camel@perches.com>
         <20190709235957.2481-1-iamkeyur96@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-09 at 19:59 -0400, Keyur Patel wrote:
> Added missing logging statement when kfifo_alloc fails, to improve
> debugging.
[]
> Changes in v2:
> - fixed braces
[]
> diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
[]
> @@ -255,8 +255,10 @@ struct gnss_device *gnss_allocate_device(struct device *parent)
>  	init_waitqueue_head(&gdev->read_queue);
>  
>  	ret = kfifo_alloc(&gdev->read_fifo, GNSS_READ_FIFO_SIZE, GFP_KERNEL);
> -	if (ret)
> +	if (ret) {
> +		pr_err("kfifo_alloc failed\n");
>  		goto err_put_device;
> +	}

This isn't really necessary as kfifo_alloc just
calls kmalloc_array and without the __GFP_NOWARN
flag, already does a dump_stack()


