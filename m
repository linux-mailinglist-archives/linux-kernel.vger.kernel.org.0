Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0470DA2F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 08:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfH3GEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 02:04:04 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:11413 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726023AbfH3GED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:04:03 -0400
X-UUID: 0bb8e9de47134dc9a92a46aef0001209-20190830
X-UUID: 0bb8e9de47134dc9a92a46aef0001209-20190830
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 755087413; Fri, 30 Aug 2019 14:03:43 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Aug
 2019 14:03:41 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 14:03:40 +0800
Message-ID: <1567145015.7317.25.camel@mhfsdcap03>
Subject: Re: [PATCH 01/11] dt-bindings: phy-mtk-tphy: add two optional
 properties for u2phy
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Date:   Fri, 30 Aug 2019 14:03:35 +0800
In-Reply-To: <20190829192341.GA26293@bogus>
References: <e99c0d7a55869a4425250c601b80a3331c9d0976.1566542696.git.chunfeng.yun@mediatek.com>
         <20190829192341.GA26293@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 5AA85C5E3F8AB8BAF30077AD6CA7DC8A8920C263640F601AAF4EB182F919651B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-29 at 14:23 -0500, Rob Herring wrote:
> On Fri, Aug 23, 2019 at 03:00:08PM +0800, Chunfeng Yun wrote:
> > Add two optional properties, one for J-K test, another for disconnect
> > threshold, both of them can be used to debug disconnection issues.
> 
> Testing and debug properties aren't really things that belong in DT.
They are not only for test and debug, but also used to tune default
value for some platforms, I'll modify the description

> 
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > index a5f7a4f0dbc1..d5b327f85fa2 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > +++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> > @@ -52,6 +52,8 @@ Optional properties (PHY_TYPE_USB2 port (child) node):
> >  - mediatek,eye-vrt	: u32, the selection of VRT reference voltage
> >  - mediatek,eye-term	: u32, the selection of HS_TX TERM reference voltage
> >  - mediatek,bc12	: bool, enable BC12 of u2phy if support it
> > +- mediatek,discth	: u32, the voltage of disconnect threshold
> > +- mediatek,intr	: u32, the value of internal R (resistance)
> 
> These need units as defined in property-units.txt.
They are in fact the choice index of different level, will modify it

Thank you

> 
> >  
> >  Example:
> >  
> > -- 
> > 2.23.0
> > 


