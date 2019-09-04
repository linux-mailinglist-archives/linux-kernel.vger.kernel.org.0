Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34EC6A8DDF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbfIDRuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 13:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfIDRuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:50:22 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9D8721883;
        Wed,  4 Sep 2019 17:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619422;
        bh=atbT7s4nkjvbhxmdwbnCIhN5SlzuKsVKwEKH1bulJRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMTjTbKg++CGOzBWaUsr+7ZgA19CfHgJhUMl7nX8mIwAk5hoe6Pv8hNC8W2CuF5GW
         3X8dARXLh8lqllvJ4f+2t8exl8vAJoQhhCDgegGzxTmoXHih2zgJ3e3eKha98H+CFe
         IbFPJO6UPY7sfG97oBHOrNaglLdCPwICV5dDNVyc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/5] soc: samsung: Second pull for v5.4
Date:   Wed,  4 Sep 2019 19:49:59 +0200
Message-Id: <20190904175002.10487-3-krzk@kernel.org>
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


The following changes since commit 40d8aff614f71ab3cab20785b4f213e3802d4e87:

  soc: samsung: chipid: Convert exynos-chipid driver to use the regmap API (2019-08-15 20:25:25 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-5.4-2

for you to fetch changes up to 28578825ede61834a2c46e7f9a89012c4c7a667f:

  soc: samsung: chipid: Select missing dependency for EXYNOS_CHIPID (2019-08-22 20:16:20 +0200)

----------------------------------------------------------------
Samsung soc drivers changes for v5.4, part 2

Fixes and cleanups for recently introduced Exynos chipid driver.

----------------------------------------------------------------
Colin Ian King (1):
      soc: samsung: chipid: Fix memory leak in error path

Sylwester Nawrocki (2):
      soc: samsung: chipid: Remove the regmap lookup error log
      soc: samsung: chipid: Select missing dependency for EXYNOS_CHIPID

 drivers/soc/samsung/Kconfig         |  1 +
 drivers/soc/samsung/exynos-chipid.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)
