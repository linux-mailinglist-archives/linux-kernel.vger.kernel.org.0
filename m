Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E437B477
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 22:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfG3UnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 16:43:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42831 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfG3UnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:43:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so63385296lje.9;
        Tue, 30 Jul 2019 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeOSOuZCKnuPWQlWTYZc7E94zSZCX6CWgucI8QbC5SI=;
        b=e6vS1VpMx06tzuYWtKIBuNEws8WAi3NUbyIV7c4StbvhwCGhsBL970rim8meTTIkWM
         O6ZmuI6RD5nOFDouzyCl0suxmg6ejTqvmTOZ+VISXnNVogpEdiP0rxFAJ0ecsXi2Mfb8
         RYJ67ZTGVfifqJC41HGloDKUppZCNsWmSQoNs/qEz8anDqTka3u82kUtC6pJgqk2NQoa
         FziK5WeFt3InEumrNWBLewagXXd2Bc4unv/x7zwcBc1A9iDOmunInHHOZlqWMrjvCsqX
         NtLNxGyeH8wrBXwUJqJF8a2hXQltEzL8VbGXsWeS7xYtM4cjZ2mCGG5VenQOWx+CQdZ1
         m9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeOSOuZCKnuPWQlWTYZc7E94zSZCX6CWgucI8QbC5SI=;
        b=YfRnArV0t2YSstLoe53EY23VD44hnWmQLX4YM/f5IMRyZv83/6B0Kh3lEwT2JsEJ3S
         VVJf4EldL3zSR9D/DcScPW3N4Qi69xnHOMrIeAmOM8FtDBCBVpm/Yk4/CgVGS3avitxs
         8w45+XbZsIWVvV6uYRLdiyDRAZc0eQVg2m7WVK6TihsGVg7oK5WIYzphCNpkH5eqlbKX
         er372e8z3WMgwFi2168acxeZ7iIxNO6PJ3rK1fsUh10rbQ9ysdI/h4fJRiX0/9Zdoyv+
         kCuOuy7fq04fGnSMmHfOyXEqoKvrx4uyr4tKzvu/u8Rby+1loZhmI6F5i2IYgjJGhxgA
         33uQ==
X-Gm-Message-State: APjAAAWc1mSiLnDzfRtiU1Ra9WSf9JM5jK1kLYzZV5rISG2Y+UBNf5K6
        tUSszqSbSZzAmmPYWwFFBoI/5hnlwq1NGfFjBO6ckpWW
X-Google-Smtp-Source: APXvYqxGggeM2c8JKjHmE9XbOYkhPz3csWiBXje6H5oE/lVW3Y1DXijh0U7E24nUj8ZS7F/lrjAURo32s+z0BYMNXYg=
X-Received: by 2002:a2e:8650:: with SMTP id i16mr62727650ljj.178.1564519387730;
 Tue, 30 Jul 2019 13:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190730144649.19022-1-dev@pschenker.ch> <20190730144649.19022-16-dev@pschenker.ch>
In-Reply-To: <20190730144649.19022-16-dev@pschenker.ch>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Jul 2019 17:43:12 -0300
Message-ID: <CAOMZO5BqbUzBi5nR33TOpgnR4CFAwxF34m+oKtRZ6rtMaMVu9g@mail.gmail.com>
Subject: Re: [PATCH 15/22] ARM: dts: apalis-imx6: Add some optional I2C devices
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

On Tue, Jul 30, 2019 at 11:57 AM Philippe Schenker <dev@pschenker.ch> wrote:

> +&mipi_csi {
> +       ipu_id = <0>;
> +       csi_id = <1>;
> +       v_channel = <0>;
> +       lanes = <2>;

None of these properties are valid upstream.
