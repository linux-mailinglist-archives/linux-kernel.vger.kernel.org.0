Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04BFDD07E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 09:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfJIHKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 03:10:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36015 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbfJIHKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:10:38 -0400
X-UUID: 75f9ce72d54f4ad0b665792a5ab94113-20191009
X-UUID: 75f9ce72d54f4ad0b665792a5ab94113-20191009
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 414754981; Wed, 09 Oct 2019 15:10:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 15:10:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 15:10:24 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yt.shen@mediatek.com>,
        <biao.huang@mediatek.com>, <jianguo.zhang@mediatek.com>
Subject: [v2,PATCH 0/1] arm64: dts: mt2712: add ethernet device node
Date:   Wed, 9 Oct 2019 15:10:21 +0800
Message-ID: <20191009071022.4972-1-biao.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
add properties to default/sleep pinctrl-state node.

Biao Huang (1):
  arm64: dts: mt2712: add ethernet device node

 arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 74 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 65 ++++++++++++++++++
 2 files changed, 139 insertions(+)

--
2.18.0


