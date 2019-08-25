Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963B29C664
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 00:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfHYWNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 18:13:13 -0400
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:34111 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728931AbfHYWNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 18:13:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 89B4818224D78;
        Sun, 25 Aug 2019 22:13:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3874:4321:5007:10004:10400:10848:11026:11232:11658:11914:12297:12740:12895:13069:13311:13357:13439:13894:13972:14659:14721:21080:21433:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: lock65_1bc21af378138
X-Filterd-Recvd-Size: 1900
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 25 Aug 2019 22:13:10 +0000 (UTC)
Message-ID: <98427b15d2a5cc93c72867bb7800df6c38f1f7bf.camel@perches.com>
Subject: Re: [PATCH] cdrom: make debug logging rely on pr_debug and debugfs
 only.
From:   Joe Perches <joe@perches.com>
To:     Diego Elio =?ISO-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 25 Aug 2019 15:13:09 -0700
In-Reply-To: <20190825215833.25817-1-flameeyes@flameeyes.com>
References: <20190825215833.25817-1-flameeyes@flameeyes.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-08-25 at 22:58 +0100, Diego Elio Pettenò wrote:
> The cdrom driver predates debugfs and most of the modern debugging
> facilities, so instead it has been includings a module parameter and an
> ioctl to enable debug messages.
> 
> In 2019, debugfs and dynamic debug makes most of that redundant, and even
> confusing when trying to trace things in the dept of the driver.
[]
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
[]
> @@ -591,7 +556,7 @@ int register_cdrom(struct cdrom_device_info *cdi)
>  	static char banner_printed;
>  	const struct cdrom_device_ops *cdo = cdi->ops;
>  
> -	cd_dbg(CD_OPEN, "entering register_cdrom\n");
> +	pr_debug("entering register_cdrom\n");

debut output for function tracing can also be removed
and ftrace used instead.

> @@ -643,7 +608,7 @@ int register_cdrom(struct cdrom_device_info *cdi)
>  
>  void unregister_cdrom(struct cdrom_device_info *cdi)
>  {
> -	cd_dbg(CD_OPEN, "entering unregister_cdrom\n");
> +	pr_debug("entering unregister_cdrom\n");

etc...


