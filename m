Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0E9E8A58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 15:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389080AbfJ2OMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 10:12:05 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37942 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfJ2OMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:12:05 -0400
Received: by mail-vs1-f68.google.com with SMTP id b123so8816328vsb.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtktdibe6gBkHP4tPalXgDCM43ByFj/zHBOZyxypx60=;
        b=Qvlup8zh+vLsFrMkO5ZeuRaMLG8t9uMEwxGgfA94WDokIhbNSmVCtyY5vd1PLlUONQ
         hddCB9BL5rtyItUiFyH1HY4b9YOYbr8vntDY1XeFHIRvVoonKG8VsFvqpT2EfV2h9x9Z
         i0se1YYEoWyyXwb96308pcLUbl9QKmC6Sf1vRj1Nlzct1OcLSw/WLAkyBrczUB75lWW/
         LLLUfaDOyIJSjqUR3bcNYEYIiPFplhimNhZ/bYg1v4OYMeAFz17lv9i1SiNQ8Luq8Z/H
         WJUxOtuWg21TvkLrZbc/vThifzfQdFa63F/R1G74iOsmJ06i8uHoxw65zf9ZAkUbOU6m
         VoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtktdibe6gBkHP4tPalXgDCM43ByFj/zHBOZyxypx60=;
        b=am9WBXyJtmBBrwhNLv9yg7gJAr+hPhYdlEI7WdHWvSmpp2BkTMy2dJ93Ts37D33rq7
         /MWjV5fRHKxG/+y6AROsktBbC+6Pk+Qokg/q26Ovs8p9Vq6F2HEz4yb7tkTkHGzhwmHj
         oVt10NRDKTF9wwOK8CzqVFF/MzLazhF1N3QXiL+oH7BulhpUHFlYFB7S/GebCE0/803X
         FS2/QB3DE9mCrPbrXDrFLdBmAZmMLdshotQ2yrqWP0S/MBElLCyihh9R3klwVJ3oR3Om
         8Gme3b24IusQtgHUG5hDm0B11e/sDkk6TsvgKD/rXtYcc7D6mMNSKrFFHgD5iTJadUlw
         u77g==
X-Gm-Message-State: APjAAAVLcl+bVdTHaQk/NjBTjFDPGj/iYmw2NrOMHZBpXaSGdJS7F6tB
        IBAU9DgHrTeNi8aJTTpmg4HufEIKOOO+9DmHwN74iw==
X-Google-Smtp-Source: APXvYqx7ASj2tpxKnJFCPomdz3ErcWX3mA9SxsCo3/V2wa1imgq/JhXcbzExPy2tHa2a7tITSN4nUS0fO3+VSrk8K5Q=
X-Received: by 2002:a67:2e11:: with SMTP id u17mr1866632vsu.84.1572358324433;
 Tue, 29 Oct 2019 07:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191021064413.19840-1-manivannan.sadhasivam@linaro.org> <20191021064413.19840-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20191021064413.19840-3-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Oct 2019 15:11:53 +0100
Message-ID: <CACRpkdbQH+=ZMLeZ_uO14=XgadgKr0ogT9S4vTXNosjKT14MnA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ARM: dts: Add RDA8810PL GPIO controllers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-unisoc@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 8:44 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add GPIO controllers for RDA8810PL SoC. There are 4 GPIO controllers
> in this SoC with maximum of 32 gpios. Except GPIOC, all controllers
> are capable of generating edge/level interrupts from first 8 lines.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
