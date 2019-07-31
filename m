Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B403C7C3FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 15:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfGaNtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 09:49:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35274 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfGaNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:49:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so65746260ljh.2;
        Wed, 31 Jul 2019 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHnmszNHQ24CJyTvOnvNHkM+wRRDSJ9cy+lG6yjUm6A=;
        b=FOMsBV9S1Vb6xH9FUBqIDl2S1V+eJuU8e/JPTM/AamBryhGN8AWt24ot7iQOlRaSPS
         lwobEJNTfwgkQJK5Rp+7k+Ah/g6519n9ue/b61eD/qF9k8NEjF1DI21GDIq65JnRzdsC
         WDj1jTaZT2XoWzO9RAV3N3DkAjCG3HYK1TXM2bmSt+t/XDdKezfbCmfLstDNReBUjYwl
         tDTJ5gmOitt8H92diDLl3uv/h+94LN4BnOmWSjFlQUtq8GAiRIU05L2lsbHzbuXM3HO/
         uXGwvwKTAtyhObuELaPdjOlsab7bHka8etSQachElSNyUtrhnyvIleoPQ+FV/2TkADAx
         sjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHnmszNHQ24CJyTvOnvNHkM+wRRDSJ9cy+lG6yjUm6A=;
        b=ZP0p/UxxbeZkVou05LQ0M+6ZjjFsav9DNwYEH6SwIEksHPxt4BNWK71PHY6DzcQqTZ
         jmykiCsMvlP1UD+t/HDaCdNtd4SHncgGNVngJ0mT+sjMQMy2Wqyw/cOMDF0I4v5fxkAM
         36dhSnbs5vH+7HKznkaKTgDoFlvfQ1tiISht4+NcyipzsUwKRhavrKWGAwZLPpVIa0US
         B4bovTgzfBiUjdQCEhzqFaJMmtFTW3A+pciI9mr2lWck6SeXiqVlpahDdw+LGhJ62Su/
         sqZ2NUuIsnR8QxJB1tFT7g4k3s/WDiJG9hTX8GWXQ3IrbldU/G5mZdaPgRhhC/j85I7E
         8xpw==
X-Gm-Message-State: APjAAAUwS/o7GzH00yD1J1OQ1Sh0ru69D0NeB/qW4sacnzZWKvwUXNHf
        6IRt7M77XGM5Enu19om02A1cKjg7xcK71l8IGdo=
X-Google-Smtp-Source: APXvYqwlpiIrNNuUqGXtabWXIAAqU7YbPr6xoLilXUIcgeT11EtO5xmCkkDnDuOgWknepM66PFb7aBm6HjOt5rrPB1U=
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr27620915ljs.44.1564580987014;
 Wed, 31 Jul 2019 06:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190730214833.30659-1-lukma@denx.de>
In-Reply-To: <20190730214833.30659-1-lukma@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 31 Jul 2019 10:49:53 -0300
Message-ID: <CAOMZO5Bokk_j5h=34e4jrB1-+KPV0P4nURL13VD7kq2=GXfmhg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: vf610-bk4: Fix qspi node description
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Tue, Jul 30, 2019 at 6:48 PM Lukasz Majewski <lukma@denx.de> wrote:
>
> Before this change the device tree description of qspi node for
> second memory on BK4 board was wrong (applicable to old, removed
> fsl-quadspi.c driver).
>
> As a result this memory was not recognized correctly when used
> with the new spi-fsl-qspi.c driver.
>
> From the dt-bindings:
>
> "Required SPI slave node properties:
>   - reg: There are two buses (A and B) with two chip selects each.
> This encodes to which bus and CS the flash is connected:
> <0>: Bus A, CS 0
> <1>: Bus A, CS 1
> <2>: Bus B, CS 0
> <3>: Bus B, CS 1"
>
> According to above with new driver the second SPI-NOR memory shall
> have reg=<2> as it is connected to Bus B, CS 0.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Suggested-by: Fabio Estevam <festevam@gmail.com>
> Fixes: a67d2c52a82f ("ARM: dts: Add support for Liebherr's BK4 device
> (vf610 based)")

Please fix the order of the tags.

- Fixes tag goes first (do not split it into two lines)
- Suggested-by
- Your Signed-off-by

With these changes you can add as the last tag:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
