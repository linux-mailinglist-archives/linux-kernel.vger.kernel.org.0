Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1353269B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 04:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfFCC10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 22:27:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:62896 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725965AbfFCC1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 22:27:25 -0400
X-UUID: 09855579fe6449a79b62bcff16a04d23-20190603
X-UUID: 09855579fe6449a79b62bcff16a04d23-20190603
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 659888550; Mon, 03 Jun 2019 10:27:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Jun 2019 10:27:07 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Jun 2019 10:27:07 +0800
Message-ID: <1559528827.6663.8.camel@mtkswgap22>
Subject: Re: [PATCH v2 2/3] dt-bindings: rng: update bindings for MediaTek
 ARMv8 SoCs
From:   Neal Liu <neal.liu@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Crystal Guo <Crystal.Guo@mediatek.com>
Date:   Mon, 3 Jun 2019 10:27:07 +0800
In-Reply-To: <CAGp9LzrQegBb9Oe-=jfkwOrsYY=eN3BSF=DWnu+aSBAhQ5bexA@mail.gmail.com>
References: <1558946326-13630-1-git-send-email-neal.liu@mediatek.com>
         <1558946326-13630-3-git-send-email-neal.liu@mediatek.com>
         <CAGp9LzrQegBb9Oe-=jfkwOrsYY=eN3BSF=DWnu+aSBAhQ5bexA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,


On Thu, 2019-05-30 at 15:56 -0700, Sean Wang wrote:
> Hi, Neal
> 
> On Mon, May 27, 2019 at 1:39 AM Neal Liu <neal.liu@mediatek.com> wrote:
> >
> > Document the binding used by the MediaTek ARMv8 SoCs random
> > number generator with TrustZone enabled.
> >
> > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/rng/mtk-rng.txt |   13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.txt b/Documentation/devicetree/bindings/rng/mtk-rng.txt
> > index 2bc89f1..1fb9b1d 100644
> > --- a/Documentation/devicetree/bindings/rng/mtk-rng.txt
> > +++ b/Documentation/devicetree/bindings/rng/mtk-rng.txt
> > @@ -3,9 +3,12 @@ found in MediaTek SoC family
> >
> >  Required properties:
> >  - compatible       : Should be
> > -                       "mediatek,mt7622-rng",  "mediatek,mt7623-rng" : for MT7622
> > -                       "mediatek,mt7629-rng",  "mediatek,mt7623-rng" : for MT7629
> > -                       "mediatek,mt7623-rng" : for MT7623
> > +                       "mediatek,mt7622-rng", "mediatek,mt7623-rng" for MT7622
> > +                       "mediatek,mt7629-rng", "mediatek,mt7623-rng" for MT7629
> > +                       "mediatek,mt7623-rng" for MT7623
> 
> No make any change for those lines not belong to the series

There are some unused spaces and symbols. We try to align coding style
with other bindings.

> 
> > +                       "mediatek,mtk-sec-rng" for MediaTek ARMv8 SoCs
> 
> I thought "mediatek,mtk-sec-rng" is only for those MediaTek ARMv8 SoCs
> with security RNG

Yes, sure. It's better to describe with "MediaTek ARMv8 SoCs with
security RNG". 

> 
> > +
> > +Optional properties:
> >  - clocks           : list of clock specifiers, corresponding to
> >                       entries in clock-names property;
> >  - clock-names      : Should contain "rng" entries;
> > @@ -19,3 +22,7 @@ rng: rng@1020f000 {
> >         clocks = <&infracfg CLK_INFRA_TRNG>;
> >         clock-names = "rng";
> >  };
> 
> For those MediaTek ARMv8 SoCs with security RNG

Are you suggesting we create a new binding file with security RNG?

> 
> > +
> > +hwrng: hwrng {
> > +       compatible = "mediatek,mtk-sec-rng";
> > +};
> > --
> > 1.7.9.5
> >


