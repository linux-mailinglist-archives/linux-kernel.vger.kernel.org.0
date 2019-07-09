Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19CA063678
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 15:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfGINJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 09:09:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45673 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbfGINJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:09:51 -0400
X-UUID: a7011a74a7d04a94baa0edb48571cdc2-20190709
X-UUID: a7011a74a7d04a94baa0edb48571cdc2-20190709
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 872568423; Tue, 09 Jul 2019 21:09:46 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 9 Jul 2019 21:09:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 9 Jul 2019 21:09:44 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <bbrezillon@kernel.org>
CC:     <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-i3c@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <liguo.zhang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH v3 0/2] Add MediaTek I3C master controller driver
Date:   Tue, 9 Jul 2019 21:09:20 +0800
Message-ID: <1562677762-24067-1-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on 5.2-rc1, we provide two patches to
support MediaTek I3C master controller.

Main changes compared to v2:
--modify the description of clock and interrupt in bindings
--use correct cells for I2C device in bindings

Main changes compared to v1:
--remove clock-div, let clock driver handle it
--let sample_cnt and step_cnt start from two

Qii Wang (2):
  dt-bindings: i3c: Document MediaTek I3C master bindings
  i3c: master: Add driver for MediaTek IP

 .../devicetree/bindings/i3c/mtk,i3c-master.txt     |   48 +
 drivers/i3c/master/Kconfig                         |   10 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/i3c-master-mtk.c                | 1239 ++++++++++++++++++++
 4 files changed, 1298 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
 create mode 100644 drivers/i3c/master/i3c-master-mtk.c

-- 
1.7.9.5
