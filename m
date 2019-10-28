Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 737DDE70B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 12:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfJ1Lux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 07:50:53 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:4383 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727585AbfJ1Luw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:50:52 -0400
X-UUID: 52d6e1d6f5c441be866a1a2e4fa1d613-20191028
X-UUID: 52d6e1d6f5c441be866a1a2e4fa1d613-20191028
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2015695837; Mon, 28 Oct 2019 19:50:41 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Oct
 2019 19:50:42 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Mon, 28 Oct 2019 19:50:39 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v3 0/3] add dsi pwm0 node for mt8183
Date:   Mon, 28 Oct 2019 19:50:36 +0800
Message-ID: <20191028115039.96555-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: 435FE06E00B94DC7D8F5816F936DD3FB2E393C851001A44BB8B8C43541987B822000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
 - add calibration property in mipitx and efuse.

Changes since v1:
 - remove "mediatek,mt8173-dsi" from dsi node.

This patch is based on v5.4-rc5 and these patches:
https://patchwork.kernel.org/patch/10938825/

Jitao Shi (3):
  arm64: dts: mt8183: add dsi node
  arm64: dts: mt8183: add pwm0 node
  arm64: dts: mt8183: add calibration property in mipitx and efuse

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

-- 
2.21.0

