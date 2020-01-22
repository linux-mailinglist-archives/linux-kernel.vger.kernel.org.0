Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51376145AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 18:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAVR1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 12:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgAVR1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:27:03 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E7B2465A;
        Wed, 22 Jan 2020 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579714022;
        bh=EX0+I6dyirdMjWxr9MIssWyHmCGela91rfZhzH27bJI=;
        h=From:To:Cc:Subject:Date:From;
        b=uNKJuz/xgJtyaiKDYxe67Gt1Y8aBDTo+neAvz1Exsh9dwal6414SpNP5d3yPkVkb6
         Y4u5Dj9r6D6IYYUnAiBK2rzuwd0R3gjBfFvEef6dMsoNrC4LE44J2p/ZHPH/mdEsCx
         4OPmr04T68DVeKiOPDGfW+T3T1vrshM5gGEY0Ftc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: mach: s3c/exynos for v5.6, part 2
Date:   Wed, 22 Jan 2020 18:26:49 +0100
Message-Id: <20200122172649.3143-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request. Last minute changes.


Best regards,
Krzysztof


The following changes since commit 45984f0c70ccc03e09f97ee5d0749396547b6594:

  ARM: samsung: Rename Samsung and Exynos to lowercase (2020-01-07 20:44:22 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.6-2

for you to fetch changes up to af15a11b9046722f831588eff8fc423d28a1df44:

  ARM: s3c64xx: Drop unneeded select of TIMER_OF (2020-01-21 20:58:03 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v5.6, part 2

1. Switch from legacy to atomic pwm API in rx1950 (s3c24xx),
2. Cleanups of unneeded selects in Kconfig.

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: exynos: Drop unneeded select of MIGHT_HAVE_CACHE_L2X0
      ARM: s3c64xx: Drop unneeded select of TIMER_OF

Uwe Kleine-König (1):
      ARM: s3c24xx: Switch to atomic pwm API in rx1950

 arch/arm/mach-exynos/Kconfig        |  1 -
 arch/arm/mach-s3c24xx/mach-rx1950.c | 19 ++++++++++++-------
 arch/arm/mach-s3c64xx/Kconfig       |  1 -
 3 files changed, 12 insertions(+), 9 deletions(-)
