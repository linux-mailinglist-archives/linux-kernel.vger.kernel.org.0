Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B03B14E30D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 20:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgA3TVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 14:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbgA3TVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:21:17 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D290206D3;
        Thu, 30 Jan 2020 19:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580412076;
        bh=JjNDVJm+v6HWDhnhInttXBEV3fn14//iNMHEewyjbmU=;
        h=From:To:Cc:Subject:Date:From;
        b=zUmQ+u4BkxmGfeOUI8WwSq1SbFxKIzuVcQaChR/h+kuMhEOOTvdcM9xpu+Js6fyVl
         zWj8QwJmW3aG0X2Er9ohpGLt/sFBJOl2cUOORIaxy94VkR39YS+Xnjlt+JKO1407UU
         NamPrJp2f/FJy/YwpNX64fGSrKoPW+6puX+eFc3A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] hexagon: configs: Cleanup CONFIG_CROSS_COMPILE
Date:   Thu, 30 Jan 2020 20:21:10 +0100
Message-Id: <20200130192110.2605-1-krzk@kernel.org>
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

