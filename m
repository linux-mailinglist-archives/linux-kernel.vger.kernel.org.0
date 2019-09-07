Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8858DAC7D5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 18:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395070AbfIGQ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Sep 2019 12:59:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35567 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395031AbfIGQ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:59:34 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn20so4638043plb.2;
        Sat, 07 Sep 2019 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nup+ZritHyxNFOCaObFAN5rNMYLIMSIpxWMsEmTd4U0=;
        b=ZJ9Cm7YdCiVNQDjVm9Khq/SRfUjWWxNHECtZmmijLOGwxobAsiKMLeoGPMc5wff2SL
         a/1fcN7Qir3ZHKbhXTNSax116NB/A1WnnFuNTE1zWQnNgyOAwa/SvH9J/Ulrw4vQ0Ook
         0RqNUsqPRZ+B5MlB7P8G5Yf/PvFPNgpn5Q+Tf1scq+wFnGUB5Tk94d5KBotsu2g0rr5q
         hVn3/vU7ZSetJeV2JmPaeRJuAQpeS1dJeW6sRNNRtJl6f/ULl3nq584CUlEGskTMQCzZ
         VwWKUwgcc/ixaDbIF6cxCnL27sa54d7NzD0yYuhSkg15ZDgKviC/AVxAbqeJm8fGwq25
         hx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nup+ZritHyxNFOCaObFAN5rNMYLIMSIpxWMsEmTd4U0=;
        b=HJkSr2is/gx+ack19VlPyiKMBs7W/eR0bRNdr9dBtSjoOJ7IDzu4vQJaBYOcJuJV5R
         JhGzA3AwJNOFsaIX3zbpo64dhv5qOjtv0Yqg363D4eJKSqyR06qw0LsmemRtlDwXtwP0
         UYZfJ3Bq2+FbDRyWe2o09kxhmBzsLzq6JvFGEoncZU4CpBsFD3udaAlVQlyYjxxXHb4Q
         q3BRF43v+TgGmgDb1XT6Lo7duT8UjcDlkjrx+K0F37ROUJzmXF9aDU5SrEd7GGCfDfXM
         0EXP6JXvN2hUth1F2Zyku5x/eZTFuOtjOG/u9SDPSB2cY1cUgxcx01mZSnQDxgLgReaX
         4ksQ==
X-Gm-Message-State: APjAAAV5e4Wyqyp0dYsyy4QEJLvXfVQKrvK3NDBUF9bAH/TmUqfzNXqO
        wdorqm+WMvU6QmA+xxs0zFG6l/rdhTa7u04xTfs=
X-Google-Smtp-Source: APXvYqz8m5qBUTGbwRtcM+UGu19F9+AcMyyOgN2P4e7wCb8USywVjvO0seu44C4/n2mjTkrOC62Wsr29m/rpqsKqVqQ=
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr15239214plp.262.1567875573606;
 Sat, 07 Sep 2019 09:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190818110451.20571-1-hdegoede@redhat.com>
In-Reply-To: <20190818110451.20571-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Sep 2019 19:59:22 +0300
Message-ID: <CAHp75VehBvaPHSQS3wMWKEXWDC_e3a_7w0V6YJkmyrSE5Pa=RQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the Trekstor
 Primebook C11B 2-in-1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hiller <thomas.hiller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 2:05 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add touchscreen info for the Trekstor Primebook C11B 2-in-1, note the C11B
> used the same touchscreen as the regular C11, so we only add a new DMI
> match.
>

Pushed to my review and testing queue, thanks!

> Cc: Thomas Hiller <thomas.hiller@gmx.de>
> Reported-and-tested-by: Thomas Hiller <thomas.hiller@gmx.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 20a943f519dd..8255273b6972 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -981,6 +981,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "Primebook C11"),
>                 },
>         },
> +       {
> +               /* Trekstor Primebook C11B (same touchscreen as the C11) */
> +               .driver_data = (void *)&trekstor_primebook_c11_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "PRIMEBOOK C11B"),
> +               },
> +       },
>         {
>                 /* Trekstor Primebook C13 */
>                 .driver_data = (void *)&trekstor_primebook_c13_data,
> --
> 2.23.0.rc2
>


-- 
With Best Regards,
Andy Shevchenko
