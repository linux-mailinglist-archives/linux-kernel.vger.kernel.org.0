Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE74A8DE1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbfIDRu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 13:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfIDRu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:50:26 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5248822CF5;
        Wed,  4 Sep 2019 17:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619425;
        bh=vYxoB/up+rjfB1ERqXN7TXj5LMSimQQfJSk7f9YeKgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmMnqNJ44eVCJ8zYAD1pddQms4p5U9Yvd8CXPjhaUl+ck9U2ztm/PAie1i/ZJYgyH
         LZczOToKCN3Bf4mU114eCYrczmtNntDFaMRBDTKPTN1xnjg3NGtRw6LcNRXZT2xL6Q
         +gLIEsHpKFsZvvABSa0tmM9q1Vev1oiqcCK26XPY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/5] ARM: dts: exynos: Second pull for v5.4
Date:   Wed,  4 Sep 2019 19:50:00 +0200
Message-Id: <20190904175002.10487-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904175002.10487-1-krzk@kernel.org>
References: <20190904175002.10487-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit bfb77169306d5d560a8b62eebaf6d69d02e8d152:

  ARM: dts: exynos: Add CAM power domain to Exynos5422/5800 (2019-08-12 19:02:59 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.4-2

for you to fetch changes up to 51c88919e52873c83f8be0c8f5d0ffd654f1ef4a:

  ARM: dts: exynos: Enable GPU/Mali T604 on Arndale board (2019-09-04 19:25:33 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.4, part 2

1. Fix Exynos542x Chromebooks boot with multi_v7 defconfig,
2. Add GPU (Mali) support to Exynos5250 boards,
3. Minor cleanup for Exynos3250 ADC.

----------------------------------------------------------------
Guillaume Gardet (4):
      ARM: dts: exynos: Fix min/max buck4 for GPU on Arndale board
      ARM: dts: exynos: Add GPU/Mali T604 node to Exynos5250
      ARM: dts: exynos: Enable GPU/Mali T604 on Chromebook Snow
      ARM: dts: exynos: Enable GPU/Mali T604 on Arndale board

Krzysztof Kozlowski (1):
      ARM: dts: exynos: Remove not accurate secondary ADC compatible

Marek Szyprowski (1):
      ARM: dts: exynos: Mark LDO10 as always-on on Peach Pit/Pi Chromebooks

 arch/arm/boot/dts/exynos3250.dtsi             |  3 +-
 arch/arm/boot/dts/exynos5250-arndale.dts      |  9 +++--
 arch/arm/boot/dts/exynos5250-snow-common.dtsi |  5 +++
 arch/arm/boot/dts/exynos5250.dtsi             | 47 +++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |  1 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |  1 +
 6 files changed, 62 insertions(+), 4 deletions(-)
