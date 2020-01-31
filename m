Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0FE614E982
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 09:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgAaIZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 03:25:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbgAaIZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:25:33 -0500
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6CF2173E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 08:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580459132;
        bh=MWMZ28GeJVLlHXvBwFzIUImYSXTKSSm4m0B/kxjLmk8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mXC3fdgXh/Vjbq/wFDBgMbocboo7kx156GamlPhjQ95A7ICGZ6oFhtba7pv1qn1KL
         d/KwBYUHHFJEnoIokXEyEoMpkKL20hZrHId67A+AvV50ToIApiYgkWYaDtiZCrQRsy
         wmnnEiToC2NNZOpVWqiehhPuu2yHJYpoPajOwYnI=
Received: by mail-lf1-f50.google.com with SMTP id l18so4275631lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 00:25:32 -0800 (PST)
X-Gm-Message-State: APjAAAWjRmfZSy63/YTwYdGmZWwAqovL3fuybAnjQarlZQZsgKNpfvxb
        KZbnxo0dMC+iS1GSGJ/Yub4pT+T77lH3jcuKKS8=
X-Google-Smtp-Source: APXvYqxbwJxX4sGSMViDJFZy4RAn/rjlmFDk9uS9eL0zJtCDe9X4PRPy2vWrCayiFqXxttLFTt0kjC5exzGbTRle/lo=
X-Received: by 2002:ac2:5388:: with SMTP id g8mr4811323lfh.43.1580459130141;
 Fri, 31 Jan 2020 00:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20200130191938.2444-1-krzk@kernel.org> <20200130213839.GW24874@lianli.shorne-pla.net>
In-Reply-To: <20200130213839.GW24874@lianli.shorne-pla.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 31 Jan 2020 09:25:18 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcfpTMr+KGLXCC2Kb5Hz+jSX+6KtCoPS-0qWdk2sazTeQ@mail.gmail.com>
Message-ID: <CAJKOXPcfpTMr+KGLXCC2Kb5Hz+jSX+6KtCoPS-0qWdk2sazTeQ@mail.gmail.com>
Subject: Re: [PATCH] openrisc: configs: Cleanup CONFIG_CROSS_COMPILE
To:     Stafford Horne <shorne@gmail.com>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        openrisc@lists.librecores.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 at 22:38, Stafford Horne <shorne@gmail.com> wrote:
>
> +cc: Masahiro,
>
> On Thu, Jan 30, 2020 at 08:19:38PM +0100, Krzysztof Kozlowski wrote:
> > CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
> > CONFIG_CROSS_COMPILE support").
>
> I see this patch is already in, but does it break 0-day test tools that depend
> on this CONFIG_CROSS_COMPILE setup?  I guess its been in since 2018, so there
> should be no problem.
>
> Can you also help to update "Documentation/openrisc/openrisc_port.rst"?  It
> mentions the build steps are:
>
>     Build the Linux kernel as usual::
>
>         make ARCH=openrisc defconfig
>         make ARCH=openrisc
>
> This now changes, I used to use `make ARCH=openrisc CROSS_COMPILE=or1k-linux-`
> is this still going to work?

All cross compile platforms are being built like this, so I guess
openrisc should not be different. I will send a patch for the doc
update.

Best regards,
Krzysztof
