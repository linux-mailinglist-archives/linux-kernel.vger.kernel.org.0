Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F41317277E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 19:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbgB0SZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 13:25:10 -0500
Received: from mail.manjaro.org ([176.9.38.148]:48220 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbgB0SZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:25:08 -0500
X-Greylist: delayed 1096 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2020 13:25:07 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 3747838C698C;
        Thu, 27 Feb 2020 19:06:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TMxKtG3EY9dS; Thu, 27 Feb 2020 19:06:47 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>
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
        anarsoul@gmail.com
Subject: [PATCH 0/2] Add support for the pine64 Pinebook Pro
Date:   Thu, 27 Feb 2020 19:06:28 +0100
Message-Id: <20200227180630.166982-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds an initial dts and compatible string for the rk3399
based Pinebook Pro 14" laptop.

Contrary to the Rockchip BSP dts proposed mid January this dts has a
power tree reflecting the actual schematic of the device and features
full display, audio and WiFi/Bluetooth support.

Tobias Schramm (2):
  dt-bindings: Add doc for pine64 Pinebook Pro
  arm64: dts: rockchip: Add initial support for Pinebook Pro

 .../devicetree/bindings/arm/rockchip.yaml     |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    1 +
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts | 1191 +++++++++++++++++
 3 files changed, 1197 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts

-- 
2.24.1

