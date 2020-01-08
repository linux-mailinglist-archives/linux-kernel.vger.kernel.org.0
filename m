Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5FCF134484
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 15:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgAHOEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 09:04:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45414 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgAHOEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:04:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so3437015wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03ZZgrfPnlkzJOCPCuPI2OwL5hhKIYzrgORdTh/AQQQ=;
        b=RAlYwQngU5ReSTTuJCCgB0RIAcBw4FPN0oB43AEzMOWiCzagQrcsSwi71v7HM5awI2
         P1vorIJoujEz3W8rHzFltQfSjSo4Y/nm/ELB7syJM/3b4cfYES/F9FRqdWwhf6Y8bK2H
         3woVzKsNYAgXndTGCDItMhE/GNiSQPlLiPcpM6Em937sRsaLoICEQJHd85W2tQpmX+4R
         kOcOCyKnDfV2rkhWXZXkCUgIYlD7wBPDkZe997cN1VZqbFbVuuoRI6S14aQryU82V5OQ
         qDC6NybJFiQKT0dH5HJilZgl2xcdWv2iaQezOzrMYbSbf+aPqngfKGkeQgAQyTTDTTj0
         8H2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03ZZgrfPnlkzJOCPCuPI2OwL5hhKIYzrgORdTh/AQQQ=;
        b=baYDTdJ9JTU0InKv73Um4ne5qPv/mHg0/uUdTITndVWTTDyMIiXPrDsGXWkYGyDQ8k
         ljww65U2sI0oWtFSlcDk9dCsV0bDT+bTWXBZ3lAfjgegVeSF+e6qr+1jl7APDlOzD+Fu
         WcEA/IPQHPAYEK9PE6noHeQ5wlqmrJDwLTTh8z+hpwE45H8RMYQKIq7PRbbmKBpC/sWE
         XVCF8Yy2NJgc4oLtS6JTzruZEtxF5nW44W+rKFYothOZ6tTCeBHHMrFnBClOQezrD5SA
         r+L6NqFwZXYfoHsFPcs50DN3QB5Ep1qiJzS44kOiSoOjKIaG0VTerhCEEnoVIx5HvynI
         j6sQ==
X-Gm-Message-State: APjAAAUG3T8gI3DyYZlqqjfQ9wffpbKK7TfN+Ehzebff+eWTOzqirrlg
        eoZFcN9zymH+zHjl3PcoEDxgbUq0IX/zLuOS84QdJw==
X-Google-Smtp-Source: APXvYqxr6kgaBU11F4QE0S0IfOokn8oPdPXNm7jS0ZS0lltHMAic115dHc+sCND+AAuXQZuTXt6Xpcm0NtaKnohnL9I=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr4561282wrj.325.1578492275313;
 Wed, 08 Jan 2020 06:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20200108135350.3861390-1-arnd@arndb.de>
In-Reply-To: <20200108135350.3861390-1-arnd@arndb.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 8 Jan 2020 15:04:23 +0100
Message-ID: <CAKv+Gu_DU_4uc+GTcdiEtLD-i48x_Rv2Y-W_NGk62yKxsAUqLQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: x86: fix unused-variable warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        James Morse <james.morse@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Enrico Weigelt <info@metux.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2020 at 14:54, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The only users of these got removed, so they also need to be
> removed to avoid warnings:
>
> arch/x86/boot/compressed/eboot.c: In function 'setup_efi_pci':
> arch/x86/boot/compressed/eboot.c:117:16: error: unused variable 'nr_pci' [-Werror=unused-variable]
>   unsigned long nr_pci;
>                 ^~~~~~
> arch/x86/boot/compressed/eboot.c: In function 'setup_uga':
> arch/x86/boot/compressed/eboot.c:244:16: error: unused variable 'nr_ugas' [-Werror=unused-variable]
>   unsigned long nr_ugas;
>                 ^~~~~~~
>
> Fixes: 2732ea0d5c0a ("efi/libstub: Use a helper to iterate over a EFI handle array")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Oops

Acked-by: Ard Biesheuvel <ardb@kernel.org>

or I can add it to my next batch of EFI changes at the end of the week.

> ---
>  arch/x86/boot/compressed/eboot.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index da04948d75ed..57dfdc53d714 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -114,7 +114,6 @@ static void setup_efi_pci(struct boot_params *params)
>         void **pci_handle = NULL;
>         efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
>         unsigned long size = 0;
> -       unsigned long nr_pci;
>         struct setup_data *data;
>         efi_handle_t h;
>         int i;
> @@ -241,7 +240,6 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
>         u32 width, height;
>         void **uga_handle = NULL;
>         efi_uga_draw_protocol_t *uga = NULL, *first_uga;
> -       unsigned long nr_ugas;
>         efi_handle_t handle;
>         int i;
>
> --
> 2.20.0
>
