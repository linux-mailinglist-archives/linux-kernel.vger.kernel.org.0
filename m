Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0307617A468
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 12:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgCELjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 06:39:52 -0500
Received: from lucky1.263xmail.com ([211.157.147.134]:42380 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCELjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:39:51 -0500
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id 491126D08C;
        Thu,  5 Mar 2020 19:39:24 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32419T139954420168448S1583408354858766_;
        Thu, 05 Mar 2020 19:39:24 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <60c9cb10d66f05175c03168580c048c6>
X-RL-SENDER: andy.yan@rock-chips.com
X-SENDER: yxj@rock-chips.com
X-LOGIN-NAME: andy.yan@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Andy Yan <andy.yan@rock-chips.com>
To:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 0/4] Enable eDP display on rk3399 evb.
Date:   Thu,  5 Mar 2020 19:39:08 +0800
Message-Id: <20200305113912.32226-1-andy.yan@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When I try to test a patch for eDP on mainline, I found there is no
display suport for this board. So I try to add all the releated things
for it.


Andy Yan (4):
  arm64: dts: rockchip: remove dvs2 pinctrl for pmic on rk3399 evb
  arm64: dts: rockchip: Add pmic dt tree for rk3399 evb
  arm64: dts: rockchip: remove enable-gpio of backlight on rk3399 evb
  arm64: dts: rockchip: Enable eDP display on rk3399 evb

 arch/arm64/boot/dts/rockchip/rk3399-evb.dts | 267 +++++++++++++++++++-
 1 file changed, 261 insertions(+), 6 deletions(-)

-- 
2.17.1



