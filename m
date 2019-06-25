Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27308557D8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 21:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfFYTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 15:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfFYTfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:35:07 -0400
Received: from localhost.localdomain (unknown [194.230.155.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0027120883;
        Tue, 25 Jun 2019 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561491307;
        bh=aRij1mR2Y7fwBDGuFaA7Kzzg9Y6e90L+q57nwMwS4+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVzEt3Nb68tTb0K9jdU1XJISzbdNzEpg4V/4IYkGYX2jO1kULCNEFCCNAIDqcKX8h
         pH1NF/KB/3ziCIc6F1GchXk+0tysPPzOpZYxz/JHVHXYTAwp1DJkQcPopMPo7PJuBk
         zQ7J/mHIEFLSl9U/R4wH0L+TcA7HzVYJ+Zn2xRME=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/4] arm64: dts: exynos: Pull for v5.3
Date:   Tue, 25 Jun 2019 21:34:50 +0200
Message-Id: <20190625193451.7696-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625193451.7696-1-krzk@kernel.org>
References: <20190625193451.7696-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.3

for you to fetch changes up to 4dc2a25d058d71f39e41da986777327b423b92f1:

  arm64: dts: exynos: Add GPU/Mali T760 node to Exynos7 (2019-06-24 19:52:48 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v5.3

Add Mali nodes to Exynos3 and Exynos4.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      arm64: dts: exynos: Add GPU/Mali T760 node to Exynos5433
      arm64: dts: exynos: Add GPU/Mali T760 node to Exynos7

 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |  5 +++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 51 ++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |  5 +++
 arch/arm64/boot/dts/exynos/exynos7.dtsi            | 11 +++++
 4 files changed, 72 insertions(+)
