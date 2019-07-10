Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6AF63FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 05:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfGJDkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 23:40:52 -0400
Received: from smtprelay0042.hostedemail.com ([216.40.44.42]:48678 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725880AbfGJDkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 23:40:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C7D05837F24D;
        Wed, 10 Jul 2019 03:40:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2689:2693:2828:3138:3139:3140:3141:3142:3622:3867:3871:3873:4321:5007:10004:10400:10848:11026:11232:11473:11658:11914:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: bears20_749b75478f19
X-Filterd-Recvd-Size: 1410
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 03:40:49 +0000 (UTC)
Message-ID: <61c2ba4e229a6971e90627433bedae2dd28ea6a1.camel@perches.com>
Subject: Re: [PATCH] gnss: core: added logging statement when kfifo_alloc
 fails
From:   Joe Perches <joe@perches.com>
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jul 2019 20:40:48 -0700
In-Reply-To: <20190709231448.30799-1-iamkeyur96@gmail.com>
References: <20190709231448.30799-1-iamkeyur96@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-09 at 19:14 -0400, Keyur Patel wrote:
> Added missing logging statement when kfifo_alloc fails, to improve
> debugging.\

Nack

> diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
[]
> @@ -256,6 +256,7 @@ struct gnss_device *gnss_allocate_device(struct device *parent)
>  
>  	ret = kfifo_alloc(&gdev->read_fifo, GNSS_READ_FIFO_SIZE, GFP_KERNEL);
>  	if (ret)
> +		pr_err("kfifo_alloc failed\n");
>  		goto err_put_device;

c is not python.
This will not do what you might expect.
 
>  	gdev->write_buf = kzalloc(GNSS_WRITE_BUF_SIZE, GFP_KERNEL);

