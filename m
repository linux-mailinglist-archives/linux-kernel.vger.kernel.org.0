Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D35114FF89
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 23:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgBBWMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 17:12:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37181 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgBBWMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 17:12:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so5061686plz.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 14:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbital-systems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGQujRAgaDCf8lJCNDZ0S36AK7TctHowW4/wCL3R4dg=;
        b=HdW1c905Bz2Z2DS7cOn6zroCHdRDeXojwk2e0seH6xlDO6tAO/ri7zZXE05NUITROg
         Z0hQillklyLwxAGFOpERzghSqwKkauHgA+4Av4o/iPU0AqgIhKXz28b+QbG2x+xgDX2k
         1I4s4eVPpmwb3MM1g227jrjnSGC+TqxZztqafuxzulfIHmyQ4ULJFwcr1VRp1C1MRpLz
         grrksSmJ2IQ5hRIQ7uc2ikk7Ni4Ra+n0Z7dPLMXR4+CdyZexJeDgRjMh36aUYT8RlHhv
         N75ylMhjuKI8nWiUL+JWvt4AfUCewSsMCddecKx90xuOs2Fzs99zKDzYZf6dfC2nDcoB
         n3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGQujRAgaDCf8lJCNDZ0S36AK7TctHowW4/wCL3R4dg=;
        b=jaTEmTZce8JPCZYeYUGiMy/SQIk/MbVZG6HRZDo2XBpCuOXuAWm2tGxGXaFRKHD4eF
         IW4MBqOGldMsmw+u9sJ2KMbitny7HSVUPFKcd5gUzJsWtEqh58MQAVE0qPwGHCQ5C8Db
         r28TtkiAjseB5mpCHDUgf5vC7sPz9OZTzb2bArVx4H10+NPwdcPRvTeMkMbyFvizDIWR
         3j/7M5+putq/sqJVMApFpUuh88jFm4B24bxtvjlMLJBZvhTGJMqWA6Qi/zlQq9hcFg0g
         n7Aql7Yd5/0TVedjFQKFDW+7ODjKGuC1OKT0KbjUbdeKGIxSsp1ABXzqQGkY/TCk/jtu
         TEzQ==
X-Gm-Message-State: APjAAAXfEzenf+EwgRnJYeLWo78TIn/dqFhue4WdWqKMGbp2SRjPKeIY
        kIERiMxEdOYiyC+F5ZGyeEx8nJTHe0NLklSPvPbxgQ==
X-Google-Smtp-Source: APXvYqwuZRX0UT3wa8X9jm8Y4XzaTT+3vbqhAk3UY+ZiY+WRi8fgQ9CSG7DUjsBa092FHDeMrmIfiHnwsfzyyiw1TWQ=
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr20319259plb.202.1580681550270;
 Sun, 02 Feb 2020 14:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20200202150049.677553-1-jonas@threetimestwo.org>
In-Reply-To: <20200202150049.677553-1-jonas@threetimestwo.org>
From:   Jonas Danielsson <jonas@orbital-systems.com>
Date:   Sun, 2 Feb 2020 23:12:19 +0100
Message-ID: <CALDOjzjf9NwcYwSRbHo4SpFhgCt+Y2r_UnWJQcLqNrRZ3UDdug@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Add error injection via debugfs
To:     linux-mmc@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 2, 2020 at 4:01 PM Jonas Danielsson
<jonas@orbital-systems.com> wrote:
>
> From: Jonas Danielsson <jonas@orbital-systems.com>
>
> This functionality was useful for us while debugging issues with
> a vendor wifi-driver that misbehaved on the SDIO bus.
>
> This will allow you to check how SDIO clients handle mmc
> command and data errors.
>
> Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
> ---
>  drivers/mmc/host/atmel-mci.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index a9dad641c..11289c8e5 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -328,6 +328,8 @@ struct atmel_mci {
>         u32                     data_status;
>         u32                     stop_cmdr;
>
> +       bool force_cmd_error;
> +       bool force_data_error;
>         struct tasklet_struct   tasklet;
>         unsigned long           pending_events;
>         unsigned long           completed_events;
> @@ -618,6 +620,14 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
>         if (!node)
>                 goto err;
>
> +       node = debugfs_create_bool("force_cmd_error", 644, root, &host->force_cmd_error);
> +       if (!node)
> +               goto err;
> +
> +       node = debugfs_create_bool("force_data_error", 644, root, &host->force_data_error);
> +       if (!node)
> +               goto err;
> +
>         node = debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
>         if (!node)
>                 goto err;
> @@ -1807,7 +1817,12 @@ static void atmci_tasklet_func(unsigned long priv)
>                                  * If there is a command error don't start
>                                  * data transfer.
>                                  */
> -                               if (mrq->cmd->error) {
> +                               if (mrq->cmd->error || host->force_cmd_error) {
> +                                       if (host->force_cmd_error) {
> +                                               dev_info(&host->pdev->dev, "FSM: forced cmd error!\n");
> +                                               host->force_cmd_error = false;
> +                                               mrq->cmd->error = -EINVAL;
> +                                       }
>                                         host->stop_transfer(host);
>                                         host->data = NULL;
>                                         atmci_writel(host, ATMCI_IDR,
> @@ -1939,7 +1954,11 @@ static void atmci_tasklet_func(unsigned long priv)
>                         atmci_writel(host, ATMCI_IDR, ATMCI_TXRDY | ATMCI_RXRDY
>                                            | ATMCI_DATA_ERROR_FLAGS);
>                         status = host->data_status;
> -                       if (unlikely(status)) {
> +                       if (unlikely(status) || host->force_data_error) {
> +                               if (data && host->force_data_error) {
> +                                       dev_info(&host->pdev->dev, "FSM: forced data error!\n");
> +                                       host->force_data_error = false;
> +                               }
>                                 host->stop_transfer(host);
>                                 host->data = NULL;
>                                 if (data) {
> @@ -2519,6 +2538,7 @@ static int atmci_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         host->pdev = pdev;
> +       host->force_data_error = host->force_cmd_error = false;
>         spin_lock_init(&host->lock);
>         INIT_LIST_HEAD(&host->queue);
>
> --
> 2.23.0
>

Haha, I just noticed that this is available from the general fault
injection framework. So sorry for the noise!
