Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590A21AF1C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 05:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfEMDYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 23:24:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40836 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEMDYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 23:24:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id d15so9543979ljc.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 20:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfoMnU1B5MwsGgUobBUJ9DN4Ws8VJ5pzaMDc3Fb2GBA=;
        b=rrOw31zwjhDHCFNWNtO9LFKRbgxlbOMBNdz3cVZpOip1OQg7z+h7XtrwBpmuI0UVfW
         /jY37VLT58EpAaJLnQ1VlB7/rVFKbssVgPQ3SSM7zpCxkvyU9C5ACF7vbzTVp0VGADGL
         mXlRSPjzLrsLDxXR6eZtuKR/zNEMTZ/GElGkxAYXvR6xxIw/XHZBNGxWW0xpr+o4Y2tM
         TN3ePkz3q1ED3QkhG02k0IWHB/zuh/7cMqIxgoI8HZNlF47uZec9Yx1HkYgyw9/nm/Xy
         jmqsYGRRv8064lLLFeYHcMj+kS8AHuPqFLUouJQspeF3FgDFeq14L9f7vdPboW3LT2nI
         9dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfoMnU1B5MwsGgUobBUJ9DN4Ws8VJ5pzaMDc3Fb2GBA=;
        b=B8XmLYj+v0lMyCO3u/HnJkvBHrkh0KZBtaPGXMW0oTFg/4CC1/HEOprmBDvGoDUH01
         jgZRCdchp2YXf8yblQ/K/cg/z5XUpBw3craqA39tKc3lbnz5xCYYhcr1AoobR1/XwwW+
         UdzThM3sEBlKOpuKFepR4Q4+z/kLC1/MgQvoY+HB3rH8M7YkeYSuQQswOsIFk9UeId/S
         xMvCu+3lBunRCsdekbS4ihcui3gXeuN1pKw/Q+m7IFW9gxrNWFg4/pMnp8YpJPnkGO+f
         CMpaOLr0FF3KLdGPk3gpijakBxwQDbQlKIaYdx8oAUk0CMD1RvH3qCTm02avz58g8YLi
         ldxg==
X-Gm-Message-State: APjAAAWQr4UcC9pwLhDAMti/Zj3NrJy13ETA19Z+S334WD9HGJ/os4tM
        8YoArhDGT+fwILX+RsBxIDTPRdIymxgxBtAzmw0=
X-Google-Smtp-Source: APXvYqyEYmZGdxeGvqmk/S+pXokxfY1UVIYswy62bNye9U+5nX7dOppPE2nWqsDi7wfjoY1PVMXSd9YfVNq64B9BLcQ=
X-Received: by 2002:a2e:994:: with SMTP id 142mr4150099ljj.192.1557717838459;
 Sun, 12 May 2019 20:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <1557716049-22744-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557716049-22744-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 13 May 2019 00:23:52 -0300
Message-ID: <CAOMZO5DKBGYgri7swrbqWZ_j8TfTUsiPivnYPvN2X3GvGcTNrA@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] soc: imx: Add SCU SoC info driver support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 11:59 PM Anson Huang <anson.huang@nxp.com> wrote:

> +       soc_dev = soc_device_register(soc_dev_attr);
> +       if (IS_ERR(soc_dev)) {
> +               kfree(soc_dev_attr->revision);
> +               return -ENODEV;

This should return PTR_ERR(soc_dev) instead.
