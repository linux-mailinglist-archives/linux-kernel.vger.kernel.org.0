Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E165F14E7B5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 04:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgAaD4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 22:56:33 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43639 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgAaD4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:56:33 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so4372091qtj.10;
        Thu, 30 Jan 2020 19:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=giaaas3saM7ZnV4c4smX1JcgTAL1YeM8DtaRFKtNHgc=;
        b=crNbZOH9Ed0ABdlKTXB1vBiOXKB7+GjFPPrcykjonbeRhA77dU4D95buRmuSb/HrTf
         lhpOiS4cAAUqZgxGlqbJ+h4wqsWTzf2wpwTyEHHJeDGT2l1kYposPBEuTywoKwmbtOj4
         YAfplw+l3R8Uxp67cX3Khtk28NkYrLFgNldho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=giaaas3saM7ZnV4c4smX1JcgTAL1YeM8DtaRFKtNHgc=;
        b=R1CoVTSBg+GKTPHS7swNpLx92hbAmtrcYzviB2bTDZMcyVShPLWbfIVdKAD+1jJULP
         0OEe3ERDr+rk+bjmkSUsrpKbmrGUcmi1KPBaQCC2yPYAbKcQ/olK04HhVDuwlzSUxGKb
         aZL37UQe6M+fyT//HVznXjJfKwwO+9HoXBCHpKOv3aXPF9RWgPozdj73Cmnm8rJsqtaQ
         p0be4PU8Zg04hzKS5mNo0xSkXLuL6KFV1iDZlGmMb4UOFVmMa3Hpp/c6fSf2R41/pHya
         rFmFTxoyuRMT3JXJgrrGcJXPRorJIAydum97p6UW0yB1F93rYk+zOYDSIEzCZdCX3Y7l
         rEBQ==
X-Gm-Message-State: APjAAAU1pAqKjdhJvuG+NOL7rYn0Vn7znxXzM0HZaCYaHopIibD1bjyi
        9itt/RAvE6NjMSvnR8zM5rChbaseBGqIyVrRg9g=
X-Google-Smtp-Source: APXvYqzuY2q7VtjMI43kwIjVulHF6td/oZnRE/hNAX7gUXypAD+c+GinBXcwLLN5Y0oaVYyv8JfSq5V15f8talvX9lw=
X-Received: by 2002:aed:3b3b:: with SMTP id p56mr8919865qte.234.1580442992161;
 Thu, 30 Jan 2020 19:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20200128011728.4092945-1-vijaykhemka@fb.com>
In-Reply-To: <20200128011728.4092945-1-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 31 Jan 2020 03:56:20 +0000
Message-ID: <CACPK8Xc6TbHLgWO3p7YXJf+jfzNhiGzGsdDwQsQ56ix8sUQGzg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: tiogapass: Add IPMB device
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sai Dasari <sdasari@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020 at 01:17, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Adding IPMB devices for facebook tiogapass platform.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I will merge this through the aspeed tree for 5.7.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index fb7f034d5db2..719c130a198c 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -5,6 +5,7 @@
>
>  #include "aspeed-g5.dtsi"
>  #include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
>
>  / {
>         model = "Facebook TiogaPass BMC";
> @@ -428,6 +429,11 @@
>  &i2c4 {
>         status = "okay";
>         // BMC Debug Header
> +       ipmb0@10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
>  };
>
>  &i2c5 {
> @@ -509,6 +515,11 @@
>  &i2c9 {
>         status = "okay";
>         //USB Debug Connector
> +       ipmb0@10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
>  };
>
>  &pwm_tacho {
> --
> 2.17.1
>
