Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E209B197B35
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgC3Ltc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 07:49:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44415 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbgC3Ltb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:49:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so17689671lji.11;
        Mon, 30 Mar 2020 04:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3LI716UXF6bfo4VYqoP3VeDTvzHtXiCh3tM1tgh2v+k=;
        b=nsExSjXHqIvgbyHEhZzSlHZ6qD7wnb3b7lQ2UUHlFb5MZvlWcVzdj0RPl6mpt8ALgm
         lr8frOmesionfQ+vaY8rFIX8GvC8Q7ZgFYyxVx1tlnkK8QSOZPHwLZ/2A+Zbwa2KICUA
         g9VnqDbo0OoQPSqFcQsSYwvzTEzLmQlPT6RyfE5yy6S3DEVF/X8MOTnUv1G5iBt/D9M5
         Xuy8PBJUBLjxWgO0vVHF69ZxuHLj13gwdEuSc3LZcVW5XIK3hJkUaWz9lZ54g7h7D+jG
         oSxXr/rvj7FpRtkUM4BALSUJbOlZX1oJH0VblPEPkpwEyAfpIGByujN/jXC47U8bS0cz
         q4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LI716UXF6bfo4VYqoP3VeDTvzHtXiCh3tM1tgh2v+k=;
        b=ANn4/7jl/xWSRvmMPiZyNiEjR5nEZC6jzLz3QZwuh2DBczH7xvPcBBAJOnf1IXLCag
         X6R/RD7S2RQYIPJ6In00jFn1UeUPR6m0Xqr4nbAek3J+AEU6T0fBjAgTgbgzEGDOR852
         rjQcRES+moN6XmX3mG/clgWczc1F4+LUF27SnayQZ3kbTfGw0pM+rV80rzR3KdwM/Mw7
         UyqNR8+1vIp+amgo7ANgP8RGYnyr4ftxyzYnFdkXHU+cPvJJoF+AxKBzUtUz1zrqSiJw
         a5PVL68IZKr2QS6uIy7y3loGlUWH6Us8EqxpxBDQTBnbHcFQWXI4uJAPS6ulmrDw85Is
         J4aA==
X-Gm-Message-State: AGi0PubinbOuFsCjq4L8tnh6CM3BI2w8R0usVbc/Dik1IOnfqRCJEIt1
        oaB4Aa1IcJfDNq7CgoWJymv2roIrcpe0dEMvBSI=
X-Google-Smtp-Source: APiQypJcW+KgRk6o/Ou48vwV4luc+5i+/EZubfDgsinD6eEi6d3RUluGeVWMrjQtxj/UdvutLn1NA3q5aclTGJP/Ah4=
X-Received: by 2002:a05:651c:30b:: with SMTP id a11mr6771326ljp.164.1585568968812;
 Mon, 30 Mar 2020 04:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200330113542.181752-1-adrian.ratiu@collabora.com> <20200330113542.181752-5-adrian.ratiu@collabora.com>
In-Reply-To: <20200330113542.181752-5-adrian.ratiu@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 30 Mar 2020 08:49:19 -0300
Message-ID: <CAOMZO5CEZSBfhb9xAdf=sDhUnmSeuWSsnUQArz=a1TPzytLAeQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] drm: imx: Add i.MX 6 MIPI DSI host platform driver
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip@lists.infradead.org,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, kernel@collabora.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Emil Velikov <emil.velikov@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, Mar 30, 2020 at 8:34 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> This adds support for the Synopsis DesignWare MIPI DSI v1.01 host
> controller which is embedded in i.MX 6 SoCs.
>
> Based on following patches, but updated/extended to work with existing
> support found in the kernel:
>
> - drm: imx: Support Synopsys DesignWare MIPI DSI host controller
>   Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>
> - ARM: dtsi: imx6qdl: Add support for MIPI DSI host controller
>   Signed-off-by: Liu Ying <Ying.Liu@freescale.com>

This one looks like a devicetree patch, but this patch does not touch
devicetree.

> +       ret = clk_prepare_enable(dsi->pllref_clk);
> +       if (ret) {
> +               dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
> +               return ret;
> +       }
> +
> +       dsi->mux_sel = syscon_regmap_lookup_by_phandle(dev->of_node, "fsl,gpr");
> +       if (IS_ERR(dsi->mux_sel)) {
> +               ret = PTR_ERR(dsi->mux_sel);
> +               dev_err(dev, "%s: Failed to get GPR regmap: %d\n",
> +                       __func__, ret);
> +               return ret;

You should disable the dsi->pllref_clk clock prior to returning the error.

> +       dsi->mipi_dsi = dw_mipi_dsi_probe(pdev, pdata);
> +       if (IS_ERR(dsi->mipi_dsi)) {
> +               ret = PTR_ERR(dsi->mipi_dsi);
> +               dev_dbg(dev, "%s: Unable to probe DW DSI host device: %d\n",
> +                       __func__, ret);
> +               return -ENODEV;

Same here. You should disable the clock. Shouldn't you return 'ret'
here instead of -ENODEV?

> +module_platform_driver(imx_mipi_dsi_driver);
> +
> +MODULE_DESCRIPTION("i.MX6 MIPI DSI host controller driver");
> +MODULE_AUTHOR("Liu Ying <Ying.Liu@freescale.com>");

The freescale.com domain is no longer functional.

Ying Liu's NXP address is victor.liu@nxp.com. You could probably add
your entry as well.
