Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBEF248FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfFQTk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:40:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44223 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFQTkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:40:25 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so23876056iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6WuASPE2mni0guIUkkRtD/52gMjLqr2ZEpRsUR4sK0=;
        b=aLeZkiIRZAsbC3vwrVPw8k/YEEnk6TMdBILNooAcrZfEK6urgpMJ5u9Eq8s1bOnb/Y
         k6nDVLTOgLip52Zhmj14Q+anQTe4dnae727Mc/ilZsSsARO8WHN9SELDR519JPcAfcnO
         LX/mOrjBmPgT3y7N+9sz63DOb1W8CgG5s5ffctFFrs53ndUU641/vruIyiJb7CK5Kn/j
         HeolrvIBNoB0KVQSbFUnXQtVgK17QzwZ70tcmuUBHWfZfQgTuUHSuGDD/slrq2V+Rynf
         PGM/Tw+k9FHiub/A1UweRNgdGJpYR7Njjw6grqwgS53CJTzXG4qcdQnNm0KeXDLN1yaL
         jUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6WuASPE2mni0guIUkkRtD/52gMjLqr2ZEpRsUR4sK0=;
        b=rjC3Tss/n8aP6ZGpvXiit6I7vWScnEvYgQ/fUcB/DbF+5JELiLtQN6o3vt9ChegpSl
         iAoxk17mH5NRsEN0thzSr9bauNUhE7qPuUxfTNH25HQbyhiFHPloxi4YYZaVj/VEDdvZ
         ExEUIqmsbJ1aqM2cmY+f8rWmC3IYHToBdzAy4DKldjTRO7KNVWe9ykfym2BPht166gZL
         Sq2FGVyrX926eeMq34h21lLgn8xx3rPqDO8TYYsps37t2PVfl7iTDJO9O6Ex4rEZMZNe
         s89QC/nXvoXX4OLByKVIvJSLm9hc2P91AjUDgf8kvnKE8xxQJckWYjFoMikszoZgTUPz
         lyQQ==
X-Gm-Message-State: APjAAAX09Bh6hEcC4z04LXRlSWTPnQMugmAAVg2v7a/FYvQihLtNCZCU
        FsTw9G5vD+s8mn1MlYHmi4IFd8xaMxSrtV3KkTZzaA==
X-Google-Smtp-Source: APXvYqxr938YdTE2N+B9Fe98i+hpyur/6wP1TpcTp3sfwG4ulGslieAud5K48nc0OVEFq6C9kYcV0D+/j2dEXFIDLSA=
X-Received: by 2002:a6b:7d49:: with SMTP id d9mr12123502ioq.50.1560800424948;
 Mon, 17 Jun 2019 12:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190617125908.1674177-1-arnd@arndb.de>
In-Reply-To: <20190617125908.1674177-1-arnd@arndb.de>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 17 Jun 2019 13:40:14 -0600
Message-ID: <CANLsYkyraS+1QACrSVMak=CUxtupHcW6=5dODNn3SeyUvqhsMw@mail.gmail.com>
Subject: Re: [PATCH] coresight: platform: add OF/APCI dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 at 06:59, Arnd Bergmann <arnd@arndb.de> wrote:
>
> When neither CONFIG_OF nor CONFIG_ACPI are set, we get a harmless
> build warning:
>
> drivers/hwtracing/coresight/coresight-platform.c:26:12: error: unused function 'coresight_alloc_conns'
>       [-Werror,-Wunused-function]
> static int coresight_alloc_conns(struct device *dev,
>            ^
> drivers/hwtracing/coresight/coresight-platform.c:46:1: error: unused function 'coresight_find_device_by_fwnode'
>       [-Werror,-Wunused-function]
> coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
>
> As the code is useless in that configuration anyway, just add
> a Kconfig dependency that only allows building when at least
> one of the two is set.
>
> This should not hinder compile-testing, as CONFIG_OF can be
> enabled on any architecture.
>
> Fixes: ac0e232c12f0 ("coresight: platform: Use fwnode handle for device search")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hwtracing/coresight/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 5487d4a1abc2..14638db4991d 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -4,6 +4,7 @@
>  #
>  menuconfig CORESIGHT
>         bool "CoreSight Tracing Support"
> +       depends on OF || ACPI

I have applied this - thanks,
Mathieu

>         select ARM_AMBA
>         select PERF_EVENTS
>         help
> --
> 2.20.0
>
