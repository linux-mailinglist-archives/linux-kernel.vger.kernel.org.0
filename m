Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F023232156
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 03:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFBBEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 21:04:25 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:58348 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFBBEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 21:04:25 -0400
X-UUID: f2afecfc659f46bfb1d0f459c8697aa9-20190601
X-UUID: f2afecfc659f46bfb1d0f459c8697aa9-20190601
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 420870484; Sat, 01 Jun 2019 17:04:21 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 1 Jun 2019 18:04:19 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 2 Jun 2019 09:04:18 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 0/4] add boot-gpios and clock property to btmtkuart
Date:   Sun, 2 Jun 2019 09:04:13 +0800
Message-ID: <1559437457-26766-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Update dt-binding and the corresponding implmentation of boot-gpios and clock
property to btmtkuart.

Sean Wang (4):
  dt-bindings: net: bluetooth: add boot-gpios property to UART-based
    device
  dt-bindings: net: bluetooth: add clock property to UART-based device
  Bluetooth: btmtkuart: add an implementation for boot-gpios property
  Bluetooth: btmtkuart: add an implementation for clock osc property

 .../bindings/net/mediatek-bluetooth.txt       | 17 +++++++
 drivers/bluetooth/btmtkuart.c                 | 51 +++++++++++++++----
 2 files changed, 58 insertions(+), 10 deletions(-)

-- 
2.17.1

