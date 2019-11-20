Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B364104404
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 20:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfKTTN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 14:13:27 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:33951 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfKTTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:13:25 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iXVPd-00028t-QK; Wed, 20 Nov 2019 19:13:14 +0000
Message-ID: <fdcb510863c801f1f64448e558ee0f8ed20db418.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 3/8] powerpc: fix vdso32 for ppc64le
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Nov 2019 19:13:12 +0000
In-Reply-To: <20191108203435.112759-4-arnd@arndb.de>
References: <20191108203435.112759-1-arnd@arndb.de>
         <20191108203435.112759-4-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-08 at 21:34 +0100, Arnd Bergmann wrote:
> On little-endian 32-bit application running on 64-bit kernels,
> the current vdso would read the wrong half of the xtime seconds
> field. Change it to return the lower half like it does on
> big-endian.

ppc64le doesn't have 32-bit compat so this is only theoretical.

Ben.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/kernel/vdso32/gettimeofday.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
> index becd9f8767ed..4327665ad86f 100644
> --- a/arch/powerpc/kernel/vdso32/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
> @@ -13,7 +13,7 @@
>  #include <asm/unistd.h>
>  
>  /* Offset for the low 32-bit part of a field of long type */
> -#ifdef CONFIG_PPC64
> +#if defined(CONFIG_PPC64) && defined(CONFIG_CPU_BIG_ENDIAN)
>  #define LOPART	4
>  #define TSPEC_TV_SEC	TSPC64_TV_SEC+LOPART
>  #else
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

