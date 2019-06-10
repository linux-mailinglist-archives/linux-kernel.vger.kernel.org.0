Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 221EB3BC51
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 21:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388920AbfFJS7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 14:59:53 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:42730 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388544AbfFJS7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:59:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A2533181D33FB;
        Mon, 10 Jun 2019 18:59:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3867:3868:3870:3873:3874:4321:4641:5007:6119:7809:10004:10400:10848:11232:11658:11914:12043:12048:12555:12740:12760:12895:13019:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: beef60_1ba01763c0b04
X-Filterd-Recvd-Size: 1885
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Jun 2019 18:59:49 +0000 (UTC)
Message-ID: <4491ae98b10f4519874141eb39cd2f0b5491b3a5.camel@perches.com>
Subject: Re: [PATCH V5 11/11] MAINTAINERS: add maintainer for SD-FEC
From:   Joe Perches <joe@perches.com>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Date:   Mon, 10 Jun 2019 11:59:48 -0700
In-Reply-To: <1560038656-380620-12-git-send-email-dragan.cvetic@xilinx.com>
References: <1560038656-380620-1-git-send-email-dragan.cvetic@xilinx.com>
         <1560038656-380620-12-git-send-email-dragan.cvetic@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-09 at 01:04 +0100, Dragan Cvetic wrote:
> Add maintainer entry for Xilinx SD-FEC driver support.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -17345,6 +17345,17 @@ S:	Supported
>  F:	Documentation/filesystems/xfs.txt
>  F:	fs/xfs/
>  
> +XILINX SD-FEC IP CORES
> +M:	Derek Kiernan <derek.kiernan@xilinx.com>
> +M:	Dragan Cvetic <dragan.cvetic@xilinx.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> +F:	Documentation/misc-devices/xilinx_sdfec.rst
> +F:	drivers/misc/xilinx_sdfec.c
> +F:	drivers/misc/Kconfig
> +F:	drivers/misc/Makefile

I suggest that you do not want to be nor are responsible
for the Kconfig and Makefile just because entries in
those files are associated to xilinx files.



