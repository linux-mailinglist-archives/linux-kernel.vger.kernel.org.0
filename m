Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D89816183C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 17:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgBQQtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 11:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbgBQQtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:49:32 -0500
Received: from localhost.localdomain (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E093E215A4;
        Mon, 17 Feb 2020 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581958172;
        bh=Bo84A/kxFg9BvW/sBxgwAxG+cmoRsZqYK8+9wCJh2yg=;
        h=From:To:Subject:Date:From;
        b=qyTIywZZYcCaCqHM69xSGQmZQwrTQ6nC+FJJYHM5uMap/Pn5MhfuE+f+Ev50M7U5g
         3xSD/HOsKo2gMWTFdyaRmVPXLapP7ilnP2ND7xpxLBqIvuPUXnegWqmOhAhapLUCy7
         Fci1FZdtMPVh7sgb1Hq0o5aQq/44saX84pW2M0zM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] nds32: configs: Cleanup CONFIG_CROSS_COMPILE
Date:   Mon, 17 Feb 2020 17:49:18 +0100
Message-Id: <20200217164918.4352-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
CONFIG_CROSS_COMPILE support").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Greentime Hu <green.hu@gmail.com>

---

Changes since v1:
1. Add Hu's ack.
---
 arch/nds32/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/nds32/configs/defconfig b/arch/nds32/configs/defconfig
index 40313a635075..f9a89cf00aa6 100644
--- a/arch/nds32/configs/defconfig
+++ b/arch/nds32/configs/defconfig
@@ -1,4 +1,3 @@
-CONFIG_CROSS_COMPILE="nds32le-linux-"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_HIGH_RES_TIMERS=y
-- 
2.17.1

