Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 784AB860AD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 13:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbfHHLPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 07:15:48 -0400
Received: from smtprelay0013.hostedemail.com ([216.40.44.13]:48563 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730678AbfHHLPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:15:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 417878368EF7;
        Thu,  8 Aug 2019 11:15:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3870:3872:3873:3874:4321:4605:5007:8531:9010:10004:10400:10848:11232:11658:11914:12043:12296:12297:12555:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30046:30054:30056:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: death23_8991f6175b80f
X-Filterd-Recvd-Size: 2184
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Aug 2019 11:15:45 +0000 (UTC)
Message-ID: <92ed89b0346a54fb06d3e08585a8d0b4175842f0.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: mark wusbcore and UWB as obsolete
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Date:   Thu, 08 Aug 2019 04:15:44 -0700
In-Reply-To: <20190808094158.GA22635@kroah.com>
References: <20190806101509.GA11280@kroah.com>
         <b73f09c944625a40b2589e9bac7f8bd22a711ed3.camel@perches.com>
         <20190806113501.GA18443@kroah.com> <20190808092509.GA20173@kroah.com>
         <20190808094158.GA22635@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-08 at 11:41 +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 08, 2019 at 11:25:09AM +0200, Greg Kroah-Hartman wrote:
> > Joe rightly points out that we should be using the "Obsolete" status for
> > these two subsystems.
> 
> Even with that change, I don't see get_maintainers.pl tell me I
> shouldn't be sending a patch in for this area:

Nor should you.  It's checkpatch that should warn.

> 
> 
> $ cat x.patch
> diff --git a/drivers/staging/uwb/Kconfig b/drivers/staging/uwb/Kconfig
> index 259e053e1e09..d9658c46686e 100644
> --- a/drivers/staging/uwb/Kconfig
> +++ b/drivers/staging/uwb/Kconfig
> @@ -3,6 +3,8 @@
>  # UWB device configuration
>  #
> 
> +
> +
>  menuconfig UWB
>         tristate "Ultra Wideband devices"
>         default n
> $ ./scripts/get_maintainer.pl x.patch
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:STAGING SUBSYSTEM,commit_signer:2/2=100%,authored:1/2=50%)
> Thomas Gleixner <tglx@linutronix.de> (commit_signer:1/2=50%,authored:1/2=50%)
> devel@driverdev.osuosl.org (open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:)
> linux-kernel@vger.kernel.org (open list)
> 
> 
> Am I missing something?


