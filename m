Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251084252D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 14:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407129AbfFLMLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 08:11:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42610 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406814AbfFLMLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:11:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id y13so11873548lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 05:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Duu79dpq4xQ4GqJnetl02QLC2/nvLqahgO6AyVV2eW0=;
        b=i68wzTyTJMBYZeU/Uf8aHN3gFbC7lSoRCAZqZl+xhx72QGrEg3gqZ5/y1WcXz+vc9z
         FL6gxN8vFOSjCuJqXkAx9zVf6miod5Aahafo/JHI2RJw/2eez0ZDr7jeu/PJ79VymTvj
         3zzQbwQP5OZnLmuRwfuojhikVBJT1vGDYJSI9c/3KFaes0wXblo5dELdA/xtyE1gFn9z
         FRZcIDktNxleExVJgqFoQYntcptFTRamGrwaCQol0FxU7gCy4pyW/dnBjS+U71GaRy1b
         KNoRbWZNvqk5Vk3nntGu8CUDBKyEVszeEt4R72o/hqK3l8zTzt8VFBhODmKgqk6+COSf
         AAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Duu79dpq4xQ4GqJnetl02QLC2/nvLqahgO6AyVV2eW0=;
        b=Bj3qX3An5yBTiR7n25ylrMF155lxywohWjRCNcyPZg2nUXAgVVroMePSkBW6izqAUl
         ZWGc+nu6YNm506QohS3BsgurOSRcFpmS1uWrQKJuMxThaaYIeLcV2QT2uPXk68AyOZ4g
         LDB2klBFiy1mpogZDWuPreDTzNL2D/3SRJPwi9H02+VgBEcQkdFiBNarLBCZ3aqt78p7
         hBKK5NKzliPA3cbVX/kfZ4V/s0E/dMP30+5CAnA2OaAxMUnNKPmK/vPowDGInPZqPyyR
         ufkCFYRRYyO52c0oK1/ZfMeslpf58H5jxD/PHIr+OZZmi6Gzo9+BW6uDib4pxgF1rQWa
         SnpQ==
X-Gm-Message-State: APjAAAXwJo3wyVE5K9f5w9Wt5dLlb1n+RHGU50LEwdudrred4MLgCJA6
        TYVv3/9Cy859UNsvoIp5h0TRuZAqfooFAkd26GZNIA==
X-Google-Smtp-Source: APXvYqxeSw1G1TV/Mz5WMMi5ca+pxpZ1Zqv2pYg8vcbT68h3rpCYOTh6UCtYKXmOybD0IJolLu2MDJSxPI1hB0SKH8g=
X-Received: by 2002:ac2:598d:: with SMTP id w13mr39539109lfn.165.1560341504411;
 Wed, 12 Jun 2019 05:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190611140940.14357-1-icenowy@aosc.io> <20190611140940.14357-2-icenowy@aosc.io>
In-Reply-To: <20190611140940.14357-2-icenowy@aosc.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 14:11:31 +0200
Message-ID: <CACRpkdaj-VkHaENpSqW32gFYBuLDErzqoKZ-aD4W4htORN_SiA@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: pinctrl: add missing compatible
 string for V3s
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 4:10 PM Icenowy Zheng <icenowy@aosc.io> wrote:

> The pinctrl driver of V3s is already available and used in the kernel,
> but the compatible string of it is forgotten to be added.
>
> Add the missing compatible string.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v2:
> - Add the ACK tag by Maxime and the review tag by Rob.

Patch applied to the pinctrl tree.

Yours,
Linus Walleij
