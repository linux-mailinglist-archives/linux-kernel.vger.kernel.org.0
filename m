Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6AF14FD90
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 15:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgBBOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 09:35:33 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43148 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgBBOfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 09:35:32 -0500
Received: by mail-vs1-f68.google.com with SMTP id 7so7291040vsr.10;
        Sun, 02 Feb 2020 06:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZE+Xo98zuPfEJJYc3IqeQRPxedI7zj+vekRKI0XAyw=;
        b=mcWFcyryu3pb908p8t2ntneOZGWX637x+66nF8J6woHFUe8Nfw26wsxiSbrLieqQZf
         u/B7Bv73fme8G/rf4KYLbrJdYkXrq2F1DFiOQciq9P+SRlDN6F4Ry/ySeWMERU3Di0v5
         BYEXlSRbilubviP4KoXvTS4c8ImwmqWC9iYOk9dMsGuAieWURS09EtY8wnhgxXJnwrqq
         HNbQgKsucidqfbOEY+4aseWUiC1tCiurI3vguTqqAGHLRIdAPkBHUUpFDD+FlWH0UiU9
         1IYJywc/l7rmVPf5EyMcK4xM+GfQZl2ru89QJc12JfJJDGo3ZClbJl2OBviUKn1Z9pKG
         jdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZE+Xo98zuPfEJJYc3IqeQRPxedI7zj+vekRKI0XAyw=;
        b=LsgnU8bZ9JIEk2xc/37jNEyYs25uJPCvJw+pYSIz4nHFVyrenJxTMjpliVm9UytzjA
         ugi+B+oMSl06T2ru2EBdz29qthQW+B+AqHMmKzeJX8W/jvjSaift8keVfbvhxk5BYsB7
         0D5z5bZidlNbwLHVV9bYJMSdjfOr43o2+fRGRFWj4GR1bX+JVWzC+dxpT1GjsTprlU/T
         xR2GWXHEBZAcU4kNXTaXRM9kBCN8ecqZzJAsUD8PmUlbsyL7EGBnoQfETV+7AVbkhCCU
         Z13X43NauAJ+BoyJYaqV9EIEid9QVZPc50f6YAMZuQSALi7uIS71UXqubfR38WAs81+T
         yrqg==
X-Gm-Message-State: APjAAAWWwAGCapkUEqkUnFMDsm45iK4Zzvior7ItjgbvTyHPgcso2nER
        9N3eyz6xleQhzqFZE3406Mwxv3J/WT4C10KLOrw=
X-Google-Smtp-Source: APXvYqxZNyOg7XGNhoutzokbnVc5nQbhtV3AlWk76sEbJJ8d09qRGIpzB/q7iLwEM4Rkk0nO84vGVSnjlYvqgh9b+S8=
X-Received: by 2002:a67:fb14:: with SMTP id d20mr11886738vsr.136.1580654131573;
 Sun, 02 Feb 2020 06:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20200129073902.5786-1-stanley.chu@mediatek.com> <20200129073902.5786-2-stanley.chu@mediatek.com>
In-Reply-To: <20200129073902.5786-2-stanley.chu@mediatek.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Sun, 2 Feb 2020 20:04:55 +0530
Message-ID: <CAGOxZ521Vz4EcmWApZLqcDwkwa-XHLFLDx2n1HRht0Pf0fFkmw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] scsi: ufs-mediatek: ensure UniPro is not powered
 down before linkup
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>, asutoshd@codeaurora.org,
        Can Guo <cang@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        andy.teng@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Stanley

On Wed, Jan 29, 2020 at 1:09 PM Stanley Chu <stanley.chu@mediatek.com> wrote:
>
> MediaTek Chipsets can enter proprietary UniPro low-power mode during
> suspend while link is in hibern8 state. Make sure leaving low-power
> mode before every link startup to prevent lockup in any possible error recovery
> path.
>
> In the same time, re-factor related funcitons to improve code readability.
>
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/scsi/ufs/ufs-mediatek.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
> index 53eae5fe2ade..7ac838cc15d1 100644
> --- a/drivers/scsi/ufs/ufs-mediatek.c
> +++ b/drivers/scsi/ufs/ufs-mediatek.c
> @@ -30,6 +30,11 @@
>  #define ufs_mtk_device_reset_ctrl(high, res) \
>         ufs_mtk_smc(UFS_MTK_SIP_DEVICE_RESET, high, res)
>
> +#define ufs_mtk_unipro_powerdown(hba, powerdown) \
> +       ufshcd_dme_set(hba, \
> +                      UIC_ARG_MIB_SEL(VS_UNIPROPOWERDOWNCONTROL, 0), \
> +                      powerdown)
> +
>  static void ufs_mtk_cfg_unipro_cg(struct ufs_hba *hba, bool enable)
>  {
>         u32 tmp;
> @@ -290,6 +295,8 @@ static int ufs_mtk_pre_link(struct ufs_hba *hba)
>         int ret;
>         u32 tmp;
>
> +       ufs_mtk_unipro_powerdown(hba, 0);
> +
>         /* disable deep stall */
>         ret = ufshcd_dme_get(hba, UIC_ARG_MIB(VS_SAVEPOWERCONTROL), &tmp);
>         if (ret)
> @@ -390,9 +397,7 @@ static int ufs_mtk_link_set_hpm(struct ufs_hba *hba)
>         if (err)
>                 return err;
>
> -       err = ufshcd_dme_set(hba,
> -                            UIC_ARG_MIB_SEL(VS_UNIPROPOWERDOWNCONTROL, 0),
> -                            0);
> +       err = ufs_mtk_unipro_powerdown(hba, 0);
>         if (err)
>                 return err;
>
> @@ -413,14 +418,10 @@ static int ufs_mtk_link_set_lpm(struct ufs_hba *hba)
>  {
>         int err;
>
> -       err = ufshcd_dme_set(hba,
> -                            UIC_ARG_MIB_SEL(VS_UNIPROPOWERDOWNCONTROL, 0),
> -                            1);
> +       err = ufs_mtk_unipro_powerdown(hba, 1);
>         if (err) {
>                 /* Resume UniPro state for following error recovery */
> -               ufshcd_dme_set(hba,
> -                              UIC_ARG_MIB_SEL(VS_UNIPROPOWERDOWNCONTROL, 0),
> -                              0);
> +               ufs_mtk_unipro_powerdown(hba, 0);
>                 return err;
>         }
>
> --
> 2.18.0



-- 
Regards,
Alim
