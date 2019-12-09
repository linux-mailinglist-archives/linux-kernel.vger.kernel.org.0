Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E79811679B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 08:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLIHli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 02:41:38 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46508 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLIHli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:41:38 -0500
Received: by mail-vs1-f66.google.com with SMTP id t12so9539335vso.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 23:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1QDiAgOowx6HRyiT2osPzP0rSI4d5md9+jwOOejkvo=;
        b=s3NVtX6kURu+PyFwZMjFwGZvHoOwdPqDkgt0r0Uc5eqwM0wbNWEESnBAcYCC4l6kna
         konqXC9ZYUJhy+JR29mQt/RS88y601JmxFoSKsze7iPPaYQOiYM6YbJZFT8GE7rmxcg1
         GI7UHSwsjb0grFRxZqTcIQZlVclJkH6Pk15vseUp0Gcm2J0JKu9Fa9/RjC0kpBsvtUVa
         55mnDVTjUDUUab6Q8MTuBRny9/dGFld948mz7ql5/DlJbJzNs8Yx0A5sQ32UnDrRn2Wb
         giNdPEZjoCxsfQUInranwDbvx9L5huQCSaCAoJfJqCTXz5uEB0oEOdVgaFzi3kBel0eC
         oL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1QDiAgOowx6HRyiT2osPzP0rSI4d5md9+jwOOejkvo=;
        b=FHP9n/u/TWeQmc/mopDRPLA6gx9po5/u2I2o9qbgS8YMZ2RQA1t0sbU7h35y8dVVT3
         v3P4ivkQIyBKcHbMY3m5qfSunpXrD8sqQqo8CNGOGmsPaycruYEbPF4WRbKeXFBqwxkS
         d+gMch33c2f6pPcNVfQeUzmmAIhmCGzbgK9SvZrOzM3LgrU+UmeN+zGr8c5So8L2BM1H
         rFdONeNj9411cPDxfrTfhaaXP8eNr6hQiIkjhS8ezk6dbJsUPTQywnzkmJftoA5v1AkP
         fn5T7yfhaMuIRecx3tHF/7uoVk86o0QVqVbz7gwOjlxN7vFnnni+ESh2DN778lBwB4EU
         w26g==
X-Gm-Message-State: APjAAAVtlKAp9Zg9KPLqjZuE4tDkY2/TFWPMd78INTzzQD0SWlUHKWon
        J1A7fpfIbSfwMNm+bswvE9ucpS47SxOQMPyg0y8f4Q==
X-Google-Smtp-Source: APXvYqzImd9+0o8PVx6ckMyfhgBW7pKWQCYtJhWF2xAKrdnBAvBrsH+pvduF2u95uXin5tlxM8/kL60XTd0dGUzFdLM=
X-Received: by 2002:a67:f496:: with SMTP id o22mr18951450vsn.9.1575877296642;
 Sun, 08 Dec 2019 23:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com> <20191205071953.121511-2-wvw@google.com>
In-Reply-To: <20191205071953.121511-2-wvw@google.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 9 Dec 2019 13:11:25 +0530
Message-ID: <CAHLCerOFUTrg+sJJVaP0wpRErhDdfNebfM4OAOepH4RfXopvQg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: prevent cooling device with no type to be registered
To:     Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 12:50 PM Wei Wang <wvw@google.com> wrote:
>
> commit 54fa38cc2eda ("thermal: core: prevent zones with no types to be
> registered") added logic to prevent thermal zone with empty type to be
> registered. Similarly, there are APIs that rely on cdev->type.
> This patch prevents cooling device without valid type to be registered.
>
> Signed-off-by: Wei Wang <wvw@google.com>

Looks better now. Thanks.

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d4481cc8958f..974e2d91c30b 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -954,12 +954,22 @@ __thermal_cooling_device_register(struct device_node *np,
>         struct thermal_zone_device *pos = NULL;
>         int result;
>
> -       if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> +       if (!type || !type[0]) {
> +               pr_err("Error: No cooling device type defined\n");
>                 return ERR_PTR(-EINVAL);
> +       }
> +
> +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> +               pr_err("Error: Cooling device name over %d chars: %s\n",
> +                       THERMAL_NAME_LENGTH, type);
> +               return ERR_PTR(-EINVAL);
> +       }
>
>         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> -           !ops->set_cur_state)
> +           !ops->set_cur_state) {
> +               pr_err("Error: Cooling device missing callbacks: %s\n", type);
>                 return ERR_PTR(-EINVAL);
> +       }
>
>         cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
>         if (!cdev)
> @@ -972,7 +982,7 @@ __thermal_cooling_device_register(struct device_node *np,
>         }
>
>         cdev->id = result;
> -       strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
> +       strlcpy(cdev->type, type, sizeof(cdev->type));
>         mutex_init(&cdev->lock);
>         INIT_LIST_HEAD(&cdev->thermal_instances);
>         cdev->np = np;
> --
> 2.24.0.393.g34dc348eaf-goog
>
