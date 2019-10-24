Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1CDE3183
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 13:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439485AbfJXLxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 07:53:06 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39204 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfJXLxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:53:04 -0400
Received: by mail-ua1-f66.google.com with SMTP id o25so1805017uap.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 04:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1KiAq2b3z/Z+oO2kUL2b8SkIvQVsNiMUo4648osU6s=;
        b=CPG7f8FL9wOLdK9nhKnhAgR/LLHSeGiIsfemayzM3YOM8k9DvqtDznLrnrK5HaZW34
         WuJ1PDvb7d3Atvp9n5QVciTPz2djxe8E5PYkMZFxeBtYzoQxasezhAivF80vRCYjuHDZ
         Oau45TlDXKUS+xiX+T3OVtKal/X3GH/4RwyLNj5iE5M1lvnSC+E/3fz0ofEtGdT5ZGu6
         Ez+BoOyCsGvk4IMmxp4ga/qiVxvLNNl4q4ERovcOQA+hKf6aBIwFxpf8qZ28vRRpUUcx
         5PaAzGBUbmh+gBHzmGOfXNjEUs/4TTi4rIM3bnGsP0DOTkMj3OcheKRC/H7By+liQp7Y
         m8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1KiAq2b3z/Z+oO2kUL2b8SkIvQVsNiMUo4648osU6s=;
        b=fjFKW4WLzRTB7h3FoONd3kRGLNyj7V1+uLqYimlkLej4s15iPoYiULw87ZdvHOlQWz
         924NxvEMatFzo87EhkSdGQVPc40UCqTknXjflsdpiomEljd0ZFjjr+fz6hu/KFrBKxz0
         u1mxR39qoe8Y+Ap2dsk2B4YsZ/jCAZRoSUNGpFLyYuEzxD+RawkRsTq+Yt5IDBiuInu2
         7DsusKV10JmndCMcto5C3Mqa8pJN+T+695wE3/ZRPqyFhqur08Cb95eCArYIAgpNd79d
         JdqyMmQy/j/VcN8sNGUJsq525843fzQz44HqPvL4ZKMUmLSwSUDzfYsUmqWhYp4flqZC
         6tlA==
X-Gm-Message-State: APjAAAU3/5MJfJ78nNyStT2j34QNdBOuh2IVLbi9rmIwcBJyZI4/ma8V
        WRrlZijCejw336q8wb5cEx0ipYaEkt8SeZdXKtMGJA==
X-Google-Smtp-Source: APXvYqyY6iH8uNxzgTDilZDyz8IFIHovN0BIzfSE7mUMD+SKYWqS0pz2SdLZyWU+lC9L/MycjWutzQj5TgAf2o9qcso=
X-Received: by 2002:ab0:7043:: with SMTP id v3mr8383913ual.84.1571917983366;
 Thu, 24 Oct 2019 04:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191023152634.GA3749@nishad>
In-Reply-To: <20191023152634.GA3749@nishad>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Oct 2019 13:52:52 +0200
Message-ID: <CACRpkdYmE9uQOJzxHBjcFa1mwr6t1G5FJ_fE2aSdKJB1fxEhsg@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: Use the correct style for SPDX License Identifier
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 5:26 PM Nishad Kamdar <nishadkamdar@gmail.com> wrote:

> This patch corrects the SPDX License Identifier style in
> header file related to ethernet driver for Cortina Gemini
> devices. For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used)
>
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46.
>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
