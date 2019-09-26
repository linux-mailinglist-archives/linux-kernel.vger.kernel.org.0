Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22339BF5EB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 17:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfIZPaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 11:30:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36643 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfIZPaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:30:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so3074929wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFAacK0EhR9tL7dcOk2a8c9iricrpxhApMfaN2C5N7s=;
        b=XVVCfPIxAZqZ22Bx/9V4/Go1RYTasCm+AJOhH/F9Yo0dFhM1g4VfPuSLR5w/IQnJZM
         4LVGFcYz570jzuJyXc909gfLBy6guLdK3itKxTSEhchbHIIzIFsqajnUcgkIsUTe6Xap
         3bYUSgguZduA6Hxn+GV+VyC9gozXrAYyUVEPZ+fkkLORg6qKbTe4yNXHyvswXGCgX/qk
         IuCL/sg3I3wq3Zj2guPxS3iFRtodHnEkzi9RNJm0gb4OabL0cxgNmXucTkZ4UVCodZyo
         H+d6jPrYa2tEQWbsQsyY/oRIzsMK4q8XAPFXjDjdW4NXy6HzLVQVW0fCoZHHyMFP9lYZ
         LyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFAacK0EhR9tL7dcOk2a8c9iricrpxhApMfaN2C5N7s=;
        b=EDo6JREDne/rCfA6MdP7rTZgCbEHJ7xeXbLKYjTGn5XKSDoEgfRKgjFiypC+rlexUr
         WlOdUGBkkaUlf7gMT+QdszjP1hhesu4ZoyuT3vVkl1MEjtGt4ZV3Sr8nN0Tvsqgp0RAD
         K7jZs65RRKxSYg9/f10sphdTDTAN5nkQw3E8u6+PLErDkRGaAd1zbYsswZhT1Czrs4dq
         feBPP3dfTJerjONVRXZv6sTJTVcpfSjYhjs5quYRoW3LcLucXlc4b5vjED31sp2fTRgl
         r4hH9ZCfi58k74ATz24AXbYFJrBMk1xr9pMmWKsrTDdTLSLtvRbb1bMEP3lVqVW35sNS
         TRng==
X-Gm-Message-State: APjAAAU+FZqyTHXYuoSZ89jAnnKmS+ywhXRBDNJL67edYA2IodYYQ9xB
        LxZ2O/g4f1Q+urrRAkd85rZymQCIgQesNNVSrHy+1g==
X-Google-Smtp-Source: APXvYqwd6FHlsVpd/E2Nfy+NyT7gAgDhiSMqnCGiPIpSFfRox2UVCmMxh+98XvIQF5njyIdOSSaJpTYzW47u+NHxSL0=
X-Received: by 2002:a7b:c451:: with SMTP id l17mr3180348wmi.61.1569511808620;
 Thu, 26 Sep 2019 08:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190926141234.8271-1-ross.lagerwall@citrix.com>
In-Reply-To: <20190926141234.8271-1-ross.lagerwall@citrix.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 26 Sep 2019 17:29:57 +0200
Message-ID: <CAKv+Gu8ok=v6WaKWW1AmhPgf1-n7p=4h8Tkno9YNW6H8p4fg8w@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Don't require non-blocking EFI callbacks
To:     Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2019 at 16:12, Ross Lagerwall <ross.lagerwall@citrix.com> wrote:
>
> If a backend does not implement non-blocking EFI operations, it implies
> that the normal operations are non-blocking.

Is that documented anywhere?

> Instead of crashing
> dereferencing a NULL pointer, fallback to the normal operations since it
> is safe to do so.
>

I agree that crashing is never the right thing to do, but I wonder
whether we shouldn't just bail instead. If the provided default
operation is non-blocking, the platform can populate the function
pointer with a reference to the default implementation.


> Fixes: 5a58bc1b1edc ("efi/x86: Use non-blocking SetVariable() for efi_delete_dummy_variable()")
> Fixes: ca0e30dcaa53 ("efi: Add nonblocking option to efi_query_variable_store()")
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>  arch/x86/platform/efi/quirks.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 3b9fd679cea9..4167f5e8f3e8 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -106,11 +106,13 @@ early_param("efi_no_storage_paranoia", setup_storage_paranoia);
>  */
>  void efi_delete_dummy_variable(void)
>  {
> -       efi.set_variable_nonblocking((efi_char16_t *)efi_dummy_name,
> -                                    &EFI_DUMMY_GUID,
> -                                    EFI_VARIABLE_NON_VOLATILE |
> -                                    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                    EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
> +       efi_set_variable_t *set_variable = efi.set_variable_nonblocking ?:
> +                                          efi.set_variable;
> +
> +       set_variable((efi_char16_t *)efi_dummy_name, &EFI_DUMMY_GUID,
> +                    EFI_VARIABLE_NON_VOLATILE |
> +                    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                    EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
>  }
>
>  /*
> @@ -127,10 +129,12 @@ query_variable_store_nonblocking(u32 attributes, unsigned long size)
>  {
>         efi_status_t status;
>         u64 storage_size, remaining_size, max_size;
> +       efi_query_variable_info_t *query_variable_info =
> +               efi.query_variable_info_nonblocking ?:
> +               efi.query_variable_info;
>
> -       status = efi.query_variable_info_nonblocking(attributes, &storage_size,
> -                                                    &remaining_size,
> -                                                    &max_size);
> +       status = query_variable_info(attributes, &storage_size,
> +                                    &remaining_size, &max_size);
>         if (status != EFI_SUCCESS)
>                 return status;
>
> --
> 2.21.0
>
