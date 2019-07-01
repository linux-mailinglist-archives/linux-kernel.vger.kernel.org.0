Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9909F4B501
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 11:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbfFSJgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 05:36:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56862 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726826AbfFSJgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:36:21 -0400
X-UUID: c701537368864eecb68e6a1f8a530c0e-20190619
X-UUID: c701537368864eecb68e6a1f8a530c0e-20190619
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 837506052; Wed, 19 Jun 2019 17:36:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 19 Jun 2019 17:36:11 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Jun 2019 17:36:11 +0800
Message-ID: <1560936971.2158.17.camel@mtksdaap41>
Subject: Re: [PATCH v5 09/14] soc: mediatek: Add basic_clk_name to
 scp_power_data
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Wed, 19 Jun 2019 17:36:11 +0800
In-Reply-To: <CANMq1KDf6aCK4+VX070f1pB6knPT5M0kxbW_RJ0K7PtAvKWkLQ@mail.gmail.com>
References: <20190319080140.24055-1-weiyi.lu@mediatek.com>
         <20190319080140.24055-10-weiyi.lu@mediatek.com>
         <CANMq1KDf6aCK4+VX070f1pB6knPT5M0kxbW_RJ0K7PtAvKWkLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-21 at 14:02 +0800, Nicolas Boichat wrote:
> On Tue, Mar 19, 2019 at 4:02 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> >
> > Try to stop extending the clk_id or clk_names if there are
> > more and more new BASIC clocks. To get its own clocks by the
> > basic_clk_name of each power domain.
> >
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > ---
> >  drivers/soc/mediatek/mtk-scpsys.c | 27 +++++++++++++++++++--------
> >  1 file changed, 19 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index 6bf846cb1893..c6360de4e41e 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -118,6 +118,8 @@ static const char * const clk_names[] = {
> >   * @bus_prot_mask: The mask for single step bus protection.
> >   * @clk_id: The basic clock needs to be enabled before enabling certain
> >   *          power domains.
> > + * @basic_clk_name: provide the same purpose with field "clk_id"
> > + *                  by declaring basic clock prefix name rather than clk_id.
> >   * @caps: The flag for active wake-up action.
> >   */
> >  struct scp_domain_data {
> > @@ -128,6 +130,7 @@ struct scp_domain_data {
> >         u32 sram_pdn_ack_bits;
> >         u32 bus_prot_mask;
> >         enum clk_id clk_id[MAX_CLKS];
> > +       const char *basic_clk_name[MAX_CLKS];
> 
> Either call them basic_clk_id/basic_clk_name, or clk_id/clk_name.
> 

OK.

> >         u8 caps;
> >  };
> >
> > @@ -499,16 +502,24 @@ static struct scp *init_scp(struct platform_device *pdev,
> >
> >                 scpd->data = data;
> >
> > -               for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> > -                       struct clk *c = clk[data->clk_id[j]];
> > +               if (data->clk_id[0]) {
> 
> Since it's either clk_id or basic_clk_name, I wonder if it'd be good
> to add a WARN_ON here, e.g.
> 
> WARN_ON(data->basic_clk_name[0]);
> 

Thanks for the advise. I'll add it.

> > +                       for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> > +                               struct clk *c = clk[data->clk_id[j]];
> >
> > -                       if (IS_ERR(c)) {
> > -                               dev_err(&pdev->dev, "%s: clk unavailable\n",
> > -                                       data->name);
> > -                               return ERR_CAST(c);
> > -                       }
> > +                               if (IS_ERR(c)) {
> > +                                       dev_err(&pdev->dev,
> > +                                               "%s: clk unavailable\n",
> > +                                               data->name);
> > +                                       return ERR_CAST(c);
> > +                               }
> >
> > -                       scpd->clk[j] = c;
> > +                               scpd->clk[j] = c;
> > +                       }
> > +               } else if (data->basic_clk_name[0]) {
> > +                       for (j = 0; j < MAX_CLKS &&
> > +                                       data->basic_clk_name[j]; j++)
> > +                               scpd->clk[j] = devm_clk_get(&pdev->dev,
> > +                                               data->basic_clk_name[j]);
> >                 }
> >
> >                 genpd->name = data->name;
> > --
> > 2.18.0
> >


