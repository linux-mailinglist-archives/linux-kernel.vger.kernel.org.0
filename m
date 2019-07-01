Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54E94B5A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 11:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfFSJz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 05:55:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35078 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfFSJzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:55:25 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so36837089ioo.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NOAHJ6UJcXUgY0jPOCunNfj5a/meWoc55ppSw19pMJw=;
        b=iGE0xIN1mnywsd2Ce9XydaQG42uFJVo1Fa+IZlogrgNPhixIiWWhYhymIB7etaoEpb
         l+e97WPf9990nNcy6IpRVWoEb9DkjiD6cKYCIah98nQeNIaH68oYqHRSpke0+NSTMMXo
         KWZ7n1PPMoOzwCWUP58CEHIFKULymNRzLQVCjuiAbXjapCSFJ2ac6D94aLkgPFn/uYpU
         q6CFuiHP31HNHKFFv0p7KwXpQX9CtjGg1stHcPgjO7707+T4hr4luSJqSJ4CWPKkY201
         4GEG4agouZwtYoKwJQqEeartWFSHACEyaX7y1CVp7QTUa+3ZTHDyxb+hkRzEHNWMeDTq
         CJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NOAHJ6UJcXUgY0jPOCunNfj5a/meWoc55ppSw19pMJw=;
        b=uQuD+A3n8O0P2xVVdbfQDHEnzJYi25C5LNxkJHnhlJMN5uiXaHm5RAWimR4tLhGE1u
         chRw+5DnIuK/HtUjdum1BXNfuYXlLMje+BLqr0+ovrxxw/DxXnV/dy0GFddP4J5KNn/k
         zIO+Uz1H3o/0h0IvP6NplwSjvn31te3O+MXN7pDWhudXlUiFKTyeWOTdt+DDKQNS2Eyx
         CUSGR3jpSBad0u+8hjWkqAI4D0v1lYKyVoK83cpFu2JS3QrcsBEQvodoc4wKnOSeGE2v
         VXySggFUWZNntic/WXnXGXKrcfCob3awV1rBhn/17BK4LPzN7rRZkxJGnMeOhAlmzAaO
         7cgQ==
X-Gm-Message-State: APjAAAWGJkA8OUVMoBM+R0zx0cKTJ+8BLpdC2nowjE0tIyNcIh3mXf17
        Xx90F2tdoMeWjXUxjpLX350RPdyFiIspL61nAuLU1w==
X-Google-Smtp-Source: APXvYqx0Z9rJjYG9CYyxYrAwmG0di3UeYY5aGWznMiIWIfkmqvQTq3YVD+y6EmDduri62FB0Xj+idglWedVL/2PxuWo=
X-Received: by 2002:a5d:9d97:: with SMTP id 23mr10934397ion.204.1560938124836;
 Wed, 19 Jun 2019 02:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190615040210.GA9112@hari-Inspiron-1545>
In-Reply-To: <20190615040210.GA9112@hari-Inspiron-1545>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 19 Jun 2019 11:55:14 +0200
Message-ID: <CAKv+Gu9-wiJNxPsVn06dBSU8Gchg8LjV=mi0cThZUWywmt2xzQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: firmware: efi: fix gcc warning -Wint-conversion
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        tpmdd-devel@lists.sourceforge.net,
        Matthew Garrett <mjg59@google.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Jarkko, tpmdd, Matthew)

On Sat, 15 Jun 2019 at 06:02, Hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
>
> This patch fixes below warning
>
> drivers/firmware/efi/tpm.c:78:38: warning: passing argument 1 of
> =E2=80=98tpm2_calc_event_log_size=E2=80=99 makes pointer from integer wit=
hout a cast
> [-Wint-conversion]
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

I think we already have a fix queued for this, no?

> ---
>  drivers/firmware/efi/tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 74d0cd1..1d3f5ca 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -75,7 +75,7 @@ int __init efi_tpm_eventlog_init(void)
>                 goto out;
>         }
>
> -       tbl_size =3D tpm2_calc_event_log_size(efi.tpm_final_log
> +       tbl_size =3D tpm2_calc_event_log_size((void *)efi.tpm_final_log
>                                             + sizeof(final_tbl->version)
>                                             + sizeof(final_tbl->nr_events=
),
>                                             final_tbl->nr_events,
> --
> 2.7.4
>
