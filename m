Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C817A079
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 08:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgCEHVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 02:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgCEHVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:21:42 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16ACC2073B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Mar 2020 07:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583392901;
        bh=HUqhpqkPwtD1SgCGWyg8TkWqxocPUgCFtxNvGFcrLM0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BvS5CeEWR8hg+rvFq7sVoiQ+4W2bzp+ApQxpB+D+XJDapWIZBnfTPRPMKPsCpLTbS
         GxfEb8eTojWcyrGTfeV53N0Hxt7VqE9mtayKV/D7BEOVdNu+rRE/Whlc91QD0kkgOn
         z4ZM31HzHRtwOqxQHOaQO0vMQg9MsZnbu2chv/Kc=
Received: by mail-wr1-f43.google.com with SMTP id 6so223514wre.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 23:21:41 -0800 (PST)
X-Gm-Message-State: ANhLgQ2EQHwGkP/ki1rbXf+LFiWKF6/6/bNvxxDDZhmYa709gI22SM29
        nrk0odFQIosURSfm1TwqUXH07Hg0bn2GyK3wCBdVfg==
X-Google-Smtp-Source: ADFU+vvfuLeudqOLwTXeiLBbDJRZOudsOWwevSZk8iXl6R9OxpneeAisQmD0eVAGnlo8q20zeBM/k9dCM4ppbTGBGn8=
X-Received: by 2002:a5d:6051:: with SMTP id j17mr8472350wrt.151.1583392899556;
 Wed, 04 Mar 2020 23:21:39 -0800 (PST)
MIME-Version: 1.0
References: <20200305052052.30757-1-masahiroy@kernel.org>
In-Reply-To: <20200305052052.30757-1-masahiroy@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 5 Mar 2020 08:21:29 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu9XSfA5BWBkecb4zjXMxk2rK+rE4Q3Z75v21o7X6_AKEw@mail.gmail.com>
Message-ID: <CAKv+Gu9XSfA5BWBkecb4zjXMxk2rK+rE4Q3Z75v21o7X6_AKEw@mail.gmail.com>
Subject: Re: [PATCH] arm64: efi: add efi-entry.o to targets instead of extra-$(CONFIG_EFI)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Torsten Duwe <duwe@lst.de>, James Morse <james.morse@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 at 06:21, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> efi-entry.o is built on demand for efi-entry.stub.o, so you do not have
> to repeat $(CONFIG_EFI) here. Adding it to 'targets' is enough.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>
>  arch/arm64/kernel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index fc6488660f64..4e5b8ee31442 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -21,7 +21,7 @@ obj-y                 := debug-monitors.o entry.o irq.o fpsimd.o              \
>                            smp.o smp_spin_table.o topology.o smccc-call.o       \
>                            syscall.o
>
> -extra-$(CONFIG_EFI)                    := efi-entry.o
> +targets                        += efi-entry.o
>
>  OBJCOPYFLAGS := --prefix-symbols=__efistub_
>  $(obj)/%.stub.o: $(obj)/%.o FORCE
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
