Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35EF8180E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 04:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgCKDF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 23:05:29 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44611 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbgCKDF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:05:29 -0400
Received: by mail-vs1-f67.google.com with SMTP id u24so375726vso.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 20:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QsfwC4H6t6ROEixmVlWQ2i12Kgy6JWAKzkOg+Tc2lCc=;
        b=BhiMMIR26zdTXqzeD3AOq3MJK4bzbiQ5ftBFlrKuzEU+l672B0mkn5lz8VE6P2D5Cv
         2TEDLAemdZeO2asGATMms+XSrOxs8P4m8MJ3WJBpY3+8uQ+35Ml0wVfu+W42r+Gk7Bmm
         +qSKYMNi+6q9TTf8VVOUu6GePrIWeR+13bjaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QsfwC4H6t6ROEixmVlWQ2i12Kgy6JWAKzkOg+Tc2lCc=;
        b=pQVGc8PNFT90eOEW6dgzSm6jCr7QUlKRUIw88I/klD5ueqvULyc3hGHpN74YYMCjIi
         qrCcrSBXpW67b9T2OjSCybn5knd6fYPeKO0a35nWuGi0/Bg45bBWqihWmwng/mPotsu6
         dOH1S0AU7XVyGp4isacPMvWZdAkA6GBMIx5RchpND3TP3d6PmQkD+ENrp34xQH0Nb7c0
         L07b5CSzo9aRB3J83v2mkLfsMRrqkWKWZJ7ojpXwSR2pcCqPv/AZAETPI+IJZqpS6kvk
         t0DE6KOBrI0+iP3L91cYrWT9lga3IZellrJb+0OZR3IJ0crIAeg0I4TIjEkjvYUzE8V6
         DYYg==
X-Gm-Message-State: ANhLgQ2Ro3I4WY5hfAXuLbaQUHb1fiBlCrm0M/Sb/HgaJgur0uxFsJLB
        ZPvKZ5hubzhe5oQY877OOPd5uJcGEWTFg2SrOuGmcg==
X-Google-Smtp-Source: ADFU+vvXTbSt5W1eHZO4lYWtcGuTtUVfMKtOQ3v6eeY0Gkzn6R4cTAEWDJmGvfR53JwZ2BnuJ/P4hOrLn/MPUAhs7qU=
X-Received: by 2002:a67:fe05:: with SMTP id l5mr687265vsr.186.1583895926603;
 Tue, 10 Mar 2020 20:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <1581910527-1636-1-git-send-email-weiyi.lu@mediatek.com> <1581910527-1636-4-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1581910527-1636-4-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 11 Mar 2020 11:05:15 +0800
Message-ID: <CANMq1KCGFE1umR6Tsb-kd4yQMBOb2AP-dOyW4VYHpWPgtXR5JA@mail.gmail.com>
Subject: Re: [PATCH v12 03/10] soc: mediatek: Add basic_clk_name to scp_power_data
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:35 AM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Try to stop extending the clk_id or clk_names if there are
> more and more new BASIC clocks. To get its own clocks by the
> basic_clk_name of each power domain.
> And then use basic_clk_name strings for all compatibles, instead of
> mixing clk_id and clk_name.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

I had already reviewed the v11, and I think there is no change, so
next time, please keep the Rb tag:

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 138 +++++++++++++-------------------------
>  1 file changed, 45 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index f669d37..db35a28 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -78,34 +78,6 @@
>  #define PWR_STATUS_HIF1                        BIT(26) /* MT7622 */
>  #define PWR_STATUS_WB                  BIT(27) /* MT7622 */
>
> -enum clk_id {
> -       CLK_NONE,
> -       CLK_MM,
> -       CLK_MFG,
> -       CLK_VENC,
> -       CLK_VENC_LT,
> -       CLK_ETHIF,
> -       CLK_VDEC,
> -       CLK_HIFSEL,
> -       CLK_JPGDEC,
> -       CLK_AUDIO,
> -       CLK_MAX,
> -};
> -
> -static const char * const clk_names[] = {
> -       NULL,
> -       "mm",
> -       "mfg",
> -       "venc",
> -       "venc_lt",
> -       "ethif",
> -       "vdec",
> -       "hif_sel",
> -       "jpgdec",
> -       "audio",
> -       NULL,
> -};
> -
>  #define MAX_CLKS       3
>
>  /**
> @@ -116,7 +88,7 @@ enum clk_id {
>   * @sram_pdn_bits: The mask for sram power control bits.
>   * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>   * @bus_prot_mask: The mask for single step bus protection.
> - * @clk_id: The basic clocks required by this power domain.
> + * @basic_clk_name: The basic clocks required by this power domain.
>   * @caps: The flag for active wake-up action.
>   */
>  struct scp_domain_data {
> @@ -126,7 +98,7 @@ struct scp_domain_data {
>         u32 sram_pdn_bits;
>         u32 sram_pdn_ack_bits;
>         u32 bus_prot_mask;
> -       enum clk_id clk_id[MAX_CLKS];
> +       const char *basic_clk_name[MAX_CLKS];
>         u8 caps;
>  };
>
> @@ -411,12 +383,23 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         return ret;
>  }
>
> -static void init_clks(struct platform_device *pdev, struct clk **clk)
> +static int init_basic_clks(struct platform_device *pdev, struct clk **clk,
> +                       const char * const *name)
>  {
>         int i;
>
> -       for (i = CLK_NONE + 1; i < CLK_MAX; i++)
> -               clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> +       for (i = 0; i < MAX_CLKS && name[i]; i++) {
> +               clk[i] = devm_clk_get(&pdev->dev, name[i]);
> +
> +               if (IS_ERR(clk[i])) {
> +                       dev_err(&pdev->dev,
> +                               "get basic clk %s fail %ld\n",
> +                               name[i], PTR_ERR(clk[i]));
> +                       return PTR_ERR(clk[i]);
> +               }
> +       }
> +
> +       return 0;
>  }
>
>  static struct scp *init_scp(struct platform_device *pdev,
> @@ -426,9 +409,8 @@ static struct scp *init_scp(struct platform_device *pdev,
>  {
>         struct genpd_onecell_data *pd_data;
>         struct resource *res;
> -       int i, j;
> +       int i, ret;
>         struct scp *scp;
> -       struct clk *clk[CLK_MAX];
>
>         scp = devm_kzalloc(&pdev->dev, sizeof(*scp), GFP_KERNEL);
>         if (!scp)
> @@ -481,8 +463,6 @@ static struct scp *init_scp(struct platform_device *pdev,
>
>         pd_data->num_domains = num;
>
> -       init_clks(pdev, clk);
> -
>         for (i = 0; i < num; i++) {
>                 struct scp_domain *scpd = &scp->domains[i];
>                 struct generic_pm_domain *genpd = &scpd->genpd;
> @@ -493,17 +473,9 @@ static struct scp *init_scp(struct platform_device *pdev,
>
>                 scpd->data = data;
>
> -               for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> -                       struct clk *c = clk[data->clk_id[j]];
> -
> -                       if (IS_ERR(c)) {
> -                               dev_err(&pdev->dev, "%s: clk unavailable\n",
> -                                       data->name);
> -                               return ERR_CAST(c);
> -                       }
> -
> -                       scpd->clk[j] = c;
> -               }
> +               ret = init_basic_clks(pdev, scpd->clk, data->basic_clk_name);
> +               if (ret)
> +                       return ERR_PTR(ret);
>
>                 genpd->name = data->name;
>                 genpd->power_off = scpsys_power_off;
> @@ -560,7 +532,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_CONN_PWR_CON,
>                 .bus_prot_mask = MT2701_TOP_AXI_PROT_EN_CONN_M |
>                                  MT2701_TOP_AXI_PROT_EN_CONN_S,
> -               .clk_id = {CLK_NONE},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_DISP] = {
> @@ -568,7 +539,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .sta_mask = PWR_STATUS_DISP,
>                 .ctl_offs = SPM_DIS_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
> -               .clk_id = {CLK_MM},
> +               .basic_clk_name = {"mm"},
>                 .bus_prot_mask = MT2701_TOP_AXI_PROT_EN_MM_M0,
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
> @@ -578,7 +549,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_MFG_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
> -               .clk_id = {CLK_MFG},
> +               .basic_clk_name = {"mfg"},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_VDEC] = {
> @@ -587,7 +558,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_VDE_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
> -               .clk_id = {CLK_MM},
> +               .basic_clk_name = {"mm"},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_ISP] = {
> @@ -596,7 +567,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_ISP_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(13, 12),
> -               .clk_id = {CLK_MM},
> +               .basic_clk_name = {"mm"},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_BDP] = {
> @@ -604,7 +575,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .sta_mask = PWR_STATUS_BDP,
>                 .ctl_offs = SPM_BDP_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
> -               .clk_id = {CLK_NONE},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_ETH] = {
> @@ -613,7 +583,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_ETH_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_ETHIF},
> +               .basic_clk_name = {"ethif"},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_HIF] = {
> @@ -622,14 +592,13 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_HIF_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_ETHIF},
> +               .basic_clk_name = {"ethif"},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2701_POWER_DOMAIN_IFR_MSC] = {
>                 .name = "ifr_msc",
>                 .sta_mask = PWR_STATUS_IFR_MSC,
>                 .ctl_offs = SPM_IFR_MSC_PWR_CON,
> -               .clk_id = {CLK_NONE},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>  };
> @@ -644,7 +613,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_DIS_PWR_CON,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
> -               .clk_id = {CLK_MM},
> +               .basic_clk_name = {"mm"},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_VDEC] = {
> @@ -653,7 +622,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_VDE_PWR_CON,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
> -               .clk_id = {CLK_MM, CLK_VDEC},
> +               .basic_clk_name = {"mm", "vdec"},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_VENC] = {
> @@ -662,7 +631,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_VEN_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_MM, CLK_VENC, CLK_JPGDEC},
> +               .basic_clk_name = {"mm", "venc", "jpgdec"},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_ISP] = {
> @@ -671,7 +640,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_ISP_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(13, 12),
> -               .clk_id = {CLK_MM},
> +               .basic_clk_name = {"mm"},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_AUDIO] = {
> @@ -680,7 +649,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_AUDIO_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_AUDIO},
> +               .basic_clk_name = {"audio"},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_USB] = {
> @@ -689,7 +658,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_USB_PWR_CON,
>                 .sram_pdn_bits = GENMASK(10, 8),
>                 .sram_pdn_ack_bits = GENMASK(14, 12),
> -               .clk_id = {CLK_NONE},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_USB2] = {
> @@ -698,7 +666,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_USB2_PWR_CON,
>                 .sram_pdn_bits = GENMASK(10, 8),
>                 .sram_pdn_ack_bits = GENMASK(14, 12),
> -               .clk_id = {CLK_NONE},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_MFG] = {
> @@ -707,7 +674,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_MFG_PWR_CON,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(16, 16),
> -               .clk_id = {CLK_MFG},
> +               .basic_clk_name = {"mfg"},
>                 .bus_prot_mask = BIT(14) | BIT(21) | BIT(23),
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
> @@ -717,7 +684,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = 0x02c0,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(16, 16),
> -               .clk_id = {CLK_NONE},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_MFG_SC2] = {
> @@ -726,7 +692,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = 0x02c4,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(16, 16),
> -               .clk_id = {CLK_NONE},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT2712_POWER_DOMAIN_MFG_SC3] = {
> @@ -735,7 +700,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = 0x01f8,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(16, 16),
> -               .clk_id = {CLK_NONE},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>  };
> @@ -760,7 +724,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = 0x300,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
> -               .clk_id = {CLK_VDEC},
> +               .basic_clk_name = {"vdec"},
>         },
>         [MT6797_POWER_DOMAIN_VENC] = {
>                 .name = "venc",
> @@ -768,7 +732,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = 0x304,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_NONE},
>         },
>         [MT6797_POWER_DOMAIN_ISP] = {
>                 .name = "isp",
> @@ -776,7 +739,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = 0x308,
>                 .sram_pdn_bits = GENMASK(9, 8),
>                 .sram_pdn_ack_bits = GENMASK(13, 12),
> -               .clk_id = {CLK_NONE},
>         },
>         [MT6797_POWER_DOMAIN_MM] = {
>                 .name = "mm",
> @@ -784,7 +746,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = 0x30C,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
> -               .clk_id = {CLK_MM},
> +               .basic_clk_name = {"mm"},
>                 .bus_prot_mask = (BIT(1) | BIT(2)),
>         },
>         [MT6797_POWER_DOMAIN_AUDIO] = {
> @@ -793,7 +755,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = 0x314,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_NONE},
>         },
>         [MT6797_POWER_DOMAIN_MFG_ASYNC] = {
>                 .name = "mfg_async",
> @@ -801,7 +762,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = 0x334,
>                 .sram_pdn_bits = 0,
>                 .sram_pdn_ack_bits = 0,
> -               .clk_id = {CLK_MFG},
> +               .basic_clk_name = {"mfg"},
>         },
>         [MT6797_POWER_DOMAIN_MJC] = {
>                 .name = "mjc",
> @@ -809,7 +770,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = 0x310,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
> -               .clk_id = {CLK_NONE},
>         },
>  };
>
> @@ -834,7 +794,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_ETHSYS_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_NONE},
>                 .bus_prot_mask = MT7622_TOP_AXI_PROT_EN_ETHSYS,
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
> @@ -844,7 +803,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_HIF0_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_HIFSEL},
> +               .basic_clk_name = {"hif_sel"},
>                 .bus_prot_mask = MT7622_TOP_AXI_PROT_EN_HIF0,
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
> @@ -854,7 +813,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_HIF1_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_HIFSEL},
> +               .basic_clk_name = {"hif_sel"},
>                 .bus_prot_mask = MT7622_TOP_AXI_PROT_EN_HIF1,
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
> @@ -864,7 +823,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_WB_PWR_CON,
>                 .sram_pdn_bits = 0,
>                 .sram_pdn_ack_bits = 0,
> -               .clk_id = {CLK_NONE},
>                 .bus_prot_mask = MT7622_TOP_AXI_PROT_EN_WB,
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_FWAIT_SRAM,
>         },
> @@ -881,7 +839,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_CONN_PWR_CON,
>                 .bus_prot_mask = MT2701_TOP_AXI_PROT_EN_CONN_M |
>                                  MT2701_TOP_AXI_PROT_EN_CONN_S,
> -               .clk_id = {CLK_NONE},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT7623A_POWER_DOMAIN_ETH] = {
> @@ -890,7 +847,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_ETH_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_ETHIF},
> +               .basic_clk_name = {"ethif"},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT7623A_POWER_DOMAIN_HIF] = {
> @@ -899,14 +856,13 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_HIF_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_ETHIF},
> +               .basic_clk_name = {"ethif"},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT7623A_POWER_DOMAIN_IFR_MSC] = {
>                 .name = "ifr_msc",
>                 .sta_mask = PWR_STATUS_IFR_MSC,
>                 .ctl_offs = SPM_IFR_MSC_PWR_CON,
> -               .clk_id = {CLK_NONE},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>  };
> @@ -922,7 +878,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_VDE_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
> -               .clk_id = {CLK_MM},
> +               .basic_clk_name = {"mm"},
>         },
>         [MT8173_POWER_DOMAIN_VENC] = {
>                 .name = "venc",
> @@ -930,7 +886,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_VEN_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_MM, CLK_VENC},
> +               .basic_clk_name = {"mm", "venc"},
>         },
>         [MT8173_POWER_DOMAIN_ISP] = {
>                 .name = "isp",
> @@ -938,7 +894,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_ISP_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(13, 12),
> -               .clk_id = {CLK_MM},
> +               .basic_clk_name = {"mm"},
>         },
>         [MT8173_POWER_DOMAIN_MM] = {
>                 .name = "mm",
> @@ -946,7 +902,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_DIS_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
> -               .clk_id = {CLK_MM},
> +               .basic_clk_name = {"mm"},
>                 .bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
>                         MT8173_TOP_AXI_PROT_EN_MM_M1,
>         },
> @@ -956,7 +912,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_VEN2_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_MM, CLK_VENC_LT},
> +               .basic_clk_name = {"mm", "venc_lt"},
>         },
>         [MT8173_POWER_DOMAIN_AUDIO] = {
>                 .name = "audio",
> @@ -964,7 +920,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_AUDIO_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_NONE},
>         },
>         [MT8173_POWER_DOMAIN_USB] = {
>                 .name = "usb",
> @@ -972,7 +927,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_USB_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(15, 12),
> -               .clk_id = {CLK_NONE},
>                 .caps = MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT8173_POWER_DOMAIN_MFG_ASYNC] = {
> @@ -981,7 +935,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_MFG_ASYNC_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = 0,
> -               .clk_id = {CLK_MFG},
> +               .basic_clk_name = {"mfg"},
>         },
>         [MT8173_POWER_DOMAIN_MFG_2D] = {
>                 .name = "mfg_2d",
> @@ -989,7 +943,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_MFG_2D_PWR_CON,
>                 .sram_pdn_bits = GENMASK(11, 8),
>                 .sram_pdn_ack_bits = GENMASK(13, 12),
> -               .clk_id = {CLK_NONE},
>         },
>         [MT8173_POWER_DOMAIN_MFG] = {
>                 .name = "mfg",
> @@ -997,7 +950,6 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>                 .ctl_offs = SPM_MFG_PWR_CON,
>                 .sram_pdn_bits = GENMASK(13, 8),
>                 .sram_pdn_ack_bits = GENMASK(21, 16),
> -               .clk_id = {CLK_NONE},
>                 .bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
>                         MT8173_TOP_AXI_PROT_EN_MFG_M0 |
>                         MT8173_TOP_AXI_PROT_EN_MFG_M1 |
> --
> 1.8.1.1.dirty
