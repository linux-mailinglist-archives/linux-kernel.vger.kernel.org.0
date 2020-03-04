Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B0D179B44
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 22:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbgCDVtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 16:49:49 -0500
Received: from baldur.buserror.net ([165.227.176.147]:34440 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388312AbgCDVts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:49:48 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1j9btL-0000ZP-0c; Wed, 04 Mar 2020 15:49:24 -0600
Message-ID: <feda5c76f134b415d2f43b99b8d6880b9b4b1750.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        christophe.leroy@c-s.fr, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com, keescook@chromium.org,
        kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, zhaohongjiang@huawei.com
Date:   Wed, 04 Mar 2020 15:49:21 -0600
In-Reply-To: <20200206025825.22934-5-yanaijie@huawei.com>
References: <20200206025825.22934-1-yanaijie@huawei.com>
         <20200206025825.22934-5-yanaijie@huawei.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: yanaijie@huawei.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com, christophe.leroy@c-s.fr, benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com, keescook@chromium.org, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org, zhaohongjiang@huawei.com
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
Subject: Re: [PATCH v3 4/6] powerpc/fsl_booke/64: do not clear the BSS for
 the second pass
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-06 at 10:58 +0800, Jason Yan wrote:
> The BSS section has already cleared out in the first pass. No need to
> clear it again. This can save some time when booting with KASLR
> enabled.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  arch/powerpc/kernel/head_64.S | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 744624140fb8..8c644e7c3eaf 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -914,6 +914,13 @@ start_here_multiplatform:
>  	bl      relative_toc
>  	tovirt(r2,r2)
>  
> +	/* Do not clear the BSS for the second pass if randomized */
> +	LOAD_REG_ADDR(r3, kernstart_virt_addr)
> +	lwz     r3,0(r3)
> +	LOAD_REG_IMMEDIATE(r4, KERNELBASE)
> +	cmpw	r3,r4
> +	bne	4f

These are 64-bit values.

-Scott


