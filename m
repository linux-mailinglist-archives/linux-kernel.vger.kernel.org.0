Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F5F905DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfHPQa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 12:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfHPQa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:30:56 -0400
Received: from localhost.localdomain (unknown [194.230.155.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF3CB2173E;
        Fri, 16 Aug 2019 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565973055;
        bh=0drG/IaIH9vyth4PWqswXAkHuJ4rjWgU6KRc7PlP06M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3IsXHEagErS2Pqmk7IVQ+yWuczqq5Eu2FUZ50hCL/9u0KAK0n3npjus+ABKYhOLc
         YqGuT0ITWXOQ+axriPm47UZSMm4TNBgYhSQC6oH099jyZucvBZIEbfWqkj7ZceR0af
         +ztGrafANd+4RS/szdY3QcXHW5tdl8lYR9oIPo0E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/3] ARM: samsung: mach for v5.4
Date:   Fri, 16 Aug 2019 18:30:42 +0200
Message-Id: <20190816163042.6604-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816163042.6604-1-krzk@kernel.org>
References: <20190816163042.6604-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.4

for you to fetch changes up to 1fa70c7f49132513fb0da4afa7643395eedc7d35:

  ARM: exynos: Enable exynos-chipid driver (2019-08-15 20:29:58 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v5.4

1. Minor fixup in plat code (S3C platforms),
2. Enable exynos-chipid driver to provide SoC related information.

----------------------------------------------------------------
Linus Walleij (1):
      ARM: samsung: Include GPIO driver header

Pankaj Dubey (1):
      ARM: exynos: Enable exynos-chipid driver

 arch/arm/mach-exynos/Kconfig                   | 1 +
 arch/arm/plat-samsung/include/plat/gpio-core.h | 1 +
 2 files changed, 2 insertions(+)
