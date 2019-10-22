Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50AA9E011C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 11:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfJVJuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 05:50:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43377 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJVJuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:50:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id t20so25783798qtr.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1pKTrX81FhdzAfIki4jUWvnUPfKP+6v9OO8kScydDF0=;
        b=A4iePABcqcKzW0Jsx5m5AuKZlAYa/yCwYHjVO5w/VDutR632E6Lxz/yo0TVuKP8dPF
         nf6uiFsM5iWThy3GN4b6JHCH0xniroAcuHBbfuf7/UJQtyaPfsmakkjB/WmNZPbKQQZN
         T1iJgdv2oUgVVgC76UZ05it3fi+1CzGIYHL89j64831ipJPQUJEZPg78Ljs9VL27MZF5
         7liZANuqi3hgFnNCFta6CTX8DmXmQ5qCZTxXUz8xXA81UzZvbHIlvJbUbnnIJDfjslPg
         +ZsOefVGxqCLhEYQDCjT9xCdaYG7QVveloxCD90BJpBz+iR+dn2oewAjKRV+ijQngvXw
         wPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1pKTrX81FhdzAfIki4jUWvnUPfKP+6v9OO8kScydDF0=;
        b=MA2CgYw+4HhSihoRv5WVv+bB3dvHWziyowvIuGaNAtHZoz5Iv6s2lmkl9r0wZjjc4v
         jM3tu2TMbHVuvrEbAWkZglcQI7FK25audWxV0Qmj+xwL15RXrvbiLsXTENJYT1IXIl7/
         FqoSeKUbNDyxBvNgziC+g4kN+w1OCyTSmjBpsVG4qBOStImYC2qG46Ai6yWd8bKzDeDg
         G9zbW5d1ZcakgHlo24IH5KImq52341L0IGdt2+vZycoGiDEV1UZRxw84020Nzc3i+rBU
         qeYNhx/V18qshJD89YhAa7TaxixKfHcKaJSAy0A8vqVlGBxU6tgxKnRrVvLwA9XeHIN5
         1X6Q==
X-Gm-Message-State: APjAAAW32ExKr3tJSJ0naexb6ygkUiF3tC3DcZALRQx4BxOqjYlCLSRj
        s5Yw99buEyfhHGfwXLn2mh4BitN/F4uDujvNb85Dhw==
X-Google-Smtp-Source: APXvYqxx6IMMU/KLJpBeqdNZyGovtZ15fbtBGOuH42hcGgm4DSwsIdzP0uePjQ4jb5Y/93B74xMZ6fQvpLRfKqhI1qs=
X-Received: by 2002:ac8:2ccc:: with SMTP id 12mr2396870qtx.49.1571737811081;
 Tue, 22 Oct 2019 02:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191022102334.67e5d3d1@canb.auug.org.au>
In-Reply-To: <20191022102334.67e5d3d1@canb.auug.org.au>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 22 Oct 2019 15:20:00 +0530
Message-ID: <CAP245DXChLoSUkj49FrYq4HVkcP2pS8=qamWDDUNOg7aygDwpA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the thermal tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resending since Gmail mobile client converts email to HTML)

Hi Stephen,

On Tue, Oct 22, 2019 at 4:53 AM Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
>
> Hi all,
>
> After merging the thermal tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> In file included from drivers/thermal/qcom/tsens-common.c:13:
> drivers/thermal/qcom/tsens-common.c: In function 'tsens_set_interrupt':
> include/linux/regmap.h:87:2: warning: 'index' may be used uninitialized i=
n this function [-Wmaybe-uninitialized]
>    87 |  regmap_field_update_bits_base(field, ~0, val, NULL, false, false=
)
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/thermal/qcom/tsens-common.c:183:6: note: 'index' was declared her=
e
>   183 |  u32 index;
>       |      ^~~~~
> In file included from drivers/thermal/qcom/tsens-common.c:13:
> include/linux/regmap.h:87:2: warning: 'index_clear' may be used uninitial=
ized in this function [-Wmaybe-uninitialized]
>    87 |  regmap_field_update_bits_base(field, ~0, val, NULL, false, false=
)
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/thermal/qcom/tsens-common.c:199:18: note: 'index_clear' was decla=
red here
>   199 |  u32 index_mask, index_clear;
>       |                  ^~~~~~~~~~~
> drivers/thermal/qcom/tsens-common.c:199:6: warning: 'index_mask' may be u=
sed uninitialized in this function [-Wmaybe-uninitialized]
>   199 |  u32 index_mask, index_clear;
>       |      ^~~~~~~~~~
>
> Introduced by commit
>
>   fbfe1a042cfd ("drivers: thermal: tsens: Add interrupt support")
>


What compiler version do you use? Any additional flags to make? I'm
not seeing this, even with W=3D1.

$ make -k -j`nproc` O=3D~/work/builds/build-x86/ allmodconfig
$ touch drivers/thermal/qcom/*
=E2=94=80=E2=94=80=E2=80=A2 amit@matterhorn =E2=80=A2=E2=94=80=E2=94=80=E2=
=94=80(~/.../sources/linux-amit.git) $ make -k
-j`nproc` O=3D~/work/builds/build-x86/
make[1]: Entering directory '/home/amit/work/builds/build-x86'
  GEN     Makefile
scripts/kconfig/conf  --syncconfig Kconfig
  GEN     Makefile
  DESCEND  objtool
  CALL    /home/amit/work/sources/linux-amit.git/scripts/atomic/check-atomi=
cs.sh
  CALL    /home/amit/work/sources/linux-amit.git/scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CHK     kernel/kheaders_data.tar.xz
  CC [M]  drivers/thermal/qcom/tsens.o
  CC [M]  drivers/thermal/qcom/tsens-common.o
  CC [M]  drivers/thermal/qcom/tsens-v0_1.o
  CC [M]  drivers/thermal/qcom/tsens-8960.o
  CC [M]  drivers/thermal/qcom/tsens-v2.o
  CC [M]  drivers/thermal/qcom/tsens-v1.o
  CC [M]  drivers/thermal/qcom/qcom-spmi-temp-alarm.o
  LD [M]  drivers/thermal/qcom/qcom_tsens.o
  Building modules, stage 2.
  MODPOST 7437 modules
Kernel: arch/x86/boot/bzImage is ready  (#3)
  LD [M]  drivers/thermal/qcom/qcom-spmi-temp-alarm.ko
  LD [M]  drivers/thermal/qcom/qcom_tsens.ko
make[1]: Leaving directory '/home/amit/work/builds/build-x86'
