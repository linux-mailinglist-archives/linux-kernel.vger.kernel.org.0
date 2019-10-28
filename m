Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4796CE6C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 07:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfJ1GKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 02:10:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35350 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727559AbfJ1GKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 02:10:34 -0400
X-UUID: bdec56a28e8646d9969387b7f860d6fe-20191028
X-UUID: bdec56a28e8646d9969387b7f860d6fe-20191028
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dehui.sun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 306147041; Mon, 28 Oct 2019 14:10:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Oct 2019 14:10:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Oct 2019 14:10:25 +0800
From:   Dehui Sun <dehui.sun@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <erin.lo@mediatek.com>,
        <weiyi.lu@mediatek.com>, <dehui.sun@mediatek.com>
Subject: [PATCH v2 0/2] add systimer node for MT8183 SoC
Date:   Mon, 28 Oct 2019 14:09:42 +0800
Message-ID: <1572242984-30460-1-git-send-email-dehui.sun@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on 5.4-rc1 and add systimer node for MT8183,
and this timer will serve as a wakeup source for cpu-idle feature.

Change in v2:
 - rename the node's name from 'systimer' to 'timer'.

Dehui Sun (2):
  dt-bindings: mediatek: update bindings for MT8183 systimer
  arm64: dts: mt8183: add systimer0 device node

 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                       | 9 +++++++++
 2 files changed, 10 insertions(+)

-- 
1.9.1

