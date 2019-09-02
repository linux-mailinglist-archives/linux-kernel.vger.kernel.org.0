Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E93CA5268
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 11:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfIBJBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 05:01:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39670 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730727AbfIBJBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:01:07 -0400
X-UUID: a9ec20a5817042588d6cd79b91edcfc1-20190902
X-UUID: a9ec20a5817042588d6cd79b91edcfc1-20190902
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1041834262; Mon, 02 Sep 2019 17:01:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 2 Sep 2019 17:01:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 2 Sep 2019 17:01:01 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [RESEND PATCH v1 0/3] Runtime PM support for MT8183 mcucfg clock provider
Date:   Mon, 2 Sep 2019 17:00:56 +0800
Message-ID: <1567414859-3244-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CED2E5001E391BB1FEC2C7595861BC005DBAAB114CC917788707A64A5447BC502000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on v5.3-rc1 and Mediatek MT8183 scpsys support v7[1].
Since Runtime PM is supported in Common Clock Framework which keeps clock
controller's power domain enabled to ensure clock status accessing correctly.

[1] https://patchwork.kernel.org/cover/11118371/

---

Weiyi Lu (3):
  clk: mediatek: Register clock gate with device
  clk: mediatek: Runtime PM support for MT8183 mcucfg clock provider
  arm64: dts: Add power-domains properity to mfgcfg

 arch/arm64/boot/dts/mediatek/mt8183.dtsi |  1 +
 drivers/clk/mediatek/clk-gate.c          |  5 +++--
 drivers/clk/mediatek/clk-gate.h          |  3 ++-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c |  7 +++++--
 drivers/clk/mediatek/clk-mtk.c           | 16 +++++++++++++---
 drivers/clk/mediatek/clk-mtk.h           |  5 +++++
 6 files changed, 29 insertions(+), 8 deletions(-)

