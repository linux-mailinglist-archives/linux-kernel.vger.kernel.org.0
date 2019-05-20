Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25A1A23A12
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 16:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391612AbfETOcB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 May 2019 10:32:01 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:60737 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfETOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:32:00 -0400
X-Originating-IP: 90.88.22.185
Received: from xps13 (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3B8801C001A;
        Mon, 20 May 2019 14:31:52 +0000 (UTC)
Date:   Mon, 20 May 2019 16:31:51 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Christophe Kerello <christophe.kerello@st.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: stm32_fmc2: manage the get_irq error case
Message-ID: <20190520163151.7408b005@xps13>
In-Reply-To: <1556117346-5608-1-git-send-email-fabien.dessenne@st.com>
References: <1556117346-5608-1-git-send-email-fabien.dessenne@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabien,

Fabien Dessenne <fabien.dessenne@st.com> wrote on Wed, 24 Apr 2019
16:49:06 +0200:

> During probe, check the "get_irq" error value.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> index 999ca6a..4aabea2 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -1909,6 +1909,12 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		if (irq != -EPROBE_DEFER)
> +			dev_err(dev, "IRQ error missing or invalid\n");
> +		return irq;
> +	}
> +
>  	ret = devm_request_irq(dev, irq, stm32_fmc2_irq, 0,
>  			       dev_name(dev), fmc2);
>  	if (ret) {


Applied to nand/next.

Thanks,
Miquèl
