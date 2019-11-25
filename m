Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA784109119
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 16:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfKYPih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 10:38:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33627 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfKYPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:38:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id t5so16438004ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JP9osWIZmD7xoqDPjZq0lxxN1Et7rRHogEF4lRtbdrI=;
        b=ZJwBa6mLAtp4tfcRWLhDowPXNpk2LeIj3uvdB3sxr9+ex1gCr5J6qa0uX7+80oHn7+
         SjhOSxogX9l7fH4YZKdCbpl93wdC5DSoJht5+ivJ7WAqyYKHMg1SvujBXbPKMp7sppMW
         f9APlJXPYCxHa8lF+KeKsIQCkLSBByepqX/MWZoUexGjkVJgsSNHTpEPeimTipW5KFQI
         rniH5+65ZfFmcVzJ5AoMi4KcqR/qdMQoikcHXWhLuwyvm9fsLTUiDtYfhCOxTX//npMo
         Zt71BedVLyaLzMckk+5gQ7z79vUCiNHB1rILlTqhA8inJ1+LS8pbpi6miLMRCjp8haOe
         uxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JP9osWIZmD7xoqDPjZq0lxxN1Et7rRHogEF4lRtbdrI=;
        b=HMTSAaLOiGpMoAc/ennx7/0YYtmseJ+FtQGYs0AVgtz/Z9HDL19UhHVqjT8nNj9nAX
         4saspmVvBZMDVcbJLtU7qU0Ez4k/xKXvThv4Uyv91W+C0XP9IFKjZUhzozzMwlak8kFP
         f+uBGF0PHXzXCum+IYdmSHTZDpw2Sy5J4qjGgEmZhjcgzkkUAo5K44BZNASGYrY/wK63
         Lyu42KDPPL65kgCv2QpgXD9d75dlx4QLQtonntpr3HhqbPqAaH6ASpd/6vWUE+AeIcn4
         ViYotuXpjlypi//tvPxPNGTKnbaONEmIhrBvRBvb7SIG0ZU8+hBELj8TB3DeeFm58CoF
         UzRg==
X-Gm-Message-State: APjAAAXldCADNZpNnr1kHgep42Jauk0CxZmNxRobCYSATDLfYTWtmnUL
        GrNDI06eAkuGCSq2BssWZGPzF3ChB0FZvFLIZInBUg==
X-Google-Smtp-Source: APXvYqzyAnvpCh6lNQuPZXbqWJSpuUAH5SCiLYwyha75J4nb4FqI7D3Bv+YpLUqqexRIevgopcC1EPkPCvxWl0Snjx8=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr2329267ljm.233.1574696314927;
 Mon, 25 Nov 2019 07:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20191125122256.53482-1-stephan@gerhold.net> <20191125122256.53482-3-stephan@gerhold.net>
In-Reply-To: <20191125122256.53482-3-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Nov 2019 16:38:23 +0100
Message-ID: <CACRpkdZ2Ph7X6kP6ngL-K65cx-9q0bfU2ug0Dde1ddEWqJSrFw@mail.gmail.com>
Subject: Re: [PATCH 3/5] ARM: dts: ux500: Add alternative SDI pin configs
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 1:26 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> SDI0/SDI1 can be used in configurations where some of the pins
> (e.g. direction control) are not used. The pinctrl driver has
> separate pin groups for them.
>
> Add new pin configurations for:
>   - mc0_a_2: like mc0_a_1, but without CMDDIR/DAT0DIR/DAT2DIR
>   - mc1_a_2: like mc1_a_1, but without FBCLK
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Patch applied for v5.6

Yours,
Linus Walleij
