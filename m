Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E52A681A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfICMIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 08:08:05 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:53756 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbfICMIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:08:05 -0400
Received: from finley.xiao?rock-chips.com (unknown [192.168.167.224])
        by regular1.263xmail.com (Postfix) with ESMTP id 4B871399;
        Tue,  3 Sep 2019 19:59:56 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13045T140284270724864S1567511992953411_;
        Tue, 03 Sep 2019 19:59:54 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7cbf843b0ef0bee03254767c84d56ade>
X-RL-SENDER: finley.xiao@rock-chips.com
X-SENDER: xf@rock-chips.com
X-LOGIN-NAME: finley.xiao@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Finley Xiao <finley.xiao@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangqing@rock-chips.com, huangtao@rock-chips.com,
        tony.xie@rock-chips.com, andy.yan@rock-chips.com,
        Finley Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH v1 0/3] clk: rockchip: support clock controller for rk3308 SoC
Date:   Tue,  3 Sep 2019 19:59:44 +0800
Message-Id: <20190903115947.26618-1-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finley Xiao (3):
  dt-bindings: Add bindings for rk3308 clock controller
  clk: rockchip: Add dt-binding header for rk3308
  clk: rockchip: Add clock controller for the RK3308

 .../devicetree/bindings/clock/rockchip,rk3308.txt  |  58 ++
 drivers/clk/rockchip/Makefile                      |   1 +
 drivers/clk/rockchip/clk-rk3308.c                  | 955 +++++++++++++++++++++
 drivers/clk/rockchip/clk.h                         |  13 +
 include/dt-bindings/clock/rk3308-cru.h             | 387 +++++++++
 5 files changed, 1414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3308.txt
 create mode 100644 drivers/clk/rockchip/clk-rk3308.c
 create mode 100644 include/dt-bindings/clock/rk3308-cru.h

-- 
2.11.0



