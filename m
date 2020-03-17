Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C165187871
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 05:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCQEXD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Mar 2020 00:23:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33507 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQEXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 00:23:03 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1jE3kq-0006l6-4D
        for linux-kernel@vger.kernel.org; Tue, 17 Mar 2020 04:23:00 +0000
Received: by mail-wm1-f71.google.com with SMTP id n25so5294995wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 21:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LR2lWYgIayYbanKxoGsZXWtRIFq/icnuafwUCJSqlBY=;
        b=DJ4qIYE7ZefJ9sIynxliiVlfjsre0c8M1tF2U8cP/XTzztej4Rcjfp9prKtUrIaiet
         OBdmCGRui4dXgELj0lautcdANuG0edh1flgxS9tOKFkTcikum0/ygYeC8W+nD/wse9+e
         2KTmzK2vyLRUpYyy2mWcDMH1WdpQgvTCGxXpFeVW0b5LZGitqQbJlBzGsDdeNMtKZycG
         JrvAHzHvNzRj/VoNqcz+VUVpXSjIs/+Z9rkOxAdQ5fqWqajR0n2EpEh7AlDAUEmvvEmh
         k/ZI7hkzLlWgcbwPs+Rz8F8yKVX4xh6TTs5xg3Ov4KnNmrBzRLotaULOTfQK4AjWHRcw
         0M0g==
X-Gm-Message-State: ANhLgQ1guZgxsRy+mMOX4rrkQyHrMyqxyi3g8GhXnFEio2b87MxZKHD9
        Ga3PQdghUuk756r2Nc2FlyWIZJj/yoU6RPc4RtSKXD1ztPFbicZkoukw4W36/Myin5/U6MLIyvM
        O+rcOw7wkzCGZd38LhwbwSplyn4Oj/GlKoHNjPkXBNqR4WeATtyWRHeKQPg==
X-Received: by 2002:a5d:480a:: with SMTP id l10mr3446126wrq.178.1584418979798;
        Mon, 16 Mar 2020 21:22:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtS9xGu/clE7LssO/c1MTX7szfSJuHMsj9Z3gBuclu0wafunqLHCm+rn+msLWfL6mk91VyTZm7sdG3II1XWvOY=
X-Received: by 2002:a5d:480a:: with SMTP id l10mr3446094wrq.178.1584418979572;
 Mon, 16 Mar 2020 21:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <501e8224-e334-0aa8-41c0-8f67552e7069@gmail.com> <20200310033640.14440-1-vicamo@gmail.com>
In-Reply-To: <20200310033640.14440-1-vicamo@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Tue, 17 Mar 2020 12:22:48 +0800
Message-ID: <CAFv23Q=q2N7gyvKrgJZJN04+1YqV=VxP2smm6gxn4oAwx2=QNA@mail.gmail.com>
Subject: Re: [PATCH v2] Input: i8042 - fix the selftest retry logic
To:     You-Sheng Yang <vicamo@gmail.com>
Cc:     Allison Randal <allison@lohutok.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enrico Weigelt <info@metux.net>, linux-input@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        You-Sheng Yang <vicamo.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This v2 fix my issue, too.
Please consider to merge this patch.
Thanks.

You-Sheng Yang <vicamo@gmail.com> 於 2020年3月10日 週二 上午11:37寫道：
>
> From: You-Sheng Yang <vicamo.yang@canonical.com>
>
> It returns -NODEV at the first selftest timeout, so the retry logic
> doesn't work. Move the return outside of the while loop to make it real
> retry 5 times before returns -ENODEV.
>
> BTW, the origin loop will retry 6 times, also fix this.
>
> Signed-off-by: You-Sheng Yang <vicamo.yang@canonical.com>
> ---
>  drivers/input/serio/i8042.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 20ff2bed3917..e8f2004071d4 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -937,25 +937,28 @@ static int i8042_controller_selftest(void)
>  {
>         unsigned char param;
>         int i = 0;
> +       int ret;
>
>         /*
>          * We try this 5 times; on some really fragile systems this does not
>          * take the first time...
>          */
> -       do {
> -
> -               if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
> -                       pr_err("i8042 controller selftest timeout\n");
> -                       return -ENODEV;
> -               }
> +       while (i++ < 5) {
>
> -               if (param == I8042_RET_CTL_TEST)
> +               ret = i8042_command(&param, I8042_CMD_CTL_TEST);
> +               if (ret)
> +                       pr_err("i8042 controller selftest timeout (%d/5)\n", i);
> +               else if (param == I8042_RET_CTL_TEST)
>                         return 0;
> +               else
> +                       dbg("i8042 controller selftest: %#x != %#x\n",
> +                           param, I8042_RET_CTL_TEST);
>
> -               dbg("i8042 controller selftest: %#x != %#x\n",
> -                   param, I8042_RET_CTL_TEST);
>                 msleep(50);
> -       } while (i++ < 5);
> +       }
> +
> +       if (ret)
> +               return -ENODEV;
>
>  #ifdef CONFIG_X86
>         /*
> --
> 2.25.0
>
