Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2902CC591
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 00:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbfJDWBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 18:01:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42899 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbfJDWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:01:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so7924676lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 15:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1bY0KVOLdqaxZzHXVxRASkDbZHI1Jwst64oZBnjbtM=;
        b=puzCLjwO6cuw6xl5Zku8gTUDkG390dIuF7x+3qmfnKTkAIdbGIACO39OXw2l5D3Twv
         fOXpikjHgcdocfNe81UmjYmoyoQsUcvB+luFxSuKQGfNkVM9FUzG40Tqcyz2pBK0AsHm
         lebwFE9FPQcyQByeHaU8f6vaS/J76x+/ghDVg5WLj7ItcDHc9VJsePYNHe0+xc0PdZuN
         7vWDXa6qAOMHNQuXn6rupJkd7MVKoRDhlR3iFR1GEvCf2jCLYICoai7n048mZs3RxAHB
         u37YuDykgMZVc5BEmv+J251rLcSqZQb+9lQ2AlExh12zpdtusPNQBB3Hg3WfvZY920Kl
         ZwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1bY0KVOLdqaxZzHXVxRASkDbZHI1Jwst64oZBnjbtM=;
        b=r3foqFqpL/Fs5IR6tBLsvF6HEMxrdAza5Chw+BUl0Gb0KE8kY9cVs5D1ICioocPN4F
         dd11hr1r9lpGeffM2qXVIc9Zq/RHsvdpl+FhNu/uKOEv32TRGfbj+oh5uqbgc/DU7pBZ
         UpRyw8vekIFyQA8sGJPuuTKWPNZb3khP29aWeyQCccpn7K3klH5aktJunFNe157trO1Y
         5qJnZ1mSZLsl4o2x4PpvBXxysKauCxbhx4K2LKDfL0DszCRJtkwXPvpo1TynDwuO07+r
         C71E3na8ubedRsYgAsx0HvJW385s91LFq2Jy9MDr5+IXdfFLULeFAHwHKmWG2car3JEV
         w0Yw==
X-Gm-Message-State: APjAAAVxTzMLvuh6TfLcopdZ+zGVXmDC6pdTwA1mSFOm+AA+6tyEGOsX
        MN/dEIEGHkBeKtZTNXb/4PbyNtEmjSQMCvOUgHXV8g==
X-Google-Smtp-Source: APXvYqzhZymHpUQVGfeDr5rGaewTboWRXad6eeZ/g+OizIgaKqgd2vXP+EpQoQMWDer74/NYUzOmh59PU8dmZNq/vYw=
X-Received: by 2002:a2e:6e04:: with SMTP id j4mr9429352ljc.99.1570226474469;
 Fri, 04 Oct 2019 15:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191002122825.3948322-1-thierry.reding@gmail.com> <20191002122825.3948322-2-thierry.reding@gmail.com>
In-Reply-To: <20191002122825.3948322-2-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Oct 2019 00:01:03 +0200
Message-ID: <CACRpkdafEeMKDqmqoxk-6FcNBYoJtfUCD4QzTdCR_5hxzHz_OQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: max77620: Do not allocate IRQs upfront
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Timo Alho <talho@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 2:28 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> regmap_add_irq_chip() will try to allocate all of the IRQ descriptors
> upfront if passed a non-zero irq_base parameter. However, the intention
> is to allocate IRQ descriptors on an as-needed basis if possible. Pass 0
> instead of -1 to fix that use-case.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Patch applied.

Yours,
Linus Walleij

Yours,
Linus Walleij
