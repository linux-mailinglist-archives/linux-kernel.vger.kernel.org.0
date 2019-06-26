Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF9956DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 17:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfFZPlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 11:41:37 -0400
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:60525 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726948AbfFZPlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:41:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 000EF181D3402;
        Wed, 26 Jun 2019 15:41:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:1978:1981:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3868:4250:4321:4384:5007:6737:6738:7809:10004:10400:10848:10903:11026:11232:11658:11914:12043:12048:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:21740:30009:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: jar47_64850cc308b59
X-Filterd-Recvd-Size: 2351
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Jun 2019 15:41:30 +0000 (UTC)
Message-ID: <826354a296645f54a98f22129d006d91cfcff284.camel@perches.com>
Subject: Re: [tip:timers/vdso] MAINTAINERS: Add entry for the generic VDSO
 library
From:   Joe Perches <joe@perches.com>
To:     hpa@zytor.com, luto@kernel.org, salyzyn@android.com,
        0x7f454c46@gmail.com, arnd@arndb.de, catalin.marinas@arm.com,
        mingo@kernel.org, avagin@openvz.org, vincenzo.frascino@arm.com,
        torvalds@linux-foundation.org, dima@arista.com, pcc@google.com,
        will.deacon@arm.com, paul.burton@mips.com, mikelley@microsoft.com,
        shuah@kernel.org, sthotton@marvell.com, sashal@kernel.org,
        andre.przywara@arm.com, daniel.lezcano@linaro.org,
        huw@codeweavers.com, ralf@linux-mips.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        tglx@linutronix.de, linux-tip-commits@vger.kernel.org
Date:   Wed, 26 Jun 2019 08:41:29 -0700
In-Reply-To: <tip-e70980312a946a56173843cbc0104b3b0e57a0c7@git.kernel.org>
References: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
         <tip-e70980312a946a56173843cbc0104b3b0e57a0c7@git.kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-26 at 05:36 -0700, tip-bot for Thomas Gleixner wrote:
> MAINTAINERS: Add entry for the generic VDSO library
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -6664,6 +6664,18 @@ L:	kvm@vger.kernel.org
>  S:	Supported
>  F:	drivers/uio/uio_pci_generic.c
>  
> +GENERIC VDSO LIBRARY:
> +M:	Andy Lutomirksi <luto@kernel.org>
> +M:	Thomas Gleixner <tglx@linutronix.de>
> +M:	Vincenzo Frascino <vincenzo.frascino@arm.com>
> +L:	linux-kernel@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
> +S:	Maintained
> +F:	lib/vdso

Please use trailing slashes for directories.

> +F:	kernel/time/vsyscall.c
> +F:	include/vdso

and here.

> +F:	include/asm-generic/vdso/vsyscall.h
> +
>  GENWQE (IBM Generic Workqueue Card)
>  M:	Frank Haverkamp <haver@linux.ibm.com>
>  S:	Supported

