Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089A7102A96
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 18:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfKSRPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 12:15:02 -0500
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:42586 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726985AbfKSRPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:15:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B6DE8182CED2A;
        Tue, 19 Nov 2019 17:15:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3867:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4659:5007:7809:7903:9025:10004:10400:10848:11232:11658:11914:12297:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:14764:21080:21451:21627:21691:30003:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: hose89_65b5758ac5c31
X-Filterd-Recvd-Size: 2134
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Nov 2019 17:14:58 +0000 (UTC)
Message-ID: <64ace55545c028bc39b08370074aafd32e8fc5f5.camel@perches.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Switch to Marvell addresses
From:   Joe Perches <joe@perches.com>
To:     Robert Richter <rrichter@marvell.com>,
        Arnd Bergmann <arnd@arndb.de>, arm soc <arm@kernel.org>
Cc:     Jan Glauber <jglauber@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Nov 2019 09:14:36 -0800
In-Reply-To: <20191119165549.14570-4-rrichter@marvell.com>
References: <20191119165549.14570-1-rrichter@marvell.com>
         <20191119165549.14570-4-rrichter@marvell.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-19 at 16:56 +0000, Robert Richter wrote:
> Switch all addresses from @cavium.com to @marvell.com.
> 
> On that occasion, switching also to my Marvell address for all my
> Cavium/Marvell entries.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -3727,14 +3727,14 @@ S:	Supported
>  F:	drivers/mmc/host/cavium*
>  
>  CAVIUM OCTEON-TX CRYPTO DRIVER
> -M:	George Cherian <george.cherian@cavium.com>
> +M:	George Cherian <gcherian@marvell.com>
>  L:	linux-crypto@vger.kernel.org
>  W:	http://www.cavium.com

Might want to change these W: links too

> @@ -17911,7 +17911,7 @@ S:	Supported
>  F:	drivers/char/xillybus/
>  
>  XLP9XX I2C DRIVER
> -M:	George Cherian <george.cherian@cavium.com>
> +M:	George Cherian <gcherian@marvell.com>
>  L:	linux-i2c@vger.kernel.org
>  W:	http://www.cavium.com

etc...

>  S:	Supported

