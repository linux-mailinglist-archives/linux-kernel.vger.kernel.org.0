Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962CFA19E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 14:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfH2MSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 08:18:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49974 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfH2MSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:18:32 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i3JNc-0002a6-LD; Thu, 29 Aug 2019 14:18:21 +0200
Date:   Thu, 29 Aug 2019 14:18:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rob Bradford <robert.bradford@intel.com>
cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Rik van Riel <riel@surriel.com>,
        Juergen Gross <jgross@suse.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] x86/reboot: Avoid EFI reboot when not running on EFI
In-Reply-To: <20190829101119.7345-1-robert.bradford@intel.com>
Message-ID: <alpine.DEB.2.21.1908291416560.1938@nanos.tec.linutronix.de>
References: <20190829101119.7345-1-robert.bradford@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019, Rob Bradford wrote:

CC+ Ard

> Replace the check using efi_runtime_disabled() which only checks if EFI
> runtime was disabled on the kernel command line with a call to
> efi_enabled(EFI_RUNTIME_SERVICES) to check if EFI runtime services are
> available.
> 
> In the situation where the kernel was booted without an EFI environment
> then only efi_enabled(EFI_RUNTIME_SERVICES) correctly represents that no
> EFI is available. Setting "noefi" or "efi=noruntime" on the commandline
> continue to have the same effect as efi_enabled(EFI_RUNTIME_SERVICES)
> will return false.
>
>
> Signed-off-by: Rob Bradford <robert.bradford@intel.com>
> ---
>  arch/x86/kernel/reboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 09d6bded3c1e..0b0a7fccdb00 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -500,7 +500,7 @@ static int __init reboot_init(void)
>  	 */
>  	rv = dmi_check_system(reboot_dmi_table);
>  
> -	if (!rv && efi_reboot_required() && !efi_runtime_disabled())
> +	if (!rv && efi_reboot_required() && efi_enabled(EFI_RUNTIME_SERVICES))

Why is efi_reboot_required() set at all in that situation?

Thanks,

	tglx


