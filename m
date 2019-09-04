Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA922A7841
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 03:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfIDByg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 21:54:36 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:31393 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726589AbfIDByg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 21:54:36 -0400
X-UUID: b7c85c9247304d0b96b55c12cabe3981-20190904
X-UUID: b7c85c9247304d0b96b55c12cabe3981-20190904
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1282712295; Wed, 04 Sep 2019 09:54:29 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 Sep
 2019 09:54:27 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Sep 2019 09:54:26 +0800
Message-ID: <1567562067.7317.52.camel@mhfsdcap03>
Subject: Re: [PATCH v3 0/7]  add support USB for MT8183
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 4 Sep 2019 09:54:27 +0800
In-Reply-To: <1567150854-30033-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1567150854-30033-1-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: F991245A4BC6770D93164A2C1C559180A8AF081783FD3FC646A068AD51059FF02000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,


  Please don't try to pick up this series, the dependent ones are still
under public review, I'll fix build warning and send out new version
after the dependent ones are applied
  Sorry for inconvenience

Thanks

On Fri, 2019-08-30 at 15:40 +0800, Chunfeng Yun wrote:
> This series support USB DRD controller and enable it's remote
> wakeup functoin for MT8183, they depend on the following
> series patches:
> 
> 1. this series add support MT6358 PMIC
>   [v5,01/10] mfd: mt6397: clean up code
>   https://patchwork.kernel.org/patch/11110487/
> 
> 2. this series add support pericfg syscon
>   [v2,1/2] dt-bindings: clock: mediatek: add pericfg for MT8183
>   https://patchwork.kernel.org/patch/11118183/
> 
> 3. add property mediatek,discth for tphy
>   [06/11] phy: phy-mtk-tphy: add a property for disconnect threshold
>   https://patchwork.kernel.org/patch/11110695/
> 
> v3 changes:
>   1. changes micros define
>   2. remove #reset-cell
>   3. update dependent series
> 
> v2 changes:
>   add patch [7/7]
> 
> Chunfeng Yun (7):
>   dt-bindings: usb: mtu3: support USB wakeup for MT8183
>   dt-bindings: usb: mtk-xhci: support USB wakeup for MT8183
>   usb: mtu3: support ip-sleep wakeup for MT8183
>   usb: mtk-xhci: support ip-sleep wakeup for MT8183
>   arm64: dts: mt8183: add usb and phy nodes
>   arm64: dts: mt8183: enable USB remote wakeup
>   arm64: dts: mt8183: tune disconnect threshold of u2phy
> 
>  .../bindings/usb/mediatek,mtk-xhci.txt        |  1 +
>  .../devicetree/bindings/usb/mediatek,mtu3.txt |  1 +
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts   | 23 +++++++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 63 +++++++++++++++++++
>  drivers/usb/host/xhci-mtk.c                   | 14 ++++-
>  drivers/usb/mtu3/mtu3_host.c                  | 14 ++++-
>  6 files changed, 114 insertions(+), 2 deletions(-)
> 


