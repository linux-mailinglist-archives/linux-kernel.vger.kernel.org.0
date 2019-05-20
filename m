Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5172823669
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 14:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391494AbfETMpu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 May 2019 08:45:50 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:48803 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388920AbfETMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:45:47 -0400
Received: from xps13 (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 6AD63100003;
        Mon, 20 May 2019 12:45:43 +0000 (UTC)
Date:   Mon, 20 May 2019 14:45:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mtd: brcmnand: Make nand-ecc-strength
 and nand-ecc-step-size optional
Message-ID: <20190520144542.05d10e4b@xps13>
In-Reply-To: <1558117914-35807-1-git-send-email-kdasu.kdev@gmail.com>
References: <1558117914-35807-1-git-send-email-kdasu.kdev@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

Kamal Dasu <kdasu.kdev@gmail.com> wrote on Fri, 17 May 2019 14:29:54
-0400:

> nand-ecc-strength and nand-ecc-step-size can be made optional as
> brcmanand driver can support using the nand_base driver detected

      ^ typo                             raw NAND layer

> values.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---

With this addressed:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

>  Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
> index bcda1df..29feaba 100644
> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
> @@ -101,10 +101,10 @@ Required properties:
>                                number (e.g., 0, 1, 2, etc.)
>  - #address-cells            : see partition.txt
>  - #size-cells               : see partition.txt
> -- nand-ecc-strength         : see nand.txt
> -- nand-ecc-step-size        : must be 512 or 1024. See nand.txt
>  
>  Optional properties:
> +- nand-ecc-strength         : see nand.txt
> +- nand-ecc-step-size        : must be 512 or 1024. See nand.txt
>  - nand-on-flash-bbt         : boolean, to enable the on-flash BBT for this
>                                chip-select. See nand.txt
>  - brcm,nand-oob-sector-size : integer, to denote the spare area sector size


Thanks,
Miquèl
