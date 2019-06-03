Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEED03270B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 05:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFCDvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 23:51:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49206 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726550AbfFCDvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 23:51:25 -0400
X-UUID: 09e51b78d69c4e6095136a39cd8a1648-20190603
X-UUID: 09e51b78d69c4e6095136a39cd8a1648-20190603
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 33129947; Mon, 03 Jun 2019 11:51:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Jun 2019 11:51:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Jun 2019 11:51:16 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <bbrezillon@kernel.org>
CC:     <matthias.bgg@gmail.com>, <linux-i3c@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <liguo.zhang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH 0/2] Add MediaTek I3C master controller driver
Date:   Mon, 3 Jun 2019 11:51:01 +0800
Message-ID: <1559533863-10292-1-git-send-email-qii.wang@mediatek.com>
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

Qii Wang (2):
  dt-bindings: i3c: Document MediaTek I3C master bindings
  i3c: master: Add driver for MediaTek IP

 .../devicetree/bindings/i3c/mtk,i3c-master.txt     |   50 +
 drivers/i3c/master/Kconfig                         |   10 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/i3c-master-mtk.c                | 1246 ++++++++++++++++++++
 4 files changed, 1307 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
 create mode 100644 drivers/i3c/master/i3c-master-mtk.c

-- 
1.7.9.5
