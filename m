Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B481814CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 11:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfHEJLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 05:11:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38891 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbfHEJLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:11:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id h28so57283237lfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 02:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcF0Tf2csoH94nm9DKzCzxCvNAg9jTgP3wKmMSrxdJ0=;
        b=MApQPGimnkQK1YumuVAH57d9GFewJzttBSI4IlwQ/yJIDJRLm/8dLT/w11qpoANUCS
         n640jop+mLHN4B2M8hCyV1s1RVoI6uCnDy2Qi2aj6o04OsN3By99wr2Q1AbFZwEivVEP
         bEpNarqmrqqS0+i3A8W8o/Rtzdl02Q3JGzQLO7qKaIpOD0BEFBfYqj3AJLez5XeGQ581
         iTAjRtwnM4qVQoyVmlTmECKZrLD4w2YvfCcP/981a20pKfyUc32js/CGh1MjVImw3nRT
         y6pA9EFW4hLfWHqizmRsJIShPImlsMhnIIETjHySMG4uB6FMhpSbUkGAxDbFrfFZR4Dn
         fbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcF0Tf2csoH94nm9DKzCzxCvNAg9jTgP3wKmMSrxdJ0=;
        b=TZde91aRc7NoYc/+z4cO1CiBv7dYQ+rgRMoJafjuXa62qgUjy5p9auiwLgGioVfyfn
         ujLT/FpMj093aja1W4S18v6QBQi6r5zbmbdoABgpdSEYbhadcmYdcztBVvS2kJB3wXql
         sFuJbcyGTIdQyYhRHh/kDFl8sn+GG5EweOB+gSmLcPrQ4zUazvpMhJ1zDIKC2ebY5SGX
         jsrlMwgIjcfiDda7Rc4cqQkDt6i5618wrW4rkvj/xIfgYvgt/wXqZmD9j8tFX4kcAsD8
         IEuDfs+cvgltUbb0KGpXe0vUCrgT29jitA3sowxaQKzdX0ORCJnDvciBLDT8ZSgBrCcc
         FPPA==
X-Gm-Message-State: APjAAAVhzhtiL+twIVlDCi8jytWuhBOoqNENNpjzpCKImyXm1gV66Rhg
        IiZ1MgQ+8kbAhhP8iNUL/1aI8qVV819hBioWxd1Qug==
X-Google-Smtp-Source: APXvYqxKN2Q9wjm993pLiTXUE/ZTFSZClxmxBxiSWznvRekHA4AKzry63edPZGGrMCuZQed5S2uahCV2KTY89z9epxY=
X-Received: by 2002:ac2:59d0:: with SMTP id x16mr863981lfn.60.1564996268308;
 Mon, 05 Aug 2019 02:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190721125259.13990-1-hm@bitlabs.co.za> <20190721125259.13990-2-hm@bitlabs.co.za>
In-Reply-To: <20190721125259.13990-2-hm@bitlabs.co.za>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 11:10:56 +0200
Message-ID: <CACRpkdZ0OYt4q3a=kEWswKZ0z779aDFNg8wbm9Tqa+ddgiW3dA@mail.gmail.com>
Subject: Re: [PATCH 2/2] [PATCH] gpio: Explicitly cast from __be16 to unsigned short
To:     Hennie Muller <hm@bitlabs.co.za>, Arnd Bergmann <arnd@arndb.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 2:53 PM Hennie Muller <hm@bitlabs.co.za> wrote:

> cpu_to_be16 returns a __be16 value. This does not break anything
> but does cause sparse to generate unnecessary warnings.
>
> Signed-off-by: Hennie Muller <hm@bitlabs.co.za>
(...)

> -       gbmsg->val = cpu_to_be16(dir << offset);
> -       gbmsg->mask = cpu_to_be16(0x0001 << offset);
> +       gbmsg->val = (__force u16)cpu_to_be16(dir << offset);
> +       gbmsg->mask = (__force u16)cpu_to_be16(0x0001 << offset);

Ugh I don't understand this.

Arnd: you know this better than me: is this the right thing to do
to get rid of sparse warnings from the code?

Yours,
Linus Walleij
