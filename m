Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525F3141B0E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 02:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgASBye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 20:54:34 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36218 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgASBye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:54:34 -0500
Received: by mail-ua1-f67.google.com with SMTP id y3so10326232uae.3;
        Sat, 18 Jan 2020 17:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTozb2zePNKT8aZKd3kD9UXbrPwY+ZsZD84I1bqkZt0=;
        b=NWjlMtnN0AvKVjD4KMk6naHTEcgvwwlzSmdo0s/PGVBqd/r3IAdCXCCzfyMEtE4TKm
         xoqA7l86kOmxSrQeE1AGIXPdl3BIk7TwiFm2pg7ndj4A8I/8L0qUo1MIHlKorK2RCnOq
         O5PEiXjJAvvyByPPSzd/zgBdzhrsR0wkvSemlwP/X3KCL/wXjRlgsBCSUaZ/qU8YSdE+
         n3kirr6onWrpAk6PDiBAK2ElQtHG3RIl1YieE+DGVWsesubKuk6dhIesEDf3sBDP1d2P
         1A3ftOjMAi/ehPlfVlxOSqBMO1yJ1NFeQ9nwtJogAiSy2KBnasNEtMgWjLlsr5NgrXDz
         gwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTozb2zePNKT8aZKd3kD9UXbrPwY+ZsZD84I1bqkZt0=;
        b=F1J/xnjmsghuRLlEwg8ml0tJqre0V4fMidSf3OXHaUSmnEBV7tMZnruIBd5MJ8EQtk
         9EIVvibJDzLLto+XOKbudx0BgE5Oq+4ikap3Sxd4epY0Ijg6F5q32udwnbjl6/RFJ8JX
         gMSQ2F/Z4jHuCWEMGumpIU44GsEKNr+/8z0v7PZSUEtX/TCWHK4DPd6QWvVxHtjk1Rt8
         MpBuNQJOifU4e1YpOKKE9vjbDJl9us9WvKRZWeHYkcgb7uLqSOaflega+aCGUIq58BKT
         6ODfUMnNMfg4JXL6Axj5r7KzOLz1KOsD25MVXlgPFHm7hxrycgmAKEPPM07nAMdLKRTn
         dWIg==
X-Gm-Message-State: APjAAAU+eskva6JKCibJZ3TQuV6lvIqst9lTBRgypPVBpNhGWgrUJtei
        KFXhQReuLrkuztBoi00kDh0/QVrxmQ9eM4wWyFU=
X-Google-Smtp-Source: APXvYqxtngsGGKjZoEgoN8myyqs00BjmykkPdhJ09XS2xV/zyMg8qstOs90MhjIQu6IpDdFhxeRPqKR1muol95z3ShI=
X-Received: by 2002:ab0:30c2:: with SMTP id c2mr28532356uam.8.1579398873157;
 Sat, 18 Jan 2020 17:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20200119001327.29155-1-huobean@gmail.com> <20200119001327.29155-6-huobean@gmail.com>
In-Reply-To: <20200119001327.29155-6-huobean@gmail.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Sun, 19 Jan 2020 07:23:57 +0530
Message-ID: <CAGOxZ538XeHdsTU-TEroSWapoTsMYFt+4OCsW-ke=_fjsEih0w@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] scsi: ufs: Inline two functions into their callers
To:     Bean Huo <huobean@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>, asutoshd@codeaurora.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Can Guo <cang@codeaurora.org>, linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 5:45 AM Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Delete ufshcd_read_power_desc() and ufshcd_read_device_desc(), directly
> inline ufshcd_read_desc() into its callers.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  drivers/scsi/ufs/ufshcd.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 925b31dc3110..5f3b0ad5135a 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -3146,17 +3146,6 @@ static inline int ufshcd_read_desc(struct ufs_hba *hba,
>         return ufshcd_read_desc_param(hba, desc_id, desc_index, 0, buf, size);
>  }
>
> -static inline int ufshcd_read_power_desc(struct ufs_hba *hba,
> -                                        u8 *buf,
> -                                        u32 size)
> -{
> -       return ufshcd_read_desc(hba, QUERY_DESC_IDN_POWER, 0, buf, size);
> -}
> -
> -static int ufshcd_read_device_desc(struct ufs_hba *hba, u8 *buf, u32 size)
> -{
> -       return ufshcd_read_desc(hba, QUERY_DESC_IDN_DEVICE, 0, buf, size);
> -}
>
>  /**
>   * struct uc_string_id - unicode string
> @@ -6493,7 +6482,8 @@ static void ufshcd_init_icc_levels(struct ufs_hba *hba)
>         if (!desc_buf)
>                 return;
>
> -       ret = ufshcd_read_power_desc(hba, desc_buf, buff_len);
> +       ret = ufshcd_read_desc(hba, QUERY_DESC_IDN_POWER, 0,
> +                       desc_buf, buff_len);
>         if (ret) {
>                 dev_err(hba->dev,
>                         "%s: Failed reading power descriptor.len = %d ret = %d",
> @@ -6599,7 +6589,8 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
>                 goto out;
>         }
>
> -       err = ufshcd_read_device_desc(hba, desc_buf, hba->desc_size.dev_desc);
> +       err = ufshcd_read_desc(hba, QUERY_DESC_IDN_DEVICE, 0, desc_buf,
> +                       hba->desc_size.dev_desc);
>         if (err) {
>                 dev_err(hba->dev, "%s: Failed reading Device Desc. err = %d\n",
>                         __func__, err);
> --
> 2.17.1
>


-- 
Regards,
Alim
