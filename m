Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9754212252E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 08:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfLQHKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 02:10:10 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39428 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfLQHKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:10:10 -0500
Received: by mail-vs1-f66.google.com with SMTP id p21so5839330vsq.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 23:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KU8CAPtvuhse06hr90b9dQyZJ0RcLzLLBYygDj7RpYE=;
        b=f73+xuTLOhYg447Etp1UGvz0Nw5QbYQTmtQjGZVxXslopSHUazONjxi7qkIDEoiuMa
         sI1WVlVPh2MDC5kEHokvVPJR+B+6gKELl9tClD+ZL3un5yJtW6VIoF2J0PVVVzMLOH5J
         /+hT7Kr1xmmaEHBuvGayiJ+ztJuvD4TFMt/Sl1+EMovL/0g1t6a8ymNQbq1w+X57IIbq
         ik8NtbSobnAYH9ro/5FV3IBRNTNB9nQ3Fi7XnuzYMMFjulS4pJ5GxZ1rBsch30pygzqa
         kvncc1eHKpGisFK/vXwDBacao6TLpXTgpMwqV2+3CkdD/inBZ1+K8gYulqHAbN8Aq6af
         6WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KU8CAPtvuhse06hr90b9dQyZJ0RcLzLLBYygDj7RpYE=;
        b=YGH5XRrnvx1VQ8G6dK/Xz6eAvY14XM6xIwfti5zk1+yyAYHYAYJtZKdcfN5/FJL3gF
         aAnmIYOH5CgEnA1n4N5+qEbFFzAh9a/JlDso4y0fN8H3/B18QoQjm5NCbIQbFG/5gs/d
         T6zKepUFj7csacZMWeQUpLR3Ospkv+xUUT2sTanChvlnfUd0OtpBpz4aT6fOybcyFZrQ
         7Kgu8rmTHsW3UIsYg+Zc4P21rpKQvi19/tbAn0Lg9pUGvTGfFh8UFrHcQ+i+UewmN8p1
         IB4aNOFe8YeS9E3B0kUbJ5JReAKNMFhhim6buBZsgs48JddBKF1/y6Uya+JmlQFe3cVS
         doMw==
X-Gm-Message-State: APjAAAX2zDk7pbvA8d4SGDcLFIslWERPurUyXk4G5MIJ0/GAsrbGyBpJ
        QLJkVbAE//FaDHwibRC7ypxP0Z1jV4gAX3sCXUpgEw==
X-Google-Smtp-Source: APXvYqyZdb+OyBuwMDMu5mBCc6jbO6f6HiU3/QineNXIDOYt6E1TcRXbLb7c9SLxhJNoOdqpcKIR5USqSW1I0wElePM=
X-Received: by 2002:a67:ff82:: with SMTP id v2mr1965241vsq.35.1576566609452;
 Mon, 16 Dec 2019 23:10:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576540906.git.nguyenb@codeaurora.org> <628141610bd44235b0cea04ff110dd4c67027aba.1576540907.git.nguyenb@codeaurora.org>
In-Reply-To: <628141610bd44235b0cea04ff110dd4c67027aba.1576540907.git.nguyenb@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Dec 2019 08:09:32 +0100
Message-ID: <CAPDyKFo3sbq1awpiAr4unYadeYnw04eV54P2UA9k0po-0kWpjQ@mail.gmail.com>
Subject: Re: [<PATCH v1> 1/9] mmc: core: Add a cap to use long discard size
To:     "Bao D. Nguyen" <nguyenb@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>, cang@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 at 03:52, Bao D. Nguyen <nguyenb@codeaurora.org> wrote:
>
> Add MMC_CAP2_MAX_DISCARD_SIZE cap which allows setting the max
> discard size value if needed.
> Setting a high value for the max discard size is to fix an issue where
> some SD cards take a long time to perform the card format.

Can you please explain elaborate on why the SD card takes a long time
to "format"? What goes on and what takes time, etc.

In any case, it looks wrong to add a host cap to solve this problem.

Kind regards
Uffe


>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> ---
>  include/linux/mmc/host.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ba70338..f1a767d 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -348,6 +348,7 @@ struct mmc_host {
>  #define MMC_CAP2_FULL_PWR_CYCLE        (1 << 2)        /* Can do full power cycle */
>  #define MMC_CAP2_HS200_1_8V_SDR        (1 << 5)        /* can support */
>  #define MMC_CAP2_HS200_1_2V_SDR        (1 << 6)        /* can support */
> +#define MMC_CAP2_MAX_DISCARD_SIZE (1 << 8)      /* use max discard, ignoring max_busy_timeout parameter */
>  #define MMC_CAP2_HS200         (MMC_CAP2_HS200_1_8V_SDR | \
>                                  MMC_CAP2_HS200_1_2V_SDR)
>  #define MMC_CAP2_CD_ACTIVE_HIGH        (1 << 10)       /* Card-detect signal active high */
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
