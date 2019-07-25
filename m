Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D56747C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 09:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfGYHIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 03:08:44 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32890 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbfGYHIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:08:44 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so95140710iog.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/NsOOSmmzO3ouZR79VA2X4x5+ipc/g1qgS9k4/NHDuE=;
        b=sgmvkbQdmyOibpBn40shEi7rJ8z75kD/TJw4J/zmBkLGQbBcumdRr/jw7AU4Qe1HdE
         VxOSYas/ddnTitzw7CuPr475G3Iv/U5FkwnNQN0mgC2724Hh4sPiBirLhkRFo3GYU/Ui
         3TYE6l/tPmTYI5DEr22ddxutNfXGWrH90oltRH9pPpJoJ1Rp3LkCgkzjCdNMu+O833sN
         4diqCBqPvG5lAOxqYhneGAN1Ygcm3O1G43SPbl/rjyBgoPpqqe8945BMFpQXZTeKXzJA
         A6wH8/B6SZLbzgdTBFeIu6a6kRvNHBxvvzbp+N/ha+CYO6sT+btaSMT3vMeYhjA9O0eu
         P+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/NsOOSmmzO3ouZR79VA2X4x5+ipc/g1qgS9k4/NHDuE=;
        b=YHwSp4qQQ7OLK/If8jWJBs2x7zLsFAzxrLm20ZOPSyOem2Xo4jmUbMn+pzzvJgVrRp
         rwXaZGERG0H2RLP2G4FE7lDyDc0+wZgN35e28AodskwsVvJkSYMgFwyqxgWE9D1zH+RB
         Z6ZyRBuE55vNYf2PXzXFKCu62GU+JWVwQlyKY+6fWbI+HsnG1HsR6DH5S/LRLCF+EdSa
         2F6Uj5EbWQ3el0OEhHwrzW4CkXE4NeDi5wNfKSm3vGSkYZh3FlETJjlOU6EiIrEHO/zL
         KdvuKS/rXzdpiofypp9CFlhDtPOWZNgPzDEckyMNi41zFNZelEf0LFDtDp34otfjn5NN
         M6qw==
X-Gm-Message-State: APjAAAXHdFeiNLEBKsEuiZxjHP6FEr64rkp2kOeB1tpvTADT3zA74miQ
        sBG173YyvU5IB1+mbSZU9K1WgI8LdBPrMcrRAIA=
X-Google-Smtp-Source: APXvYqxKH4PDW02MjrUEYrsbijTw06dTqNLUnz3NmDR96/L6oWDqsh3jFnolYCCZ/OBRD2LOhaYkBNKDynioFzWimvY=
X-Received: by 2002:a5e:8b43:: with SMTP id z3mr78655086iom.287.1564038523269;
 Thu, 25 Jul 2019 00:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190724150156.28526-1-jeyu@kernel.org>
In-Reply-To: <20190724150156.28526-1-jeyu@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 25 Jul 2019 09:08:32 +0200
Message-ID: <CAMRc=MeZOgY=qHNZf635i1OOnrx6Rh2D1qTSBPQjk_CGrRo-Tg@mail.gmail.com>
Subject: Re: [PATCH] modules: always page-align module section allocations
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Jian Cheng <cj.chengjian@huawei.com>,
        Nadav Amit <namit@vmware.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>, Martin Kaiser <lists@kaiser.cx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 24 lip 2019 o 17:02 Jessica Yu <jeyu@kernel.org> napisa=C5=82(a):
>
> Some arches (e.g., arm64, x86) have moved towards non-executable
> module_alloc() allocations for security hardening reasons. That means
> that the module loader will need to set the text section of a module to
> executable, regardless of whether or not CONFIG_STRICT_MODULE_RWX is set.
>
> When CONFIG_STRICT_MODULE_RWX=3Dy, module section allocations are always
> page-aligned to handle memory rwx permissions. On some arches with
> CONFIG_STRICT_MODULE_RWX=3Dn however, when setting the module text to
> executable, the BUG_ON() in frob_text() gets triggered since module
> section allocations are not page-aligned when CONFIG_STRICT_MODULE_RWX=3D=
n.
> Since the set_memory_* API works with pages, and since we need to call
> set_memory_x() regardless of whether CONFIG_STRICT_MODULE_RWX is set, we
> might as well page-align all module section allocations for ease of
> managing rwx permissions of module sections (text, rodata, etc).
>
> Fixes: 2eef1399a866 ("modules: fix BUG when load module with rodata=3Dn")
> Reported-by: Martin Kaiser <lists@kaiser.cx>
> Reported-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Tested-by: David Lechner <david@lechnology.com>
> Tested-by: Martin Kaiser <martin@kaiser.cx>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
>  kernel/module.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/kernel/module.c b/kernel/module.c
> index 5933395af9a0..cd8df516666d 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -64,14 +64,9 @@
>
>  /*
>   * Modules' sections will be aligned on page boundaries
> - * to ensure complete separation of code and data, but
> - * only when CONFIG_STRICT_MODULE_RWX=3Dy
> + * to ensure complete separation of code and data
>   */
> -#ifdef CONFIG_STRICT_MODULE_RWX
>  # define debug_align(X) ALIGN(X, PAGE_SIZE)
> -#else
> -# define debug_align(X) (X)
> -#endif
>
>  /* If this is set, the section belongs in the init part of the module */
>  #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
> --
> 2.16.4
>

Tested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
