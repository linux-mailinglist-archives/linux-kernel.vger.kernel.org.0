Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD067D8A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfHAJdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 05:33:22 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:58668 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHAJdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:33:22 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x719W4wM024336;
        Thu, 1 Aug 2019 17:32:04 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 70BBAA972B9FA8377304;
        Thu,  1 Aug 2019 17:32:05 +0800 (CST)
In-Reply-To: <20190801091310.035bc824@xps13>
References: <1564631710-30276-1-git-send-email-masonccyang@mxic.com.tw> <1564631710-30276-3-git-send-email-masonccyang@mxic.com.tw> <20190801091310.035bc824@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     anders.roxell@linaro.org, bbrezillon@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        juliensu@mxic.com.tw, lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, paul@crapouillou.net,
        paul.burton@mips.com, richard@nod.at, robh+dt@kernel.org,
        stefan@agner.ch, vigneshr@ti.com
Subject: Re: [PATCH v6 2/2] dt-bindings: mtd: Document Macronix raw NAND controller
 bindings
MIME-Version: 1.0
X-KeepSent: 6FA21ABA:C0DF9C78-48258449:00331EB3;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF6FA21ABA.C0DF9C78-ON48258449.00331EB3-48258449.0034600D@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Thu, 1 Aug 2019 17:32:04 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/08/01 PM 05:32:05,
        Serialize complete at 2019/08/01 PM 05:32:05
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com x719W4wM024336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

> > Document the bindings used by the Macronix raw NAND controller.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  Documentation/devicetree/bindings/mtd/mxic-nand.txt | 19 
+++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644 
Documentation/devicetree/bindings/mtd/mxic-nand.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/mxic-nand.txt b/
> Documentation/devicetree/bindings/mtd/mxic-nand.txt
> > new file mode 100644
> > index 0000000..de37d60
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
> > @@ -0,0 +1,19 @@
> > +Macronix Raw NAND Controller Device Tree Bindings
> > +-------------------------------------------------
> > +
> > +Required properties:
> > +- compatible: should be "mxicy,multi-itfc-v009-nand-morph"
> > +- reg: should contain 1 entry for the registers
> > +- interrupts: interrupt line connected to this raw NAND controller
> > +- clock-names: should contain "ps", "send" and "send_dly"
> > +- clocks: should contain 3 phandles for the "ps", "send" and
> > +    "send_dly" clocks
> > +
> > +Example:
> > +
> > +   nand: nand-controller@43c30000 {
> > +      compatible = "mxicy,multi-itfc-v009-nand-morph";
> 
> "mxicy" looks strange to me, I know it has been used in the past and
> cannot be removed, but I don't think it is wise to continue using it
> while your use "mxic" in all your other contributions. I would update
> the prefix to mxic here and fill-in the relevant doc.
> 
> Also, what is nand-morph? I thought we were okay for
> the "-nand-controller" suffix.
> 

I thought there is a node name "nand-controller@43c30000" and the
"-nand-controller" suffix in compatible property seems repeated.

In addition, I would like to indicate it's a multi function controller.

nand-morph means this multi interface controller (multi-itfc) works in
raw NAND controller.

thanks & best regards,
Mason


CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

