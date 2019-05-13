Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 411C81B309
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 11:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfEMJlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 05:41:08 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:36057 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfEMJlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:41:08 -0400
X-Originating-IP: 83.204.64.206
Received: from windsurf.home (anantes-658-1-8-206.w83-204.abo.wanadoo.fr [83.204.64.206])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 607CE1BF20E;
        Mon, 13 May 2019 09:41:01 +0000 (UTC)
Date:   Mon, 13 May 2019 11:40:59 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at
Subject: Re: [PATCH v1] mtd: rawnand: Add Macronix NAND read retry support
Message-ID: <20190513114059.3934b0bb@windsurf.home>
In-Reply-To: <OF1EDBA487.7723094D-ON482583F9.00297ABF-482583F9.0029E3EE@mxic.com.tw>
References: <1557474062-4949-1-git-send-email-masonccyang@mxic.com.tw>
        <20190510153704.33de9568@windsurf.home>
        <OF1EDBA487.7723094D-ON482583F9.00297ABF-482583F9.0029E3EE@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 13 May 2019 15:37:39 +0800
masonccyang@mxic.com.tw wrote:

> -------------------------------------------------------------------
>  static void macronix_nand_onfi_init(struct nand_chip *chip)
>  {
>           struct nand_parameters *p = &chip->parameters;
>           struct nand_onfi_vendor_macronix *mxic = (void 
> *)p->onfi->vendor;

Why cast to void*, instead of casting directly to struct
nand_onfi_vendor_macronix * ?

Also,  you are dereferencing p->info before checking whether it's NULL
or not.

>           if (!p->onfi ||
>               ((mxic->reliability_func & MACRONIX_READ_RETRY_BIT) == 0))
>                   return;

So, the code should be:

	struct nand_onfi_vendor_macronix *mxic;

	if (!p->onfi)
		return;

	mxic = (struct nand_onfi_vendor_macronix *) p->info->vendor;

	if ((mxic->reliability_func & MACRONIX_READ_RETRY_BIT) == 0)
		return;

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
