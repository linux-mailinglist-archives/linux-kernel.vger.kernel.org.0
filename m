Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D9017566C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 09:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgCBI7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 03:59:06 -0500
Received: from baldur.buserror.net ([165.227.176.147]:56988 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgCBI7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:59:05 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1j8gub-0001rk-M0; Mon, 02 Mar 2020 02:58:54 -0600
Message-ID: <2a7cf26aa11adf43ec4f29ab733afc695039633c.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     =?UTF-8?Q?=E7=8E=8B=E6=96=87=E8=99=8E?= <wenhu.wang@vivo.com>
Cc:     wangwenhu <wenhu.pku@gmail.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Rai Harninder <harninder.rai@nxp.com>
Date:   Mon, 02 Mar 2020 02:58:52 -0600
In-Reply-To: <AKMA9QAgCCx9CEivazbGIap-.3.1583124159966.Hmail.wenhu.wang@vivo.com>
References: <AKMA9QAgCCx9CEivazbGIap-.3.1583124159966.Hmail.wenhu.wang@vivo.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: wenhu.wang@vivo.com, wenhu.pku@gmail.com, galak@kernel.crashing.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, trivial@kernel.org, harninder.rai@nxp.com
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on baldur.localdomain
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  -15 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -1.5 GREYLIST_ISWHITE The incoming server has been whitelisted for
        *      this recipient and sender
Subject: Re: [PATCH] powerpc/Kconfig: Make FSL_85XX_CACHE_SRAM configurable
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-02 at 12:42 +0800, 王文虎 wrote:
> 发件人：Scott Wood <oss@buserror.net>
> 发送日期：2020-03-01 07:12:58
> 收件人："王文虎" <wenhu.wang@vivo.com>
> 抄送人：wangwenhu <wenhu.pku@gmail.com>,Kumar Gala <galak@kernel.crashing.org>,B
> enjamin Herrenschmidt <benh@kernel.crashing.org>,Paul Mackerras <
> paulus@samba.org>,Michael Ellerman <mpe@ellerman.id.au>,
> linuxppc-dev@lists.ozlabs.org,linux-kernel@vger.kernel.org,
> trivial@kernel.org,Rai Harninder <harninder.rai@nxp.com>
> 主题：Re: Re: [PATCH] powerpc/Kconfig: Make FSL_85XX_CACHE_SRAM configurable>On
> Tue, 2020-01-21 at 14:38 +0800, 王文虎 wrote:
> > > 发件人：Scott Wood <oss@buserror.net>
> > > 发送日期：2020-01-21 13:49:59
> > > 收件人："王文虎" <wenhu.wang@vivo.com>
> > > 抄送人：wangwenhu <wenhu.pku@gmail.com>,Kumar Gala <
> > > galak@kernel.crashing.org>,B
> > > enjamin Herrenschmidt <benh@kernel.crashing.org>,Paul Mackerras <
> > > paulus@samba.org>,Michael Ellerman <mpe@ellerman.id.au>,
> > > linuxppc-dev@lists.ozlabs.org,linux-kernel@vger.kernel.org,
> > > trivial@kernel.org,Rai Harninder <harninder.rai@nxp.com>
> > > 主题：Re: [PATCH] powerpc/Kconfig: Make FSL_85XX_CACHE_SRAM configurable>On
> > > Tue, 2020-01-21 at 13:20 +0800, 王文虎 wrote:
> > > > > From: Scott Wood <oss@buserror.net>
> > > > > Date: 2020-01-21 11:25:25
> > > > > To:  wangwenhu <wenhu.pku@gmail.com>,Kumar Gala <
> > > > > galak@kernel.crashing.org>,
> > > > > Benjamin Herrenschmidt <benh@kernel.crashing.org>,Paul Mackerras <
> > > > > paulus@samba.org>,Michael Ellerman <mpe@ellerman.id.au>,
> > > > > linuxppc-dev@lists.ozlabs.org,linux-kernel@vger.kernel.org
> > > > > Cc:  trivial@kernel.org,wenhu.wang@vivo.com,Rai Harninder <
> > > > > harninder.rai@nxp.com>
> > > > > Subject: Re: [PATCH] powerpc/Kconfig: Make FSL_85XX_CACHE_SRAM
> > > > > configurable>On Mon, 2020-01-20 at 06:43 -0800, wangwenhu wrote:
> > > > > > > From: wangwenhu <wenhu.wang@vivo.com>
> > > > > > > 
> > > > > > > When generating .config file with menuconfig on Freescale BOOKE
> > > > > > > SOC, FSL_85XX_CACHE_SRAM is not configurable for the lack of
> > > > > > > description in the Kconfig field, which makes it impossible
> > > > > > > to support L2Cache-Sram driver. Add a description to make it
> > > > > > > configurable.
> > > > > > > 
> > > > > > > Signed-off-by: wangwenhu <wenhu.wang@vivo.com>
> > > > > > 
> > > > > > The intent was that drivers using the SRAM API would select the
> > > > > > symbol.  What
> > > > > > is the use case for selecting it manually?
> > > > > > 
> > > > > 
> > > > > With a repository of multiple products(meaning different defconfigs)
> > > > > and
> > > > > multiple
> > > > > developers, the Kconfigs of the Kernel Source Tree change
> > > > > frequently. So
> > > > > the
> > > > > "make menuconfig"
> > > > > process is needed for defconfigs' re-generating or updating for the
> > > > > complexity of dependencies
> > > > > between different features defined in the Kconfigs.
> > > > 
> > > > That doesn't answer my question of how the SRAM code would be useful
> > > > other
> > > > than to some other driver that uses the API (which would use
> > > > "select").  There
> > > > is no userspace API.  You could use the kernel command line to
> > > > configure
> > > > the
> > > > SRAM but you need to get the address of it for it to be useful.
> > > > 
> > > 
> > > Like you've asked below, via /dev/mem or direct calling within the
> > > Kernel.
> > > And they are not submitted yes, under development.
> > 
> > If they are calling within the kernel, then whatever driver that is should
> > select FSL_85XX_CACHE_SRAM.  Directly accessing /dev/mem without any way
> > for
> > the kernel to advertise where it is or which parts of SRAM are available
> > for
> > use sounds like a bad idea.
> > 
> 
> Yes, definitely. So like we enable the moulde which should selet 
> FSL_85XX_CACHE_SRAM to build vmlinux, FSL_85XX_CACHE_SRAM 
> could not be seleted because of the Kconfig definition problem 
> which I am trying to fix now.  So would you please merge the patch 
> for the convenience of later works depending on the driver.

Sorry, I don't think it's something that should be enabled by itself with
nothing using the allocators.  Suppose we took this patch, and people enabled
it and accessed it via /dev/mem.  Then suppose a driver is patched to allocate
some sram and use it.  They'd be stepping on each others' toes undetected.

If you want to expose it to userspace, add code that allocates some or all of
the sram and make it something userspace can mmap.  Or, if nothing's going to
use them, remove the allocators and export the entire thing to userspace
(again via an sram-specific mappable rather than /dev/mem).

-Scott


