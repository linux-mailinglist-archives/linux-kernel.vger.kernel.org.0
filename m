Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8131859762
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 11:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfF1JYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 05:24:11 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:13685 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF1JYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:24:11 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x5S9N5J1024487;
        Fri, 28 Jun 2019 17:23:05 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 81A3434E844D647A2747;
        Fri, 28 Jun 2019 17:23:05 +0800 (CST)
In-Reply-To: <20190628111250.34da11be@xps13>
References: <1561443056-13766-1-git-send-email-masonccyang@mxic.com.tw> <1561443056-13766-3-git-send-email-masonccyang@mxic.com.tw>
        <20190627192609.0965f6d5@xps13> <OFFBD1710A.54AC467B-ON48258427.0023FCA3-48258427.00255B71@mxic.com.tw>
        <20190628094250.1fd84505@xps13> <OFF895B48A.00F391C1-ON48258427.002F8256-48258427.003249E0@mxic.com.tw> <20190628111250.34da11be@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     anders.roxell@linaro.org, bbrezillon@kernel.org,
        broonie@kernel.org, christophe.kerello@st.com,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        dwmw2@infradead.org, jianxin.pan@amlogic.com, juliensu@mxic.com.tw,
        lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, paul@crapouillou.net, paul.burton@mips.com,
        richard@nod.at, robh+dt@kernel.org, stefan@agner.ch,
        vigneshr@ti.com
Subject: Re: [PATCH v4 2/2] dt-bindings: mtd: Document Macronix raw NAND controller
 bindings
MIME-Version: 1.0
X-KeepSent: 450D351D:F05AB6C7-48258427:00335A39;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF450D351D.F05AB6C7-ON48258427.00335A39-48258427.00338DC1@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Fri, 28 Jun 2019 17:23:06 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/06/28 PM 05:23:05,
        Serialize complete at 2019/06/28 PM 05:23:05
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x5S9N5J1024487
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

> > > 
> > > > > > +- interrupts: interrupt line connected to this NAND 
controller
> > > > > > +- clock-names: should contain "ps_clk", "send_clk" and 
> > "send_dly_clk"
> > > > > > +- clocks: should contain 3 entries for the "ps_clk", 
"send_clk" 
> > and
> > > > > > +    "send_dly_clk" clocks 
> > > > > 
> > > > > s/entries/phandles/ ? 
> > > > 
> > > > ?
> > > > as I know that kernel views the phandle values as device tree 
> > structure
> > > > information instead of device tree data and thus does not store 
them 
> > as
> > > > properties. 
> > > 
> > > The bindings have nothing to do with the kernel views. They might
> > > actually be merged in a different project, out of the kernel.
> > > 
> > 
> > if patch to phandle, should we also patch driver to of_xxx_phandle()?
> 
> I don't understand your question. <&clk 1> is a phandle, you already
> use phandles, it's just more precise than the word "entries".

Oops, I misunderstood your meaning.

thanks for your interpretation.
best regards,

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

