Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7ADF13DDA5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 15:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgAPOkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 09:40:31 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37949 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgAPOkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:40:31 -0500
Received: by mail-vk1-f193.google.com with SMTP id d17so5720587vke.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 06:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QZdbZ2XQ7Giis44JfQlULo8PuSgu2UjFZ1aXHmX2hyY=;
        b=VEkO56WbDFtbFCn35D8Dbr3SUKuA7Xw7a/rYzZIWlQf15KTHrbCl72ybEiXj3hLq4t
         ntQdGc4llbXS/MOLx8ptYssj2Mni0fKZAKidl/TuCYo5cBvqZpXE68zyNLUGwZNbRpHS
         DUlyqVbxty4475ZoOFu4bY49E0zG2Vaoe1/84JklMie3jHx+uyBLLUwGnqN8jcl9eicF
         mSJHbdAjRu82p97tkseAYp3xrmvdQNEWqlY9CcnNQt5nfk1PbZj4c4XTIWkR+wTg8DnQ
         DlOKh5W0qTmb30L0ieAKhyIiKf0xkQUG4/bG+RCAB2nbqA9FBn6fR+N3TffOM4wQQLJu
         XAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QZdbZ2XQ7Giis44JfQlULo8PuSgu2UjFZ1aXHmX2hyY=;
        b=W4j/OO0llkWwEPiTXLbbn3ays8I03iWX7joskpQZr8BR+KVw1WpGQtU1Z92VtdJFEK
         scqsD/FKCt862gALh8Ua8VDtrXIlyktRYsbMyrsY8/BJJQpBkK5UXBD2Za47XKPg4QQx
         3476pRfqtgpu8vWgsp+AtLQ9h8kt9aYPFYl43Eq1sGdw/fNjkO36vgt2UcKJgwfUCPvW
         um5jA+ElPEos39dRub6VnChUw1+myZ9z6v5ALOV9Xlr7ltAbTJQkuLfwE26KNcCn5Ucq
         vEmz7bvrdFDsJpzyyDZZb/VxttjGiAOpNEOo+BP2qv64/MkLaBtB8D8dXo5G0r6XKYUN
         l7Jg==
X-Gm-Message-State: APjAAAVcKGXU7sFFkbSSvxzi5HLin9Q3mntqbR+NI8f1id0j9+XyobYw
        kFaJrZ3k7P7EyrZKcCxTD9oUvN0tWmABsEgoP/3YcQ==
X-Google-Smtp-Source: APXvYqyu2MvVVlLKsqdhalyNpHV55xEST4YWTCddM1OUCnunk1dLED6ql3fmY4XgQvOTqLlrkj05p//WKRmZbgzrODA=
X-Received: by 2002:ac5:cde3:: with SMTP id v3mr18595915vkn.43.1579185630093;
 Thu, 16 Jan 2020 06:40:30 -0800 (PST)
MIME-Version: 1.0
References: <9aff1d859935e59edd81e4939e40d6c55e0b55f6.1578390388.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <9aff1d859935e59edd81e4939e40d6c55e0b55f6.1578390388.git.mirq-linux@rere.qmqm.pl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 15:39:54 +0100
Message-ID: <CAPDyKFqXmbnH_NWZZTHHCE+Lt-f3JHAhJ8-=aoKNEPyQed44YA@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: tegra: fix SDR50 tuning override
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lucas Stach <dev@lynxeye.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 at 10:47, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmq=
m.pl> wrote:
>
> Commit 7ad2ed1dfcbe inadvertently mixed up a quirk flag's name and
> broke SDR50 tuning override. Use correct NVQUIRK_ name.
>
> Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
> Cc: <stable@vger.kernel.org> # 4f6aa3264af4: mmc: tegra: Only advertise U=
HS modes if IO regulator is present

I am dropping this tag, simply because I don't understand what it should te=
ll.

Instead, please monitor responses from stable maintainers, to see if
there is failure to apply this for stable and then send a manual
backport.

> Cc: <stable@vger.kernel.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Tested-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Applied for fixes, thanks!

Kind regards
Uffe


>
> ---
>  v3: added Thierry's signs that were missing in v2
>  v2: converted 'Depends-On' tag to proper 'Cc: stable' lines
>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 7bc950520fd9..403ac44a7378 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -386,7 +386,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host=
, u8 mask)
>                         misc_ctrl |=3D SDHCI_MISC_CTRL_ENABLE_DDR50;
>                 if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
>                         misc_ctrl |=3D SDHCI_MISC_CTRL_ENABLE_SDR104;
> -               if (soc_data->nvquirks & SDHCI_MISC_CTRL_ENABLE_SDR50)
> +               if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR50)
>                         clk_ctrl |=3D SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERR=
IDE;
>         }
>
> --
> 2.20.1
>
