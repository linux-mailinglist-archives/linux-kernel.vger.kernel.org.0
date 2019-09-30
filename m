Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0796AC2040
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 13:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfI3L5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 07:57:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34574 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfI3L5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:57:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so13967298wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 04:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zv5NPFffUTFWq+5VT+kNlcF7WPDHuJF4ydktGZ/WsY=;
        b=gHB7DbQZToFeCjqdQb9B/zhfxNXQtVeZx4efkZ9xl4iyC3EefN0QLg4S7JDcSdfwNE
         73M6UDITA0Cv9adQfTZIcXcE79Y4OeCsROVAVoyJbRv9vEpIDImPA7WxKXs++9aQcFxD
         NEC3RhtXV2/IDtq8BsCZUazqjoBVOBgzJpqpu38PPIZ4mUFiRfF0BAi9TdalNdFEba/7
         Dzn/Z9OcxYuowjqPJDOz4aEK44P/xUd4IKbQo1fiVUixN/Ydxnqb2BUJnTDd3qlBFnDX
         uuBUvpQNZp2w0rm+zQ94UlhJgbn+PgAI7aJtaYj8EwfhFjq5gPoH7c3TEhOnGc3J/gUB
         hG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zv5NPFffUTFWq+5VT+kNlcF7WPDHuJF4ydktGZ/WsY=;
        b=jssR/8i5PGskzQpBeHVo7bmFx9YvmR8Xvyn8VkkAbsMbIUsow8xYdL0wNl2763pWOR
         u+jAMvrUOEg27ce2q/Mtc5QcGsoC7EU0vJKugUocFHUPDcyiXMoBe+ASfKA2tVl455Hu
         M5j7OMEus3aRi5st4XjWyAq6i2+AuAkE+9oOAombl9NeT3IKWdD1zfFHjJ+JsphNSDJr
         305rk6B2eOXZhDslCCylW+TL1SKSlZwqkhIPCJ+ZB/PbqFgBUuBKcAvbU9W20wZ0u7MI
         E9LimBdOBOD5laduQt4yLz67d2X4q4OxlGYifPsTwdYbbi6fyk/fRsbL4nDc/WM6oxAb
         BZ3w==
X-Gm-Message-State: APjAAAU1bnKibOn8wEf9ophQuGwTEPFmCBLvanB/tMo2hZKa9VAw7Ubg
        DV+5QycUVqOgDCi5R2utiQLogXPyZ9A1R5EGL023Bw==
X-Google-Smtp-Source: APXvYqzSjZCzq7vEPClkh//Q7yqVfPQznFE9UwH9Dy4nGFTtlSk7ZP8Mfm+itcx9CqEjryk0wJGf5vg9EJJpSWD3VFU=
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr17070227wmj.53.1569844638206;
 Mon, 30 Sep 2019 04:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190928101428.GA222453@light.dominikbrodowski.net>
In-Reply-To: <20190928101428.GA222453@light.dominikbrodowski.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 30 Sep 2019 13:57:06 +0200
Message-ID: <CAKv+Gu9dqjZHfCHcHprh32eHTVinwPar1zOYopyMVfp=zPqELg@mail.gmail.com>
Subject: Re: [RFC] random: UEFI RNG input is bootloader randomness
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Kees Cook <keescook@chromium.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2019 at 12:14, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Depending on RANDOM_TRUST_BOOTLOADER, bootloader-provided randomness
> is credited as entropy. As the UEFI seeding entropy pool is seeded by
> the UEFI firmware/bootloader, add its content as bootloader randomness.
>
> Note that this UEFI (v2.4 or newer) feature is currently only
> implemented for EFI stub booting on ARM, and further note that
> RANDOM_TRUST_BOOTLOADER must only be enabled if there indeed is
> sufficient trust in the bootloader _and_ its source of randomness.
>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Lee, Chun-Yi <joeyli.kernel@gmail.com>
>
> ---
>
> Untested patch, as efi_random_get_seed() is only hooked up on ARM,
> and the firmware on my old x86 laptop only has UEFI v2.31 anyway.
>
> Thanks,
>         Dominik
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 8f1ab04f6743..db0bffce754e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -545,7 +545,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
>                                               sizeof(*seed) + size);
>                         if (seed != NULL) {
>                                 pr_notice("seeding entropy pool\n");
> -                               add_device_randomness(seed->bits, seed->size);
> +                               add_bootloader_randomness(seed->bits, seed->size);
>                                 early_memunmap(seed, sizeof(*seed) + size);
>                         } else {
>                                 pr_err("Could not map UEFI random seed!\n");

Thanks, I like this change. I'll get it queued up in efi/next.
