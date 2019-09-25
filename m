Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F04ABE117
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 17:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439410AbfIYPUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 11:20:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35860 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfIYPUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:20:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so7425166wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ih7TKOYfBLPKOMFm2CoimjQft6GV1JfCO8eV/MUJwrU=;
        b=FMXKM9s6XrtYvQ88Ib0+IVZFHiUBU8cGTTuRi4LCBQoaPe9EksZ4oD43F2pxQVXQZ1
         pbA+NK4hNDaFGhpkGW7uvJITGoMw6qK0nTwR4MZuYnoOpluBn9DT+oNjBgAYk+fyv1du
         Zdz+H7/TvhBJR0EqaIagAXAWMOuMluTqkHQGmUtTnn4yjktlVDmp+M3WgiW2VFul+H0Q
         L3NTsp9pgPhgnIsll7DTwZoFUeddgK50/oUvXP5tL/fBRZdm58k4hirAq7HfO6v6B9+l
         9Xzzfpg1uQGivuIpIELbgh40/8G9FmACqsr8UQ3NtTymY2JEFloDxnBAq0eAoTU2HKXY
         y2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ih7TKOYfBLPKOMFm2CoimjQft6GV1JfCO8eV/MUJwrU=;
        b=Ar2ngxMSVq+AGunkA+W5JCM1GJSSEX6plvDEi8gf4U4kgAggIaMjQL7iKZ1zA/puZU
         U+5RTQ39vYpsKG4jYdBFLtiDFShcOUWHt8uBjQ7irbPrmKXEpX++MrfRfeEN8nbL9O8z
         6UbvVMVjc6vTlXE4oGEX7Mb7LKIpu0hyszW4CXYXs3D86m0MWYXRTyljrMNDwx1wUZer
         InfpJDqdbL/5+uqMcgfzKykYrtJ/5VjovmFny/Y7UfXjRA4wyLMdAY1L0eAyUNqGfYcZ
         BvSG7jLDGEKEtOGDYc2v6z5btCI75d8sJgKW2s+fn4f6okaaMGe/1ab6qpoBweqfV0WD
         UDzQ==
X-Gm-Message-State: APjAAAVo6/3C1jZevj6Dq/Bjx/Tl0RysJo3mLZGu7VfVXqZfdsfOGyMg
        OFUq+PDZcDb6SNCB8DtRY0NEeVGYjrD/ORGaGDwkOGv2WpE=
X-Google-Smtp-Source: APXvYqwzNrfGTdVLE38UE68+yX95Bv3XD1XJUh1r7iu9PvauWOolAlKjz4RDxaIwvVfhnsanRYoq3o9MYYK4H87Z6Zg=
X-Received: by 2002:adf:fe88:: with SMTP id l8mr9457664wrr.32.1569424853257;
 Wed, 25 Sep 2019 08:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190925131241.27913-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20190925131241.27913-1-ben.dooks@codethink.co.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 25 Sep 2019 17:20:41 +0200
Message-ID: <CAKv+Gu8H6u+3Hp5HdYwoG6PwVHGK4shjC9KNsUSMRy6xQNiPoA@mail.gmail.com>
Subject: Re: [PATCH] efi: make unexported efi_rci2_sysfs_init static
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel@lists.codethink.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 at 15:12, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> The efi_rci2_sysfs_init() is not used outside of rci2-table.c so
> make it static to silence the following sparse warning:
>
> drivers/firmware/efi/rci2-table.c:79:12: warning: symbol 'efi_rci2_sysfs_init' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/firmware/efi/rci2-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/rci2-table.c b/drivers/firmware/efi/rci2-table.c
> index 3e290f96620a..76b0c354a027 100644
> --- a/drivers/firmware/efi/rci2-table.c
> +++ b/drivers/firmware/efi/rci2-table.c
> @@ -76,7 +76,7 @@ static u16 checksum(void)
>         return chksum;
>  }
>
> -int __init efi_rci2_sysfs_init(void)
> +static int __init efi_rci2_sysfs_init(void)
>  {
>         struct kobject *tables_kobj;
>         int ret = -ENOMEM;
> --
> 2.23.0
>

Thanks Ben.

Queued in efi/urgent
