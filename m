Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5831B1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 10:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfEMIRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 04:17:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37901 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMIRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:17:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id 14so10081058ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 01:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3idWCwzUMnpA5VwTBF4KebKh5MTaU++zMsYGKtLyqjw=;
        b=sRhqNGMIwjVpO8J652GT4JjZrgW/qp/nzAoi8tq2rczD9C1DkcSMFU2SX6TQTYROQ6
         ZhAM2lraAFVTVBJIanaoEnUKXxhiYU+qTwP9Tc1F+eV/k/aGPbePTHTMKl7f8htIwgZg
         fzMR3AOhKh/Vl2AQlyn9uCZFoqJAxY1CaV3HepkeKVTu3zkLm8c8QviB5vegR2/rJCQt
         4OlwD7z+OoXmN1yx31b9u/i4esjyjmhrWZY+44T8eSg4d/9CUUMCOyOfciKTChSRuayC
         V8CJo9FLsQ2buuOKoaihpqDjgk2QfVCh9H1O7RGIZ2wG5hF7+7bc6ltXnlyolwU0kQA2
         05ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3idWCwzUMnpA5VwTBF4KebKh5MTaU++zMsYGKtLyqjw=;
        b=t+D+zJHsZMqQhsKdu6XuHJBPYhRmQo1LxGe0NVr1upmobyU467OdzE1LubuSkWvPhy
         lXFIxqZIk8ymvFKwHY/NZWRQKh60Kf5ME6yKDuVX3DWbyXb4nmfGcJ/mOv+hfQTPeYuG
         bt0SxXrZ9/b354V8SD28Aj6PbyoNeVR0YQbTGngwXDWuUcyzQxdVRUj85IO4Rx/g4w9A
         xtmia5Kb4jN2CJY+UTYQ/WQ8A9l+bi2KK6sNPe46SeZP+3dXVA195BqIDEloFNaqekC2
         nVljBjMIFGsmidxWxRNFyDxqwicKPsnP/rpNvcdv2ZBw5zQfN6Tmhr8kJvkU8Big9phg
         cSew==
X-Gm-Message-State: APjAAAWMN1EC26LaMqqJEzm8YkqQM2vt4lFvOxJFFqugCBhi37c5xu7h
        27aIzhYhSQOuz49+eG7nwNdYAlSRbVPRD8EwJ85v7w==
X-Google-Smtp-Source: APXvYqxRXHHDn2LeaDGJnCVAP9EZXgovgWlUydeeOk9urC/7nL35rUMNFlPTknI8zMkcX/2DBziWyJKmsDIQO1uxGYo=
X-Received: by 2002:a2e:9a4f:: with SMTP id k15mr8204365ljj.159.1557735424426;
 Mon, 13 May 2019 01:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190513073429.12023-1-lee.jones@linaro.org>
In-Reply-To: <20190513073429.12023-1-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 May 2019 10:16:53 +0200
Message-ID: <CACRpkdZHcrhjQ7VQQU004agf4P6AT194eMaama54H-7L9BDstQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: stmfx: Fix 'warn: unsigned <VAR> is never
 less than zero'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 9:34 AM Lee Jones <lee.jones@linaro.org> wrote:

> smatch warnings:
> drivers/pinctrl/pinctrl-stmfx.c:225 stmfx_pinconf_get() warn: unsigned 'dir' is never less than zero.
> drivers/pinctrl/pinctrl-stmfx.c:228 stmfx_pinconf_get() warn: unsigned 'type' is never less than zero.
> drivers/pinctrl/pinctrl-stmfx.c:231 stmfx_pinconf_get() warn: unsigned 'pupd' is never less than zero.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
