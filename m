Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D67194F70
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 04:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgC0DEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 23:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgC0DEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:04:31 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC95620787;
        Fri, 27 Mar 2020 03:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585278271;
        bh=6y12TvNjGQ59pOhao3h7PXzCpe1LrErO1ZETO+Q38/8=;
        h=From:To:Cc:Subject:Date:From;
        b=oBVc4pwmUnHocEPPHYmexfW8XvqTWf1SifihhT9bbCZczSyCXwKHOQHMC5zApG36V
         hVen6Haxaoaqede+i3aptmdkwJ+AswxVxjx3RPGV7dkki4mCp/VNYC5SIR7ZnDGVLQ
         +RQ8lPAlVwa0aUVtnvN8d4xLxegjP1JIMWsQqizo=
Received: by wens.tw (Postfix, from userid 1000)
        id 2E8525FD2A; Fri, 27 Mar 2020 11:04:26 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] arm64: dts: rockchip: misc. cleanups
Date:   Fri, 27 Mar 2020 11:04:08 +0800
Message-Id: <20200327030414.5903-1-wens@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi,

Here are a bunch of cleanups for rk3399 and rk3328.

  - Some dtc warnings were silenced, however a few still remain.
    Found those while making device tree overlays

  - Replaced some hardware specific device node names, such as dwc3
    and rk808, with generic names

  - Fixed MMC numbering for roc-rk3399-pc with mezzanine

The series is based on linux-next 2020-03-24. For some reason 2020-03-26
doesn't boot.

Please have a look.

Regards
ChenYu

Chen-Yu Tsai (6):
  arm64: dts: rockchip: rk3399-roc-pc: Fix MMC numbering for LED
    triggers
  arm64: dts: rockchip: rk3328: Replace RK805 PMIC node name with "pmic"
  arm64: dts: rockchip: rk3328: drop non-existent gmac2phy pinmux
    options
  arm64: dts: rockchip: rk3328: drop #address-cells, #size-cells from
    grf node
  arm64: dts: rockchip: rk3399: drop #address-cells, #size-cells from
    pmugrf node
  arm64: dts: rockchip: rk3399: Rename dwc3 device nodes to make dtc
    happy

 arch/arm64/boot/dts/rockchip/rk3328-evb.dts    |  2 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts |  2 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi       | 18 ------------------
 .../dts/rockchip/rk3399-roc-pc-mezzanine.dts   |  8 ++++++++
 .../arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3399.dtsi       |  6 ++----
 6 files changed, 14 insertions(+), 26 deletions(-)

-- 
2.25.1

