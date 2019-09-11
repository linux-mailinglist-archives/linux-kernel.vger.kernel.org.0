Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D77B03BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 20:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbfIKSgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 14:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729696AbfIKSgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:36:46 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 957EE20863;
        Wed, 11 Sep 2019 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568227006;
        bh=zGc5nUnSrcLmCATImTaZ81stiof+h7AVsb7mMRzglHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=epMIAbtK1rFqZ/4CHUz4ELsJLowpBnDvtMQa5AC8jk3ZcGbRCfG3hxX+yVp0ptnOX
         lWUjPThKTgxtTOgLaH9oQhQ+1iirO09jCTZrcF8SxagFJTFYTusBjn3P87l4Yu9noY
         pgVN93YEcJlobSwuyLEjXAT+RUKLCkgSUD2e21MM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/2] ARM: samsung: mach/soc for v5.4, second pull
Date:   Wed, 11 Sep 2019 20:36:32 +0200
Message-Id: <20190911183632.4317-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190911183632.4317-1-krzk@kernel.org>
References: <20190911183632.4317-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Late pull, on top of previous pull request.  Unfortunately the patches
were applied right after closing the linux-next.


Best regards,
Krzysztof


The following changes since commit c663d542bfb40eeeb6d393ed155c23a4666d65e1:

  MAINTAINERS: Extend patterns for Samsung SoC, Security Subsystem and clock drivers (2019-08-22 21:04:45 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.4-3

for you to fetch changes up to 13aeb3fe4d5bd78a6dc7bde32986a7296da420d3:

  ARM: exynos: Enable support for ARM architected timers (2019-09-09 20:56:43 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v5.4, part 2

1. Fix system restart on S3C6410 due to missing match of watchdog,
2. Enable suppor for ARM architected timers on Exynos.

----------------------------------------------------------------
Lihua Yao (1):
      ARM: samsung: Fix system restart on S3C6410

Marek Szyprowski (1):
      ARM: exynos: Enable support for ARM architected timers

 arch/arm/mach-exynos/Kconfig           | 1 +
 arch/arm/plat-samsung/watchdog-reset.c | 1 +
 2 files changed, 2 insertions(+)
