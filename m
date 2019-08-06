Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6206A82FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 12:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbfHFK3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 06:29:44 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:57856 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732262AbfHFK3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:29:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 67B4B6121;
        Tue,  6 Aug 2019 10:29:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4250:4321:4559:4605:5007:7809:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13095:13311:13357:13439:14181:14581:14659:14721:21080:21433:21451:21627:30012:30025:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: goat74_37ab30b107b50
X-Filterd-Recvd-Size: 1545
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Aug 2019 10:29:42 +0000 (UTC)
Message-ID: <b73f09c944625a40b2589e9bac7f8bd22a711ed3.camel@perches.com>
Subject: Re: [PATCH] USB: Move wusbcore and UWB to staging as it is obsolete
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Date:   Tue, 06 Aug 2019 03:29:40 -0700
In-Reply-To: <20190806101509.GA11280@kroah.com>
References: <20190806101509.GA11280@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-06 at 12:15 +0200, Greg Kroah-Hartman wrote:
> The UWB and wusbcore code is long obsolete, so let us just move the code
> out of the real part of the kernel and into the drivers/staging/
> location with plans to remove it entirely in a few releases.
[]
>  MAINTAINERS                                   | 15 +++-------
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -3800,14 +3800,9 @@ F:	scripts/sign-file.c
>  F:	scripts/extract-cert.c
>  
>  CERTIFIED WIRELESS USB (WUSB) SUBSYSTEM:
> -L:	linux-usb@vger.kernel.org
> +L:	devel@driverdev.osuosl.org
>  S:	Orphan

Better to mark this as obsolete so checkpatch emits
a message saying "no unnecessary modifications"


