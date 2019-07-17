Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6261A6B508
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 05:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfGQDhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 23:37:53 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:60200 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726069AbfGQDhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 23:37:52 -0400
X-UUID: d0db6bff8b214815abb3b0db654177db-20190717
X-UUID: d0db6bff8b214815abb3b0db654177db-20190717
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1155228632; Wed, 17 Jul 2019 11:37:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Jul 2019 11:37:31 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Jul 2019 11:37:31 +0800
Message-ID: <1563334651.29169.8.camel@mtksdaap41>
Subject: Re: [PATCH v4, 03/33] dt-bindings: mediatek: add ccorr description
 for mt8183 display
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 17 Jul 2019 11:37:31 +0800
In-Reply-To: <1562625253-29254-4-git-send-email-yongqiang.niu@mediatek.com>
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
         <1562625253-29254-4-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 403168DAAE7D0F5F3260CBF4E27C82B0F49F3568C5D9161274FEC2680BC066432000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:


This version is identical to previous version, and Rob has gave a
'Reviwed-by' tag on previous version, so you should keep that tag on
this version, so we don't need to review this patch again.

Regards,
CK


On Tue, 2019-07-09 at 06:33 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Update device tree binding documention for the display subsystem for
> Mediatek MT8183 SOCs
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index 8c4700f..cf5fb08 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -31,6 +31,7 @@ Required properties (all function blocks):
>  	"mediatek,<chip>-disp-ovl-2l"           - overlay (2 layers, blending, csc)
>  	"mediatek,<chip>-disp-rdma"  		- read DMA / line buffer
>  	"mediatek,<chip>-disp-wdma"  		- write DMA
> +	"mediatek,<chip>-disp-ccorr"            - color correction
>  	"mediatek,<chip>-disp-color" 		- color processor
>  	"mediatek,<chip>-disp-aal"   		- adaptive ambient light controller
>  	"mediatek,<chip>-disp-gamma" 		- gamma correction


