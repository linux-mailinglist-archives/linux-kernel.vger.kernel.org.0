Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C64110323
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 18:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfLCREu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 12:04:50 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37978 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfLCREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:04:50 -0500
Received: by mail-vk1-f196.google.com with SMTP id m128so1279807vkb.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 09:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKEl7qNFIi9X+QXW3XmiWYr6gtYvjeFPeIzark7e3Kc=;
        b=SjVDebo2l6qnq7mYoXHOBDv0TSRRFcvV4BhItzIdS86qcLi/YIVmYbcnMxfknlqYhD
         H52BgHICLzr/0f1O9mYTSo7jipwh5XdXG2e43ThUq/cg5K/QXemoWUoN1FeNo0mJ7jbH
         NbX3nBYGI//sD+fqG/anKzbDV+iTxAlPVbm/OMzcNs7NqScICyX16MbERmNKyg37k6b6
         7ypUIEYiPBPmYNlPgSBSN0mANQvs4b+JZgWjrUVRSN7+oqZSY5Z+qmmnBgf8J0rGztgl
         odsRuDHvduZxdG4alX06JadsjaAZ0e6hbxAWq9Tu4Bv9CU0R7G1vkNXBxt4M9VDoyt+p
         O+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKEl7qNFIi9X+QXW3XmiWYr6gtYvjeFPeIzark7e3Kc=;
        b=CSKgWDcmf7ZRjXv3yvQU7rBr6Q2OlumhFbA7cgzCZ1sIoigMsK4WikPmkl4ppa+7Qx
         GKoYIUzKhk4z6ojknE/IblhXktAvO/JF4quZRso6iPquzFAZdNZy60+J0EcmmzShxmTl
         9oRDyY0Jr88pi88pepRRXSv7ZMCvnKENwlgG7Ll3Ynz0nEyryIYBdcXiUice+wKi3Znx
         LJ5SUS1OMPFG11clLU/a8AeDX7Oin/MaKB8o9kUZsIpsKMnJprS3krO4dD7LhFGurkcK
         7iw4+3u0MpA1voVjY4J8gaPxT4MU6Hxp5Sl+yAxNJ5LR5k0F0B0u+RgS9oJJh8hq0Lsj
         MVvw==
X-Gm-Message-State: APjAAAXaTlf6ATq6JNQgixcW3XX0ojX+a7EGVlBSliUlCUpGaZgHoiyc
        d2S+ICU426X0WTj59mJi3/XHSYwAQO7LkjlSHjdW8A==
X-Google-Smtp-Source: APXvYqwKm8MpMl1siagRD/fOyBMzpEUip8dDd1vpjLe8Sx3Hl6Aa61T3XqlZpKdBWWKGOA+Cc/OEYNbwz3q/Vz2Kliw=
X-Received: by 2002:ac5:c4f8:: with SMTP id b24mr3242890vkl.79.1575392688846;
 Tue, 03 Dec 2019 09:04:48 -0800 (PST)
MIME-Version: 1.0
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org> <1571254641-13626-4-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1571254641-13626-4-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 3 Dec 2019 22:34:37 +0530
Message-ID: <CAHLCerOCt9VBizAHu+y+CmzFmz-ktqCJgcB_NeC3WC4W9YBvAQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] thermal: core: Add late init hook to cooling
 device ops
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 1:07 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> Add a hook in thermal_cooling_device_ops to be called after
> the cooling device has been initialized and registered
> but before binding it to a thermal zone.
>
> In this patch series it is used to hook up a power domain
> to the device pointer of cooling device.
>
> It can be used for any other relevant late initializations
> of a cooling device as well.

Please describe WHY this hook is needed.

> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 13 +++++++++++++
>  include/linux/thermal.h        |  1 +
>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 886e8fa..c2ecb73 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -994,6 +994,19 @@ __thermal_cooling_device_register(struct device_node *np,
>         list_add(&cdev->node, &thermal_cdev_list);
>         mutex_unlock(&thermal_list_lock);
>
> +       /* Call into cdev late initialization if defined */
> +       if (cdev->ops->late_init) {
> +               result = cdev->ops->late_init(cdev);
> +               if (result) {
> +                       ida_simple_remove(&thermal_cdev_ida, cdev->id);
> +                       put_device(&cdev->device);
> +                       mutex_lock(&thermal_list_lock);
> +                       list_del(&cdev->node);
> +                       mutex_unlock(&thermal_list_lock);
> +                       return ERR_PTR(result);
> +               }
> +       }
> +
>         /* Update binding information for 'this' new cdev */
>         bind_cdev(cdev);
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index e45659c..e94b3de 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -125,6 +125,7 @@ struct thermal_cooling_device_ops {
>                            struct thermal_zone_device *, unsigned long, u32 *);
>         int (*power2state)(struct thermal_cooling_device *,
>                            struct thermal_zone_device *, u32, unsigned long *);
> +       int (*late_init)(struct thermal_cooling_device *);
>  };
>
>  struct thermal_cooling_device {
> --
> 2.1.4
>
