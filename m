Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B531698F8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 18:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBWR32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 12:29:28 -0500
Received: from vps.xff.cz ([195.181.215.36]:44440 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbgBWR31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582478965; bh=7OA3oWwjm5heb675PLFXd94nLmDlc4h89uOCL49bwbE=;
        h=From:To:Cc:Subject:Date:From;
        b=do7Ry5KQdS859DmYMjl2iQfQvJErf8fAL4oA6Avl3X2DoA/1JG0G877TeQdtF7MjH
         pmgsmUwo+c+Ue3MLERcZtsdRm6IVip1pQUknf0rc34bOVMJkp0mRzAoaj/iQXLtrIe
         A0H/a/En2wRe7NW0nhu9rahYeaHpBnKm46z2T2aQ=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add support for Pine64 PinePhone Linux Smartphone
Date:   Sun, 23 Feb 2020 18:29:13 +0100
Message-Id: <20200223172916.843379-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds an initial support for Pine64
PinePhone.

Please take a look.

thank you and regards,
  Ondrej Jirman

Ondrej Jirman (3):
  arm64: dts: sun50i-a64: Add i2c2 pins
  dt-bindings: arm: sunxi: Add PinePhone 1.0 and 1.1 bindings
  arm64: dts: allwinner: Add initial support for Pine64 PinePhone

 .../devicetree/bindings/arm/sunxi.yaml        |  10 +
 arch/arm64/boot/dts/allwinner/Makefile        |   2 +
 .../allwinner/sun50i-a64-pinephone-1.0.dts    |  11 +
 .../allwinner/sun50i-a64-pinephone-1.1.dts    |  11 +
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 385 ++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |   5 +
 6 files changed, 424 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi

-- 
2.25.1

