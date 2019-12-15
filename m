Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3848111F79D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 13:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfLOMNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 07:13:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfLOMNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 07:13:23 -0500
Received: from localhost.localdomain (unknown [194.230.155.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 078D524654;
        Sun, 15 Dec 2019 12:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576412003;
        bh=kEXVJBS/UwSqT3Pg74eUT2ImW/zfE9tpz4hx6T3Exhc=;
        h=From:To:Cc:Subject:Date:From;
        b=SJx6ZiaWnXXF3Zdx0oLlUaOw1bKAIEIIWgnsMajl5s0Hy4sLaK4cFIXYn++eZlMx0
         pcaexBmHxoMhXBXT4/XalZNLjxv4r7a+d2R168iY6YacNpBTwV3q95VaCda6eNeoJJ
         5vz6+1jCxsD+hA86MqXSCLQRe7fOKAYAqseIzct8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: exynos: Fixes for v5.5
Date:   Sun, 15 Dec 2019 13:13:16 +0100
Message-Id: <20191215121316.32091-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Three fix-related patches for current cycle.

Best regards,
Krzysztof


The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-fixes-5.5

for you to fetch changes up to a2315d3aea5976acd919d3d3fcf82f752562c25b:

  ARM: exynos_defconfig: Restore debugfs support (2019-12-09 18:59:54 +0100)

----------------------------------------------------------------
Samsung fixes for v5.5

1. Restore debugfs support in exynos_defconfig (as now it is not
   selected as dependency of tracing).  Debugfs is required by systemd
   and several tests.
2. Maintainers updates.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      MAINTAINERS: Include Samsung SoC serial driver in Samsung SoC entry

Lukasz Luba (1):
      MAINTAINERS: Update Lukasz Luba's email address

Marek Szyprowski (1):
      ARM: exynos_defconfig: Restore debugfs support

 .mailmap                          | 1 +
 MAINTAINERS                       | 3 ++-
 arch/arm/configs/exynos_defconfig | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)
