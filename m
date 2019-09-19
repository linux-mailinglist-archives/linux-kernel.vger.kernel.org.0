Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8F2B7CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 16:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbfISOef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 10:34:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60774 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732082AbfISOef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:34:35 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8JEXe2Y028567;
        Thu, 19 Sep 2019 09:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568903620;
        bh=3hWAzQBM44NiooNx2UDD2G0o6OnQ7ufrB9rlUJiQznU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FTkM871POjpB2V/MidnKMkHV/yuwzTF3OaC1byDeyAEInNV/O4vFeg5/hMNA7pF9L
         UYKMyvfdq7OoMiI4tGTkyJj7WB0Ew4f+wKLqF8a0MkPm3c7wRM6GYcA8UC3O/7Crbs
         VaS5W2CSoelQS2h+77ZHgfmnJTJmpFAs+v3GAWJw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8JEXefC069798;
        Thu, 19 Sep 2019 09:33:40 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 19
 Sep 2019 09:33:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 19 Sep 2019 09:33:40 -0500
Received: from [10.250.132.15] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8JEXYtc011335;
        Thu, 19 Sep 2019 09:33:35 -0500
Subject: Re: [PATCH 17/23] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
 <20190917155426.7432-18-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <dceca616-2b98-9bc8-73e4-32fb06fc753d@ti.com>
Date:   Thu, 19 Sep 2019 20:03:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190917155426.7432-18-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor

[...]

On 17-Sep-19 9:25 PM, Tudor.Ambarus@microchip.com wrote:
> +static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 status_new,
> +					    u8 mask)
> +{
> +	int ret;
> +	u8 *sr_cr = nor->bouncebuf;
> +	u8 cr_written;
> +
> +	/* Make sure we don't overwrite the contents of Status Register 2. */
> +	if (!(nor->flags & SNOR_F_NO_READ_CR)) {

Assuming SNOR_F_NO_READ_CR is not set...

> +		ret = spi_nor_read_cr(nor, &sr_cr[1]);
> +		if (ret)
> +			return ret;
> +	} else if (nor->flash.quad_enable) {
> +		/*
> +		 * If the Status Register 2 Read command (35h) is not
> +		 * supported, we should at least be sure we don't
> +		 * change the value of the SR2 Quad Enable bit.
> +		 *
> +		 * We can safely assume that when the Quad Enable method is
> +		 * set, the value of the QE bit is one, as a consequence of the
> +		 * nor->flash.quad_enable() call.
> +		 *
> +		 * We can safely assume that the Quad Enable bit is present in
> +		 * the Status Register 2 at BIT(1). According to the JESD216
> +		 * revB standard, BFPT DWORDS[15], bits 22:20, the 16-bit
> +		 * Write Status (01h) command is available just for the cases
> +		 * in which the QE bit is described in SR2 at BIT(1).
> +		 */
> +		sr_cr[1] = CR_QUAD_EN_SPAN;
> +	} else {
> +		sr_cr[1] = 0;
> +	}
> +

CR_QUAD_EN_SPAN will not be in sr_cr[1] when we reach here. So code
won't enable quad mode.


> +	sr_cr[0] = status_new;
> +
> +	ret = spi_nor_write_sr(nor, sr_cr, 2);
> +	if (ret)
> +		return ret;
> +
> +	cr_written = sr_cr[1];
> +
> +	ret = spi_nor_read_sr(nor, &sr_cr[0]);
> +	if (ret)
> +		return ret;
> +
> +	if ((sr_cr[0] & mask) != (status_new & mask)) {
> +		dev_err(nor->dev, "Read back test failed\n");
> +		return -EIO;
> +	}
> +
> +	if (nor->flags & SNOR_F_NO_READ_CR)
> +		return 0;
> +
> +	ret = spi_nor_read_cr(nor, &sr_cr[1]);
> +	if (ret)
> +		return ret;
> +
> +	if (cr_written != sr_cr[1]) {
> +		dev_err(nor->dev, "Read back test failed\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +

Regards
Vignesh
