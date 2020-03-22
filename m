Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C6A18E79C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 09:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgCVIWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 04:22:23 -0400
Received: from out28-52.mail.aliyun.com ([115.124.28.52]:51546 "EHLO
        out28-52.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCVIWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 04:22:23 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1662865|-1;CH=green;DM=||false|;DS=CONTINUE|ham_regular_dialog|0.00857753-0.000227731-0.991195;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03300;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.H3MM99h_1584865287;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.H3MM99h_1584865287)
          by smtp.aliyun-inc.com(10.147.40.200);
          Sun, 22 Mar 2020 16:21:34 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v6 0/6] Add support for the X1830 and fix bugs for X1000
Date:   Sun, 22 Mar 2020 16:20:56 +0800
Message-Id: <1584865262-25297-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584865262-25297-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1584865262-25297-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5->v6:
1.Revert "pll_reg" to "reg" to minimize patch as Paul Cercueil's suggest.
2.Add missing part of X1830's CGU.
3.Add missing part of X1000's CGU.

周琰杰 (Zhou Yanjie) (6):
  clk: Ingenic: Remove unnecessary spinlock when reading registers.
  clk: Ingenic: Adjust cgu code to make it compatible with X1830.
  dt-bindings: clock: Add X1830 bindings.
  clk: Ingenic: Add CGU driver for X1830.
  dt-bindings: clock: Add and reorder ABI for X1000.
  clk: X1000: Add FIXDIV for SSI clock of X1000.

 .../devicetree/bindings/clock/ingenic,cgu.txt      |   1 +
 drivers/clk/ingenic/Kconfig                        |  10 +
 drivers/clk/ingenic/Makefile                       |   1 +
 drivers/clk/ingenic/cgu.c                          |  28 +-
 drivers/clk/ingenic/cgu.h                          |   4 +
 drivers/clk/ingenic/jz4725b-cgu.c                  |   2 +
 drivers/clk/ingenic/jz4740-cgu.c                   |   2 +
 drivers/clk/ingenic/jz4770-cgu.c                   |   6 +-
 drivers/clk/ingenic/jz4780-cgu.c                   |   2 +
 drivers/clk/ingenic/x1000-cgu.c                    |  60 +++-
 drivers/clk/ingenic/x1830-cgu.c                    | 387 +++++++++++++++++++++
 include/dt-bindings/clock/x1000-cgu.h              |  62 ++--
 include/dt-bindings/clock/x1830-cgu.h              |  53 +++
 13 files changed, 569 insertions(+), 49 deletions(-)
 create mode 100644 drivers/clk/ingenic/x1830-cgu.c
 create mode 100644 include/dt-bindings/clock/x1830-cgu.h

-- 
2.7.4

