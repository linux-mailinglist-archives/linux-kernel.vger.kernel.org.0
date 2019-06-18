Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C84A3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfFRORw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 10:17:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45487 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFRORw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:17:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so8626230qkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIkro5hrU4/b+ZJ8bCZA7WiUbQx51ISR475SSot97qs=;
        b=YlLU452/p/6WGpK6x9Mzy8dOHr2pjg/9p9lTXSt0W+Aoj+eAQNzxRjQAxmCnhiSCod
         ZsVzN+tIrqTme8hqu0pTHRqY4hfsTLI/at5goouqC/7HUrPU/20ODR5BV0K4yxP4YpOk
         HgeR5ey0WSyK4G7jx5YkV3Dyxo08W9+CQiwWnyHeMJuQfg45QHB/9QlfSN6VblZWpR/U
         4rOR4FoFQ10h+qe8D7UFc1C+QtLshwyVbkosxwdQD67rqgFyBv+P8BSWK9J0+6axnNFy
         ZjauEl0729Lra1aFOhM2/5GhSmQecRo/oZtBlh1uGC8uCCk/QD95ZzJhkOu4ulWhfhOz
         Q+zA==
X-Gm-Message-State: APjAAAV8MtbVTN5TfGjGafQ89SJbfC1ivTUyveT4WED0ZdUS844WVNcw
        41/iym3k0+rkJuD/D9BayJ37VD9tA5YvR+cZ0LY=
X-Google-Smtp-Source: APXvYqzntezRgQJsDB6MdXKyTQQELUdHVqXy07+y69wIRQiZy4AamsLLj3vnYcM/S0bYkf4RXjn5o5jyNTqzPuC65LY=
X-Received: by 2002:a37:a4d3:: with SMTP id n202mr6522369qke.84.1560867471405;
 Tue, 18 Jun 2019 07:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190618131048.543-1-will.deacon@arm.com>
In-Reply-To: <20190618131048.543-1-will.deacon@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 18 Jun 2019 16:17:35 +0200
Message-ID: <CAK8P3a3phkiL8LFQM_AewMCE0EpQaCTOmgkVJe4x9oV84F4_7g@mail.gmail.com>
Subject: Re: [PATCH] genksyms: Teach parser about 128-bit built-in types
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <dave.martin@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 3:10 PM Will Deacon <will.deacon@arm.com> wrote:
>
> +       { "__int128", BUILTIN_INT_KEYW },
> +       { "__int128_t", BUILTIN_INT_KEYW },
> +       { "__uint128_t", BUILTIN_INT_KEYW },

I wonder if it's safe to treat them as the same type, since
__int128_t and __uint128_t differ in signedness.

If someone exports a symbol with one and changes it to the other, they
would appear to be the same type.

        Arnd
