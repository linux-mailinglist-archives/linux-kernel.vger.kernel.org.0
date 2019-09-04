Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D676A8DDD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbfIDRuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 13:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfIDRuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:50:15 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98D7522CED;
        Wed,  4 Sep 2019 17:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619414;
        bh=R5WtwOkVVAy6378rDFTNIJIG6/6U6HQKgTz+BE11yrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtQWzH+WMahlJ1XkzJjMRlH0AsxSAWxwrnmz5SNnB8TfTdGwcCZru5yFCOhP7yXFU
         aRNaZDvNmEIqAnVtx3q9xFnciksSCwNEZVzqktXQnJyEpA115eJnQZp9QwKYUEHsIK
         hd8tWdm8EIgp2PV2mFwuah6BgL9mmC6iB8p3Cxxg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/5] ARM: defconfig: exynos for v5.4
Date:   Wed,  4 Sep 2019 19:49:58 +0200
Message-Id: <20190904175002.10487-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904175002.10487-1-krzk@kernel.org>
References: <20190904175002.10487-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-5.4

for you to fetch changes up to 86759eeb32f70193ca7ebd50cc9b70ccb73d3d89:

  ARM: multi_v7_defconfig: Make MAX77802 regulator driver built-in (2019-09-02 17:38:20 +0200)

----------------------------------------------------------------
Samsung defconfig changes for v5.4

1. Enable AHCI platform driver on exynos defconfig for Exynos5250-based
   Arndale board,
2. Make Max77802 PMIC regulator driver a built-in on multi_v7 defconfig
   as it is essential early during boot.

----------------------------------------------------------------
Marek Szyprowski (2):
      ARM: exynos_defconfig: Enable AHCI-platform SATA driver
      ARM: multi_v7_defconfig: Make MAX77802 regulator driver built-in

 arch/arm/configs/exynos_defconfig   | 5 ++++-
 arch/arm/configs/multi_v7_defconfig | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)
