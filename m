Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D73B141C40
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 06:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgASFdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 00:33:08 -0500
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:47155 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbgASFdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 00:33:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 43A46182251C0;
        Sun, 19 Jan 2020 05:33:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1362:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2691:2828:3138:3139:3140:3141:3142:3351:3622:3867:3868:3872:3873:4321:4605:5007:6119:10004:10400:10848:11026:11232:11657:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:14659:14721:21080:21365:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wheel05_8f543acaa5616
X-Filterd-Recvd-Size: 1631
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 19 Jan 2020 05:33:04 +0000 (UTC)
Message-ID: <b1437d2f1543e73a20250342a764185772167658.camel@perches.com>
Subject: Re: [PATCH 3/3] Staging: comedi: usbdux: cleanup long line and
 align it
From:   Joe Perches <joe@perches.com>
To:     Simon Fong <simon.fongnt@gmail.com>, abbotti@mev.co.uk
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        colin.king@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 18 Jan 2020 21:32:06 -0800
In-Reply-To: <20200119035243.7819-1-simon.fongnt@gmail.com>
References: <20200119035243.7819-1-simon.fongnt@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-01-19 at 11:52 +0800, Simon Fong wrote:
> Clean up long line and align it
[]
> diff --git a/drivers/staging/comedi/drivers/usbdux.c b/drivers/staging/comedi/drivers/usbdux.c
[]
> @@ -204,7 +204,8 @@ struct usbdux_private {
>  	struct mutex mut;
>  };
>  
> -static void usbdux_unlink_urbs(struct urb **urbs, int num_urbs)

Why do you believe this to be a long line?
It's only 63 characters.

         1         2         3         4         5         6         7
1234567890123456789012345678901234567890123456789012345678901234567890

static void usbdux_unlink_urbs(struct urb **urbs, int num_urbs)

> +static void usbdux_unlink_urbs(struct urb **urbs,
> +			       int num_urbs)
>  {
>  	int i;
>   

