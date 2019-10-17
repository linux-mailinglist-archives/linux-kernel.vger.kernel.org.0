Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474FEDA42D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 05:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407465AbfJQDKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 23:10:03 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:47362 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406647AbfJQDKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 23:10:03 -0400
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id 9498869F48;
        Thu, 17 Oct 2019 11:02:50 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P17817T140260256241408S1571281364775434_;
        Thu, 17 Oct 2019 11:02:50 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <976a90d9e80f3844db1a30634c13818f>
X-RL-SENDER: andy.yan@rock-chips.com
X-SENDER: yxj@rock-chips.com
X-LOGIN-NAME: andy.yan@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Andy Yan <andy.yan@rock-chips.com>
To:     heiko@sntech.de, kever.yang@rock-chips.com,
        linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        obh+dt@kernel.org, devicetree@vger.kernel.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 0/2] Add basic dts support for RK3308
Date:   Thu, 17 Oct 2019 11:02:42 +0800
Message-Id: <20191017030242.32219-1-andy.yan@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3308 is a quad Cortex A35 based SOC with rich audio
interfaces(I2S/PCM/TDM/PDM/SPDIF/VAD/HDMI ARC), which
designed for intelligent voice interaction and audio
input/output processing.

As the clk and pinctrl drivers are landed, we post
the basic dts support, make it convenient for other
module development.


Andy Yan (2):
  arm64: dts: rockchip: Add core dts for RK3308 SOC
  arm64: dts: rockchip: Add basic dts for RK3308 EVB

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 arch/arm64/boot/dts/rockchip/rk3308-evb.dts   |  206 ++
 arch/arm64/boot/dts/rockchip/rk3308.dtsi      | 1875 +++++++++++++++++
 4 files changed, 2087 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308.dtsi

-- 
2.17.1



