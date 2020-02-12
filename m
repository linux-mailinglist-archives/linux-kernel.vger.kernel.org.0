Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5B15A1CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 08:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgBLHV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42890 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgBLHVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so849870wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 23:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j+IIIiLxT7RnMEOjFvfDSmF1Bvf4Q7q8NLRdkGyRnxg=;
        b=QeNjMTZo3cCSAXF10gWV74TGaKosijV1vvCEv1hT0i9ekozYvZBkZgkFI+33j3HDEQ
         nZwZL09OYeIOXx44Qbg0v/Gt58+vn4pybDIMfL1RvvTnPfCk9anhB3SBsaIJZOivQLB5
         owvJdHyTAxU5LhftgojFG6mtS/GrAFgRshSz5I/jE8ZSiRRuVceM/Xc+fN2AmtwIaUR+
         URFZt7MaYYzmsE1ykJQLTZ+kFmq5d8gCGyNEZ0H3FXouFVST3DZX7Isz1SYY+7RySCLD
         /yGgvufx3ewwWTOgDeFFZKnVjygoOqiI1TKBtcIwDwpSkIWWjqw5hGMIHg2ywyJaNIHt
         o+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+IIIiLxT7RnMEOjFvfDSmF1Bvf4Q7q8NLRdkGyRnxg=;
        b=hEtUONn7xVcv4QVCdErr/W3ZM4e2NfyncatpmtdX2FKkJbQCXQf4gGIC97OgU9TtdQ
         GVzUaxyO5uZvq8uX4KdxInzndF2S1O4w88mjzwvWAxo34HCTWLEop2TNanddqlaocfAQ
         COHlBTNIE0uwWiRBb1btxlgTOKKrd30y8db1bMiIUPMhghvFPdtfS/pUp9hCI3FVc9JZ
         XJVXXSDMFQVgehYIeUBwrB8E4RXuYdd6VUSjCxswRvr/RU9YIkNygIBfJrdK1bcklfsS
         OLlOsqepk4I+Df2qazYaBx3wsgR3XymjxrpxpYe8VHDW8ErsF9UcYcEi0OlUCfN/5l/C
         SwDA==
X-Gm-Message-State: APjAAAWqTxzdn+51yHY9wiAmPRClk8RmkN6AyCFMLLFNc7owFHUF+WF6
        TxLTsDUdhxqM26X9kp3TO+yT1NCY8SYjM9DguGLp10jUuBo=
X-Google-Smtp-Source: APXvYqzpUpjlvlcKF40Lk+CatlRH7dOHAOIBZ0zDk0iL7ftqbPHh3NEkw8sI3vh2QOPtfgXkNnMJoxyn7/yQcxvgiMQ=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr13277372wrw.126.1581492083142;
 Tue, 11 Feb 2020 23:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20200211231421.GA15697@embeddedor>
In-Reply-To: <20200211231421.GA15697@embeddedor>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 12 Feb 2020 07:21:12 +0000
Message-ID: <CAKv+Gu_EgbX8r3Vuo5rKDS+WY0wHq4fWhPmZ1NKVAgu-Ybk4pg@mail.gmail.com>
Subject: Re: [PATCH] efi/apple-properties: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 at 00:11, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertenly introduced[3] to the codebase from now on.
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Queued in efi/next

Thanks,

> ---
>  drivers/firmware/efi/apple-properties.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
> index 0e206c9e0d7a..590c9003f3b4 100644
> --- a/drivers/firmware/efi/apple-properties.c
> +++ b/drivers/firmware/efi/apple-properties.c
> @@ -31,7 +31,7 @@ __setup("dump_apple_properties", dump_properties_enable);
>  struct dev_header {
>         u32 len;
>         u32 prop_count;
> -       struct efi_dev_path path[0];
> +       struct efi_dev_path path[];
>         /*
>          * followed by key/value pairs, each key and value preceded by u32 len,
>          * len includes itself, value may be empty (in which case its len is 4)
> @@ -42,7 +42,7 @@ struct properties_header {
>         u32 len;
>         u32 version;
>         u32 dev_count;
> -       struct dev_header dev_header[0];
> +       struct dev_header dev_header[];
>  };
>
>  static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
> --
> 2.25.0
>
