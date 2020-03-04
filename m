Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95640179AF3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 22:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbgCDVaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 16:30:08 -0500
Received: from mail.manjaro.org ([176.9.38.148]:47918 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388237AbgCDVaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:30:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 84C4237019F4;
        Wed,  4 Mar 2020 22:30:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3W5thPF20-qO; Wed,  4 Mar 2020 22:29:59 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Alexis Ballier <aballier@gentoo.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Xie <nick@khadas.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Tobias Schramm <t.schramm@manjaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH v4 0/2] Add support for the pine64 Pinebook Pro
Date:   Wed,  4 Mar 2020 22:29:16 +0100
Message-Id: <20200304212918.689936-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds an initial dts and compatible string for the rk3399
based Pinebook Pro 14" laptop.

This is version 4 of the original patchset with more fixes proposed
by Johan. Additionally the dt-bindings doc patch has been replaced by
one from Emmanuel since that patch has already been reviewed by Rob.

Contrary to the Rockchip BSP dts proposed mid January this dts has a
power tree reflecting the actual schematic of the device and features
full display, audio and WiFi/Bluetooth support.

Changelog:
 v2: Incorporate review by Heiko
 v3: Add fixes suggested by Johan
 v4: More fixes by Johan, set data-role on typec connector,
     use compatible doc patch by Emmanuel

Emmanuel Vadot (1):
  dt-bindings: Add doc for Pine64 Pinebook Pro

Tobias Schramm (1):
  arm64: dts: rockchip: Add initial support for Pinebook Pro

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts | 1096 +++++++++++++++++
 3 files changed, 1102 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts

-- 
2.24.1

