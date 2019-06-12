Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB342CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 19:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfFLRCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 13:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbfFLRCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:02:52 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43DD7206BB;
        Wed, 12 Jun 2019 17:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560358971;
        bh=wm+5WcQRfJbnz//CCyMX9+vekrFgXyfxfNrI9oF65uE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=17E6SyeNw6ZnKarS0veB9PZx5/4zF4Yp4MRLZD+59Nj1gd70dPyRErF2J1VkfrNkT
         ncoeqQbdZCODxKeI4zkQ7HKfCc8xS/O//l6oRddEVCxPJPoGrwo/n3KDaNdRqa2pdd
         VYUl7NuxxUiDHf0nG1gJxHdqJruLyPXhP4Q6KUzI=
Received: by mail-qk1-f171.google.com with SMTP id g18so10843458qkl.3;
        Wed, 12 Jun 2019 10:02:51 -0700 (PDT)
X-Gm-Message-State: APjAAAWGnRaGxbjRY/WDnz9ZiKBlCnIr6200BMDuPhW6gvh+nhhGkvu/
        gBOYmYNlzf2yczlI3or42FGYoiJvaI/qIo9DNA==
X-Google-Smtp-Source: APXvYqxn/t5SpdMAOZKVGkLfsgJbeVeWbNLaVCgN9g2E8d6YQWTmTBKgNCoQ/G6XvynII/wN2xt4CKVsW+/qwPEnzAA=
X-Received: by 2002:a05:620a:16c1:: with SMTP id a1mr24460916qkn.269.1560358970567;
 Wed, 12 Jun 2019 10:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190612043258.166048-1-hsinyi@chromium.org> <20190612043258.166048-3-hsinyi@chromium.org>
In-Reply-To: <20190612043258.166048-3-hsinyi@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 12 Jun 2019 11:02:39 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+RTpRkn22RDTQe9De9se3suoM1ZrYH=Nk8aOKZuJLdGg@mail.gmail.com>
Message-ID: <CAL_Jsq+RTpRkn22RDTQe9De9se3suoM1ZrYH=Nk8aOKZuJLdGg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] fdt: add support for rng-seed
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:34 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Introducing a chosen node, rng-seed, which is an entropy that can be
> passed to kernel called very early to increase initial device
> randomness. Bootloader should provide this entropy and the value is
> read from /chosen/rng-seed in DT.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> change log v5->v6:
> * remove Documentation change
> ---
>  drivers/of/fdt.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

I assume this will go thru the arm64 tree.

Reviewed-by: Rob Herring <robh@kernel.org>
