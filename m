Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0798678241
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 01:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfG1XIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 19:08:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39069 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfG1XIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:08:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so56647597ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 16:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O9XQGnluX2xcbDyPaZOiLCfhELVR6ARk9hMIDpP13vM=;
        b=jKcqI13c9E5QyILvaIYgYgRYmaryyYWNEbMQEoOKb37DRDPRNOQ/CmltyhtMOQ2HUS
         fBQywfQcaDwy5p9rj+8V2NNg7KBeis8WehmdgqEW5Hu1ZeboAzu3lDjxHdXHxBbTO7Lx
         wDKj4rAWrziNOZnQyYVQ+4zZKDCfxpONMitQU1nbGcWG7h8+KNIx8WxymkjFgV4uMLNV
         gTq+TsDheRts+0kwZ1pF2AWFFE33LUDfPgNcsfFAF4eoov8vIDeqAwwx4d45q4mUQi9d
         67ctbyLdpbL1YoTtScBd8ekPRHh5pa/7kIj+wl9FXlgCXSCG/6KI47rzPNoSFd7zFwFY
         KPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9XQGnluX2xcbDyPaZOiLCfhELVR6ARk9hMIDpP13vM=;
        b=XyM4OPOidcyEYsMS+p7dr+jyxSG8AEly1W8T4vm9PYYANYc+PEjIp+qzpvCIeLidxk
         jB3TTHTp2fh3KCRHIVZQEec3Xm7IPa4cD2OeUfKVvy7PWaYnotlYTWUzB1yDfpgm5yWs
         gyDgr4Xw6XUmD4L07rVDZz9/qZ+EsfilsSSTfxQKGeQckd0IXnoIpTBN9vVCXtd3DyZY
         6Dw2gSa3Qc2ab4+q+64fFlx4XA27kei/Jf0vs7unQ3GV7XFrHBD0CxScHJbuqJ/hernF
         iN1upQcb/f9OpZQQcxL8jdn48QwW6GlgznM5Pk1UkHoqrJSf2aIswll+PXqB0Z9ZQ5Lu
         IAmQ==
X-Gm-Message-State: APjAAAX/UkC5lYrCWBjbgw283uTA0YAzArpEY+M/GQHlWOR6g6s5Bz4x
        ZeO6cRJH0sfMNQRMf8KQHs0SAyIvurCaPjvcjKo/Ew==
X-Google-Smtp-Source: APXvYqwEW1LqfjiyoWnevFQ68/gbc/RdODkVK1fGIl+hP12fx7TSPrM4zpDWzDWByLH4DWsTBNenxT7LE1B+MwCRLes=
X-Received: by 2002:a2e:8756:: with SMTP id q22mr56865504ljj.108.1564355283784;
 Sun, 28 Jul 2019 16:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <1562668156-12927-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1562668156-12927-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 01:07:52 +0200
Message-ID: <CACRpkdayG1yvCewxRwi3BD-EM-NTXPS80Z5T0WONM3m2u_Yxcg@mail.gmail.com>
Subject: Re: [PATCH 0/5] pinctrl: uniphier: Add some improvements and new settings
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 12:29 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:

> This series adds some improvements and new settings for pin-mux.
>
> Kunihiko Hayashi (5):
>   pinctrl: uniphier: Separate modem group from UART ctsrts group
>   pinctrl: uniphier: Add another audio I/O pin-mux settings for LD20
>   pinctrl: uniphier: Add 4th LD20 MPEG2-TS input pin-mux setting
>   pinctrl: uniphier: Add Pro5 PCIe pin-mux settings
>   pinctrl: uniphier: Fix Pro5 SD pin-mux setting

Looks fine to me.

Masahiro, can I have your ACK/review on these patches?

Yours,
Linus Walleij
