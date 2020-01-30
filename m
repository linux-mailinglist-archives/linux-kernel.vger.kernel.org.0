Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2E114DB11
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 13:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgA3Mzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 07:55:35 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:59856 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgA3Mze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:55:34 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id wcvX210045USYZQ01cvXks; Thu, 30 Jan 2020 13:55:31 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ix9M2-0001OV-Vw; Thu, 30 Jan 2020 13:55:30 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ix9M2-0000bu-TS; Thu, 30 Jan 2020 13:55:30 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Orson Zhai <orson.zhai@unisoc.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mfd: syscon: Fix syscon_regmap_lookup_by_phandle_args() dummy
Date:   Thu, 30 Jan 2020 13:55:29 +0100
Message-Id: <20200130125529.2304-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_MFD_SYSCON=n:

    include/linux/mfd/syscon.h:54:23: warning: ‘syscon_regmap_lookup_by_phandle_args’ defined but not used [-Wunused-function]

Fix this by adding the missing inline keyword.

Fixes: 6a24f567af4accef ("mfd: syscon: Add arguments support for syscon reference")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/mfd/syscon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 714cab1e09d3c1fd..7f20e9b502a5bd48 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -51,7 +51,7 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle(
 	return ERR_PTR(-ENOTSUPP);
 }
 
-static struct regmap *syscon_regmap_lookup_by_phandle_args(
+static inline struct regmap *syscon_regmap_lookup_by_phandle_args(
 					struct device_node *np,
 					const char *property,
 					int arg_count,
-- 
2.17.1

