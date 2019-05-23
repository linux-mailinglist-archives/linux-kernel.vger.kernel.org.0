Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8C428B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 22:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbfEWUAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 16:00:55 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:43075 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387455AbfEWUAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:00:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 297F1100E86C8;
        Thu, 23 May 2019 20:00:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3866:3872:4321:5007:7514:7875:8957:10004:10400:10848:11232:11658:11914:12043:12555:12679:12740:12760:12895:13018:13019:13069:13161:13229:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30060:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:60,LUA_SUMMARY:none
X-HE-Tag: hole85_5ee488a53b31a
X-Filterd-Recvd-Size: 1650
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 23 May 2019 20:00:51 +0000 (UTC)
Message-ID: <1b741b25b973e049948b3e490c13aad48716d5b0.camel@perches.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Add entry for fieldbus subsystem
From:   Joe Perches <joe@perches.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 23 May 2019 13:00:50 -0700
In-Reply-To: <20190523195313.31008-1-TheSven73@gmail.com>
References: <20190523195313.31008-1-TheSven73@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-23 at 15:53 -0400, Sven Van Asbroeck wrote:
> Add myself as the maintainer of the fieldbus subsystem.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -14905,6 +14905,11 @@ L:	linux-erofs@lists.ozlabs.org
>  S:	Maintained
>  F:	drivers/staging/erofs/
>  
> +STAGING - FIELDBUS SUBSYSTEM
> +M:	Sven Van Asbroeck <TheSven73@gmail.com>
> +S:	Maintained
> +F:	drivers/staging/fieldbus/*

The F: pattern above excludes subdirectories.

What about the drivers/staging/fieldbus/Documentation directory?

patch 2/2 specifically covers the anybuss directory,
but the Documentation directory has no matching pattern.

trivia: anybuss looks like a misspelling.
It might be better as anybus-s.




