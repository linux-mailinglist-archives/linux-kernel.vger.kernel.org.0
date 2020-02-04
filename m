Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0FB1518DB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 11:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgBDKdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 05:33:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45022 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgBDKdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:33:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id m16so22269911wrx.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hi5ABYQUkVP/jgGhAuOreV5DcMK/yqN3/B3hQICD40c=;
        b=p5y/+ahdBBy4euOtV0GdIxNBysYzXRURg3EbjLLAVG6Qq5uE9nN32QzcaSRWOZNTXZ
         KbX2/rqwbUSpE9iwgH7M5ZdC3wVuKcTg2GeDYtJAcYJ4E4GOJfXZqaKuqdAXfyh2rgnF
         9LtC+n/mx9Pv9l6b2Bp6jTV6WjMCqbCitxwSatyDpPoFh3PeKDUUpd8+q6TUdg3HBywo
         meWOofxJi26Vpv+dpYUmInRztpTkkmN/WWOt/Wyv8u36d2OnLNuWqqYh9Js2xQWBkkcX
         O4J7MkLz6zbeV7Bq5T9rCES0lQnaBx4mVxJN4ESeq6bhFLFThewvYcEbwR4QAE7DwIa1
         Kqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hi5ABYQUkVP/jgGhAuOreV5DcMK/yqN3/B3hQICD40c=;
        b=WR86mEgP20jZoclXZTKepPy8q0jB48lNVCYVMlPTfp6J4Kay6ZwDZ7t+Db0OLrHA15
         +FM1AL8YxbcR/L0UGAtJmWro9M1T6an956pOeYtpS3OpQZmygwuVxjWSrMfSKOFNZpy0
         UouIG6i5WsbHcwKj45uaTEAUHRFudr9Mn4K0ZS+H51oC2Onf/wM0kSwaXpshKuKl4Bjb
         VvV5x9Ac86zwwM72OPcn6/+o9tfpSFfnwizGxOnSHwzIsilZ3WLi0JA3x7rTTh1HQ1h+
         IMq3v0xJy10m26yVwWPvA+hXSnRBEGlmpfnxH3oA/XpDosxAgXsSbtkYirJl8zEizex3
         X4mA==
X-Gm-Message-State: APjAAAVcnN7dAzoChHGCiepq/se0aH3bCfjV7TqSgiPFw9fP/IAJf+yx
        iIuUxLUv/suAXAwHD8HaZNKYcSoxvRJQjuUeaFhY+d8WV2w=
X-Google-Smtp-Source: APXvYqzNghy9cmIkCAJBnH0aV7c6CZH7NQMk6DyQKWRtK1iVloxi0xWtvAm7QXlMvab+J5CTra3f7hersnBUw/FHPPk=
X-Received: by 2002:a5d:530e:: with SMTP id e14mr21073083wrv.250.1580812383791;
 Tue, 04 Feb 2020 02:33:03 -0800 (PST)
MIME-Version: 1.0
References: <1a11e5cd73f6eb999f78981953d39773eb154040.1578492778.git.michal.simek@xilinx.com>
In-Reply-To: <1a11e5cd73f6eb999f78981953d39773eb154040.1578492778.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Tue, 4 Feb 2020 11:32:52 +0100
Message-ID: <CAHTX3d+0BD6kysK89Rge64PSYEFYX=PyNps8aiinT3n+P+xnzQ@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Fix message about compiled-in FDT location
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st 8. 1. 2020 v 15:13 odes=C3=ADlatel Michal Simek <michal.simek@xilinx.com=
> napsal:
>
> %p is not working that early (don't know why)
>
> Before this patch:
> Compiled-in FDT at (ptrval)
>
> After:
> Compiled-in FDT at 0xc043c24c
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/microblaze/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setu=
p.c
> index 522a0c5d9c59..effed14eee06 100644
> --- a/arch/microblaze/kernel/setup.c
> +++ b/arch/microblaze/kernel/setup.c
> @@ -138,7 +138,7 @@ void __init machine_early_init(const char *cmdline, u=
nsigned int ram,
>         if (fdt)
>                 pr_info("FDT at 0x%08x\n", fdt);
>         else
> -               pr_info("Compiled-in FDT at %p\n", _fdt_start);
> +               pr_info("Compiled-in FDT at 0x%08x\n", (unsigned)&_fdt_st=
art);
>
>  #ifdef CONFIG_MTD_UCLINUX
>         pr_info("Found romfs @ 0x%08x (0x%08x)\n",
> --
> 2.24.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
