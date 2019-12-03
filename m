Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53190110079
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 15:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfLCOjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 09:39:55 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39882 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCOjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:39:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id v16so3348086edy.6;
        Tue, 03 Dec 2019 06:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPEnXL1XzID9qd2Be+10pgTMy8eYDYLQQ70JFSTiM08=;
        b=Vl8jiiuVXWwr7ClOguZmELloyPTHl48gSZxaDbOpMHPc4LMpIhj1b4FcSyfIIldnEh
         q97wCH0YXJXSQc1YhnwFxOt21ElKghviSZH1/wK+lZmWlePXtKXuZ40H3bJ7IRvTt1Vx
         u2ztVxE8IHjiIHM4sgCOACoXlCQ3G+2cuWTOKvDErMISUhsWqO8zh3EGOGzCcsmoXPfN
         fTGFqO6RuReobNNmt56EAuUeUAYiCt60qup4/4npR40b468uZi2+qalbQRRQXiPZWI9g
         9uFRXFse47eT3C9xA5YbF/fiEgTdqZFP58RkP+6Bka3xfmE7JLSNMP50/4/suHS9eDdt
         Q8WQ==
X-Gm-Message-State: APjAAAWCuDYN9JWKX9DrY1VaSeNH0UnMGrTngIJrfnQbsbpKMPagvV+R
        rcZiM7ZcuKbIUyasGbf26/goLOKUB3I=
X-Google-Smtp-Source: APXvYqx8rHY4hUXdqC96vmhZCGi3TG+rHw7CaW1Ns+CQfqV9O4Kjd2dVdSltIy5XqzuCTu2ObDkpyw==
X-Received: by 2002:a17:906:3e90:: with SMTP id a16mr6314076ejj.265.1575383992262;
        Tue, 03 Dec 2019 06:39:52 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id w1sm89451edr.76.2019.12.03.06.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:39:51 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id b6so4043909wrq.0;
        Tue, 03 Dec 2019 06:39:51 -0800 (PST)
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr5834386wrx.288.1575383991083;
 Tue, 03 Dec 2019 06:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20191203134816.5319-1-jagan@amarulasolutions.com> <20191203134816.5319-4-jagan@amarulasolutions.com>
In-Reply-To: <20191203134816.5319-4-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 3 Dec 2019 22:39:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v67kQ391QJhQYYYEdchHpRYBUDji=iYMZ9fKY3aCw0He-Q@mail.gmail.com>
Message-ID: <CAGb2v67kQ391QJhQYYYEdchHpRYBUDji=iYMZ9fKY3aCw0He-Q@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] drm/sun4i: dsi: Add has_mod_clk quirk
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 9:48 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> As per the user manual, look like mod clock is not mandatory
> for all Allwinner MIPI DSI controllers, it is connected to
> CLK_DSI_SCLK for A31 and not available in A64.
>
> So add has_mod_clk quirk and process the mod clk accordingly.
>
> Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v12:
> - none
>
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 38 ++++++++++++++++++--------
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  5 ++++
>  2 files changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index c958ca9bae63..8c4c541224dd 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -11,6 +11,7 @@
>  #include <linux/crc-ccitt.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/phy/phy-mipi-dphy.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> @@ -1093,6 +1094,7 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
>         dsi->dev = dev;
>         dsi->host.ops = &sun6i_dsi_host_ops;
>         dsi->host.dev = dev;
> +       dsi->variant = of_device_get_match_data(dev);
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         base = devm_ioremap_resource(dev, res);
> @@ -1120,17 +1122,20 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
>                 return PTR_ERR(dsi->reset);
>         }
>
> -       dsi->mod_clk = devm_clk_get(dev, "mod");
> -       if (IS_ERR(dsi->mod_clk)) {
> -               dev_err(dev, "Couldn't get the DSI mod clock\n");
> -               return PTR_ERR(dsi->mod_clk);
> +       if (dsi->variant->has_mod_clk) {
> +               dsi->mod_clk = devm_clk_get(dev, "mod");
> +               if (IS_ERR(dsi->mod_clk)) {
> +                       dev_err(dev, "Couldn't get the DSI mod clock\n");
> +                       return PTR_ERR(dsi->mod_clk);
> +               }
>         }
>
>         /*
>          * In order to operate properly, that clock seems to be always
>          * set to 297MHz.
>          */
> -       clk_set_rate_exclusive(dsi->mod_clk, 297000000);
> +       if (dsi->variant->has_mod_clk)
> +               clk_set_rate_exclusive(dsi->mod_clk, 297000000);

The clk API can handle NULL pointers, so you don't need to add the if here...

>
>         dsi->dphy = devm_phy_get(dev, "dphy");
>         if (IS_ERR(dsi->dphy)) {
> @@ -1160,7 +1165,8 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
>  err_pm_disable:
>         pm_runtime_disable(dev);
>  err_unprotect_clk:
> -       clk_rate_exclusive_put(dsi->mod_clk);
> +       if (dsi->variant->has_mod_clk)
> +               clk_rate_exclusive_put(dsi->mod_clk);

and here...

>         return ret;
>  }
>
> @@ -1172,7 +1178,8 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
>         component_del(&pdev->dev, &sun6i_dsi_ops);
>         mipi_dsi_host_unregister(&dsi->host);
>         pm_runtime_disable(dev);
> -       clk_rate_exclusive_put(dsi->mod_clk);
> +       if (dsi->variant->has_mod_clk)
> +               clk_rate_exclusive_put(dsi->mod_clk);

and here ...

>
>         return 0;
>  }
> @@ -1189,7 +1196,8 @@ static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
>         }
>
>         reset_control_deassert(dsi->reset);
> -       clk_prepare_enable(dsi->mod_clk);
> +       if (dsi->variant->has_mod_clk)
> +               clk_prepare_enable(dsi->mod_clk);

and here...

>
>         /*
>          * Enable the DSI block.
> @@ -1217,7 +1225,8 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
>  {
>         struct sun6i_dsi *dsi = dev_get_drvdata(dev);
>
> -       clk_disable_unprepare(dsi->mod_clk);
> +       if (dsi->variant->has_mod_clk)
> +               clk_disable_unprepare(dsi->mod_clk);

and here.

>         reset_control_assert(dsi->reset);
>         regulator_disable(dsi->regulator);
>
> @@ -1230,9 +1239,16 @@ static const struct dev_pm_ops sun6i_dsi_pm_ops = {
>                            NULL)
>  };
>
> +static const struct sun6i_dsi_variant sun6i_a31_mipi_dsi = {
> +       .has_mod_clk = true,
> +};
> +
>  static const struct of_device_id sun6i_dsi_of_table[] = {
> -       { .compatible = "allwinner,sun6i-a31-mipi-dsi" },
> -       { }
> +       {
> +               .compatible = "allwinner,sun6i-a31-mipi-dsi",
> +               .data = &sun6i_a31_mipi_dsi,
> +       },
> +       { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> index 3f4846f581ef..d791c9f6fccf 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> @@ -15,6 +15,10 @@
>
>  #define SUN6I_DSI_TCON_DIV     4
>
> +struct sun6i_dsi_variant {
> +       bool                    has_mod_clk;
> +};
> +

You could choose to put this above the probe function, since this isn't used
anywhere else, and a pointer field doesn't need the full definition.

ChenYu

>  struct sun6i_dsi {
>         struct drm_connector    connector;
>         struct drm_encoder      encoder;
> @@ -31,6 +35,7 @@ struct sun6i_dsi {
>         struct sun4i_drv        *drv;
>         struct mipi_dsi_device  *device;
>         struct drm_panel        *panel;
> +       const struct sun6i_dsi_variant  *variant;
>  };
>
>  static inline struct sun6i_dsi *host_to_sun6i_dsi(struct mipi_dsi_host *host)
> --
> 2.18.0.321.gffc6fa0e3
>
