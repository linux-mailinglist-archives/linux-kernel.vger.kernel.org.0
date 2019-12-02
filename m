Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A739D10F29F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 23:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfLBWFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 17:05:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:49108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfLBWFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:05:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0290B14F;
        Mon,  2 Dec 2019 22:05:44 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     Cheng-Yu Lee <cylee12@realtek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [RFC 0/5] ARM: dts: realtek: SB2 semaphores
Date:   Mon,  2 Dec 2019 23:05:30 +0100
Message-Id: <20191202220535.6208-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series implements hardware semaphores found in SB2 bridge.

Downstream BSP code assigns the same first semaphore to both CRT and Iso nodes,
which seems inefficient in light of nine semaphore registers and is therefore
deferred in this initial RFC.

This series is based on my syscon series [1].

Latest experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

[1] https://patchwork.kernel.org/cover/11269453/

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Cheng-Yu Lee <cylee12@realtek.com>

Andreas Färber (5):
  dt-bindings: hwlock: Add Realtek RTD1195 SB2
  hwspinlock: Add Realtek RTD1195 SB2
  ARM: dts: rtd1195: Add SB2 sem nodes
  arm64: dts: realtek: rtd129x: Add SB2 sem nodes
  arm64: dts: realtek: rtd139x: Add SB2 sem nodes

 .../bindings/hwlock/realtek,rtd1195-sb2-sem.yaml   |  42 +++++++++
 arch/arm/boot/dts/rtd1195.dtsi                     |  14 +++
 arch/arm64/boot/dts/realtek/rtd129x.dtsi           |  14 +++
 arch/arm64/boot/dts/realtek/rtd139x.dtsi           |  14 +++
 drivers/hwspinlock/Kconfig                         |  11 +++
 drivers/hwspinlock/Makefile                        |   1 +
 drivers/hwspinlock/rtd1195_sb2_sem.c               | 101 +++++++++++++++++++++
 7 files changed, 197 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/realtek,rtd1195-sb2-sem.yaml
 create mode 100644 drivers/hwspinlock/rtd1195_sb2_sem.c

-- 
2.16.4

