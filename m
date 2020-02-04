Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB50151591
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 06:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgBDFy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 00:54:58 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42613 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgBDFy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 00:54:58 -0500
Received: by mail-qk1-f196.google.com with SMTP id q15so16781612qke.9;
        Mon, 03 Feb 2020 21:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7n4zoUIIiZA2ALJJ4mJ57lt2Tcsn0/OESnXuVktsWY=;
        b=iVIquOkE279Q+7leFvYOkIFSqSRBJPoOawRF8kQpKRY1g1IVeYzB53msqcbdBWFHuk
         2VKjw/GtlEhJxzocBgubpF/H/yMargA5Txm2lTb8KCXoviEE+uJp3lC4f+4eqacg0pDq
         NKAdbraEwRWewqIh8YdXUBf/heEP4vlAfXjac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7n4zoUIIiZA2ALJJ4mJ57lt2Tcsn0/OESnXuVktsWY=;
        b=dV9+Cl/9GHw52nTQL3CP9XPx10v12k5r9e6y9TXsKPpfGcYCXiUZRsj7YllJQ+XjTM
         L9jbjyubTrKINjOti1rdZ5A8vRufDB7BibRemv3Z6Ki119fDDgXtjcvrtAh+YRHT1hnf
         1ooOuMHV8Xf03nlVY/tgc+DquNfMrw6RHD3troQ60iA3eJuECtvG5Bsfkd2+znLhc/3B
         KiYY7xxdknrHN+kT9qsDOXCpS0Kb+zWrkY3XG4dyoxNKAxSWhAeYMmHZRUzrAn5EW5Ah
         yNf6y4PQRObEVh6+6BgiMgT6EUcVneDNQ60IKL0vx4SHGc3A9dGzaOfXJorNgW3jyUQg
         V3Rg==
X-Gm-Message-State: APjAAAXNF+ppSWQe6Vt8T6fksbchS3u+cmtlYCBKorxUzRaueaYs5rM/
        eaxhlVLoYN6XUpbi42yElDiAjeWyGba1NSl2UrbQnqMR
X-Google-Smtp-Source: APXvYqzF7uxnpiHtFepL2gYUO8yy3dYQIdv2llaISfPr13fI0OQDLILTDeVHgt8XFYYHzXLAZwTJy/dPVgzXJUE43Ec=
X-Received: by 2002:ae9:e702:: with SMTP id m2mr26659032qka.208.1580795697026;
 Mon, 03 Feb 2020 21:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20200202163939.13326-1-linux@roeck-us.net>
In-Reply-To: <20200202163939.13326-1-linux@roeck-us.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 4 Feb 2020 05:54:44 +0000
Message-ID: <CACPK8XeLWZT-VvuErtz6oE1tv1dhwwOnpZbV7PVr2PxgT2fopA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: tacoma: Enable eMMC controller
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2020 at 16:39, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Enabling emmc without enabling its controller doesn't do any good.
> Enable its controller as well to make it work.
>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks Guenter. The description in aspeed-g6.dtsi changed at some
point and Tacoma was not updated.

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> index ff49ec76fa7c..47293a5e0c59 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> @@ -132,6 +132,10 @@
>         use-ncsi;
>  };
>
> +&emmc_controller {
> +       status = "okay";
> +};
> +
>  &emmc {
>         status = "okay";
>  };

This node is redundant, as it is not disabled in the dtsi.

Andrew, should we add disabled to the emmc node?

Or remove the label completely, and just have emmc_controller?

Cheers,

Joel

> --
> 2.17.1
>
