Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C60B1374B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 18:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgAJRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 12:24:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgAJRYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:24:10 -0500
Received: from localhost.localdomain (unknown [83.218.167.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E1B2080D;
        Fri, 10 Jan 2020 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578677050;
        bh=PEEWZOXtjp+MV+ENjzNepmXB7JALrO/U96bkKTRD2HU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Srn9kJKd0sPJ1cmBok1bROl1+1DyLwvY/44RiAi/t5xT5CX8qBGsdO2oBMxCSooMj
         Wl98Fw/vUFs5sUBqmgY4uF4EuAE1fl9d9sh5LYRMkuGFYyeLDk//ELUT9jHjmKN9Hn
         tmOvTxgATRgKfR2LuGJ5KJwIC4iOgp6evkBOyojc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/3] ARM: samsung: Pull for v5.6
Date:   Fri, 10 Jan 2020 18:23:32 +0100
Message-Id: <20200110172334.4767-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110172334.4767-1-krzk@kernel.org>
References: <20200110172334.4767-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.6
`
for you to fetch changes up to 45984f0c70ccc03e09f97ee5d0749396547b6594:

  ARM: samsung: Rename Samsung and Exynos to lowercase (2020-01-07 20:44:22 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v5.6

Cleanups (Samsung and Exynos names, Kconfig help text correction).

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      ARM: exynos: Correct the help text for platform Kconfig option
      ARM: samsung: Rename Samsung and Exynos to lowercase

 arch/arm/mach-exynos/Kconfig                      | 36 +++++++++++------------
 arch/arm/mach-exynos/common.h                     |  2 +-
 arch/arm/mach-exynos/exynos.c                     |  4 +--
 arch/arm/mach-exynos/include/mach/map.h           |  2 +-
 arch/arm/mach-exynos/pm.c                         |  2 +-
 arch/arm/mach-exynos/smc.h                        |  2 +-
 arch/arm/mach-exynos/suspend.c                    |  2 +-
 arch/arm/mach-s3c24xx/Kconfig                     | 16 +++++-----
 arch/arm/plat-samsung/adc.c                       |  2 +-
 arch/arm/plat-samsung/devs.c                      |  2 +-
 arch/arm/plat-samsung/gpio-samsung.c              |  2 +-
 arch/arm/plat-samsung/include/plat/samsung-time.h |  2 +-
 12 files changed, 37 insertions(+), 37 deletions(-)
