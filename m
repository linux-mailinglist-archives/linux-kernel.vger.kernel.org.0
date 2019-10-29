Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7380CE82AB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 08:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfJ2HrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 03:47:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34527 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfJ2HrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:47:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id v3so1355900wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 00:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QL/t4s8oYyoEwjRvdWwn1+QXeN2oYFTHoVrFWP/brZc=;
        b=LyqeUSga6k71OeNBPvq+4QehX6Y8Ls6aPEN7SbV01MeUAl2yuW/kMBBMiXOqRf1Mw8
         atxzwUfggK4xFAVXM56mnRmXWvdqIbP5WaMng2GM6onoKwcQgi96aTWv0ReK0/8cYYZX
         7Up+UbiMgTR+0dDale5j+LabelruOC9Cl1hjhL7/E7Hr7o+jbcIpAYFE5mjJtU5mlu7+
         F/YiS0Zz7M1My2dSS45Nxr+RqwzJ9SOnBOEWpUAOmMHiN2QG2g/c5npaFbC4QN7h4gkk
         A6xyFPHdS3DdDp9OTgqrgXbf5gdjeYk4TVtqNVm/7K3DbgqXPjwIiWLT1Hfw/NKmw8Cc
         pQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QL/t4s8oYyoEwjRvdWwn1+QXeN2oYFTHoVrFWP/brZc=;
        b=PZ5FOwJyAysUcbKZQCOtCemXiIG6CRissjtz9eXOzcR+qZOGG3hW/lWo7Dy8pxyJri
         Wdy4RALEKwXlcN7wtVbE+RxmVn+zCxwwYRPnSmceYM77pBYG/BnYmh/VOCfhj//Wuy+T
         PqIhM7+VJ7UMVyWkcjnDw8Rl9tOvJf82Ygpc8ipbHuIiDK6dmgCnhlsfLdp4ASC5PdDp
         jSre9M8TgX+upAykdH7X718GXeqWyrfSTcBpuDkSyZONIvpE8LgSwTkl4yKegSToE9qJ
         R3+oInWgr1vyEU0MrK7jsD30j57XePN4EZlpn9BJ2w35tOnAPgXO9frN0MASk1FQg3bZ
         rU0A==
X-Gm-Message-State: APjAAAWa9GrXPBLufICt4pQW+AQ4KqhL7TaiGvvGIZKxg5iynJ8aV0Hk
        nlijPvvEBN2jaB4L0nsucVRxSpKokzTgGz/RjIPlkw==
X-Google-Smtp-Source: APXvYqwu+5kNM2vsauI6RJYqxigG/JZTD84blgv9rKnBvwKkfn+X4kP0j+KgIxfY/to+sAtOuw95AbutLfqR2x5m6ZM=
X-Received: by 2002:a7b:c925:: with SMTP id h5mr2413014wml.61.1572335228112;
 Tue, 29 Oct 2019 00:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191029060432.1208859-1-bjorn.andersson@linaro.org>
In-Reply-To: <20191029060432.1208859-1-bjorn.andersson@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 29 Oct 2019 08:46:56 +0100
Message-ID: <CAKv+Gu--4h4gup97XkBz2P5SMXyOay5e5OoE1RYsnodyx==CfQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: cpufeature: Enable Qualcomm erratas
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 at 07:04, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> With the introduction of 'cce360b54ce6 ("arm64: capabilities: Filter the
> entries based on a given mask")' the Qualcomm erratas are no long
> applied.
>
> The result of not applying errata 1003 is that MSM8996 runs into various
> RCU stalls and fails to boot most of the times.
>
> Give both 1003 and 1009 a "type" to ensure they are not filtered out in
> update_cpu_capabilities().
>
> Fixes: cce360b54ce6 ("arm64: capabilities: Filter the entries based on a given mask")
> Cc: stable@vger.kernel.org
> Reported-by: Mark Brown <broonie@kernel.org>
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

FYI the offending commit is now queued up for 4.14 as well.

> ---
>  arch/arm64/kernel/cpu_errata.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index df9465120e2f..cdd8df033536 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -780,6 +780,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>         {
>                 .desc = "Qualcomm Technologies Falkor/Kryo erratum 1003",
>                 .capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
> +               .type = ARM64_CPUCAP_SCOPE_LOCAL_CPU,
>                 .matches = cpucap_multi_entry_cap_matches,
>                 .match_list = qcom_erratum_1003_list,
>         },
> @@ -788,6 +789,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>         {
>                 .desc = "Qualcomm erratum 1009, ARM erratum 1286807",
>                 .capability = ARM64_WORKAROUND_REPEAT_TLBI,
> +               .type = ARM64_CPUCAP_SCOPE_LOCAL_CPU,
>                 ERRATA_MIDR_RANGE_LIST(arm64_repeat_tlbi_cpus),
>         },
>  #endif
> --
> 2.23.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
