Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2A1C935
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfENNKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 09:10:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44519 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfENNKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:10:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id e13so14224905ljl.11;
        Tue, 14 May 2019 06:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QxULgCJJU6whyZ9y0hS1oF9JuMI5zQD1en38bvt/B04=;
        b=lN5eWoC/jDjSyyHYjsETGV3wO4lmD1qhUt9I/X6uZg166ukSlKLjDy97fwHc8kdHx7
         R/Hqx/VUzwjraqdNgeNp8JvxEKpGWnJL4cpmrnyExFklpILKvT8FAzCxutETAECKDLHL
         NbCWcFBGHRXud7p3a7+wXZHeaqDFlfevh/ENvawZbnS8z9Vn/PuNIYEsKTNrW8MxGumV
         g1YOmRH/C1ZMIp/IdkKNUMRm/pKKcnlbmFOQopvfHgRraCah1JWGDTv3K15cx1wSryma
         ckY/KlrLOpWi0Q9D8OdKcVBSIV43FIe4ccRG+nHRTVVHodonNvo2KX6b8kQt/uIFjDZ6
         si8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxULgCJJU6whyZ9y0hS1oF9JuMI5zQD1en38bvt/B04=;
        b=F5FQMCn0efYuqz2iHxWT+wVwTFLxIP/VFgSSnyvAhmmvbuxvF8CoYVn67WUcd2yJUb
         3ydZwYVuSn4GAVV5faiMXraoC1zB5Yl6t/6nDwELLCOJUO/gXPmtl5vqhFC9QF92QOQp
         1XqsaR9bTwP/IyBwH8L0S+tX6YvY/pxm3/W3eAgQ5X4tSEaKXKdb9rB+ucRDOjAmfc/p
         ck32HSfYStWrAQG0XHFWOKcRtxFTcDFzoOxJcLTXGQ5eE2xXdXnOQ/PbeDVeFTJSzBQY
         gQsdS+RGa2N8Si75upPSc+00DLQsKoDI8C0fVYNVNU3rNFbb6MGkpIt6JF70dbS8S9sO
         yB8g==
X-Gm-Message-State: APjAAAVcyyGTpLclmdoHmZTeaUsJO9XbQ7JCJKvwfnbr6H81Tr7fD3Qu
        lVH9g8/Y0yb8BBJXPPrejPxOlL2lTbPjwQg9fDA=
X-Google-Smtp-Source: APXvYqznroPJOcau3kywVIDJUSjhKgHyMhu+kPXLeokQZNIPG5akh0m7QdmTeIGkxLnrBgQDylGneEsMLTsOxBwZaVE=
X-Received: by 2002:a2e:5dcb:: with SMTP id v72mr18139620lje.54.1557839406129;
 Tue, 14 May 2019 06:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190513202258.30949-1-angus@akkea.ca> <20190513202258.30949-3-angus@akkea.ca>
In-Reply-To: <20190513202258.30949-3-angus@akkea.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 14 May 2019 10:10:02 -0300
Message-ID: <CAOMZO5BXq0nFBXtWb2cXQkqnv672vkWyyC4QoyQE2PyPmXdgUQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/4] arm64: dts: fsl: librem5: Add a device tree for
 the Librem5 devkit
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
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

On Mon, May 13, 2019 at 5:23 PM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> This is for the development kit board for the Librem 5. The current level
> of support yields a working console and is able to boot userspace from
> the network or eMMC.
>
> Additional subsystems that are active :
>
> - Both USB ports
> - SD card socket
> - WiFi usdhc
> - WWAN modem
> - GNSS
> - GPIO keys
> - LEDs
> - gyro
> - magnetometer
> - touchscreen
> - pwm
> - backlight
> - haptic motor
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
