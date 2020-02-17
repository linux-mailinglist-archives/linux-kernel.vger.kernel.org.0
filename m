Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD7316183E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 17:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgBQQul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 11:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgBQQuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:50:40 -0500
Received: from localhost.localdomain (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0548B215A4;
        Mon, 17 Feb 2020 16:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581958240;
        bh=JjNDVJm+v6HWDhnhInttXBEV3fn14//iNMHEewyjbmU=;
        h=From:To:Subject:Date:From;
        b=10Ach5BGGNWH6/e4qlfWlP9MDZ88BG00bJAdYes1Ymu8vf1eQl7nDdeMe2xWKk++e
         UxSWIDCS59WGX8T5uM1ThwhrnL5QmxIXUwhefnLgp+l3xJgUv2G33NrfEXqbhRmqXF
         +s0wuNL4mS7vyaVq1pb080O7QVZV8tA1Kcy13U3E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Brian Cain <bcain@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] hexagon: configs: Cleanup CONFIG_CROSS_COMPILE
Date:   Mon, 17 Feb 2020 17:50:34 +0100
Message-Id: <20200217165034.4649-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
CONFIG_CROSS_COMPILE support").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/hexagon/configs/comet_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index e324f65f41e7..9e0da536c0c6 100644
--- a/arch/hexagon/configs/comet_defconfig
+++ b/arch/hexagon/configs/comet_defconfig
@@ -2,7 +2,6 @@ CONFIG_SMP=y
 CONFIG_DEFAULT_MMAP_MIN_ADDR=0
 CONFIG_HZ_100=y
 CONFIG_EXPERIMENTAL=y
-CONFIG_CROSS_COMPILE="hexagon-"
 CONFIG_LOCALVERSION="-smp"
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
-- 
2.17.1

