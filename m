Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A5F130377
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 17:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgADQWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 11:22:09 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:16416 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgADQWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:22:08 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 004GLdDQ002506;
        Sun, 5 Jan 2020 01:21:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 004GLdDQ002506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578154901;
        bh=TiqaSYY64Xax1WPIpJLYHP6PC75uVkv3yj3Gmy8qOdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDqe5oDIs4wHlEbsckx2Go9tmXFjLDVDFEoUnLnRL014+tARk14GWDQW/7wB7NG77
         RSXdxasGPp3c2xLZm9iMMNQGlNAky8rhr5ik4Nd6da8DvtTRaqVPAQdzy+U3tUY+6e
         qzSTXuCOpsFLM97G4MccHy0CK6QRIIRTIiTFDJHbM4UORbXz+7g+sQ8+YIqXRwZKyG
         MnlKvt0bkDfdaPQoNLW804DDZbBRVsq2c+uVdvDzQgck7uTm8YuoBOx/4I0GTaIbFx
         UPScMf80D8V0o3inI8TSBiUNNg6moh9Hg+3Hj60P94g0ADlpA344k/95nvNjJcBxWj
         tdg+ES4zoz6PA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: rtl8192u: remove unneeded compiler flags
Date:   Sun,  5 Jan 2020 01:21:36 +0900
Message-Id: <20200104162136.19170-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104162136.19170-1-masahiroy@kernel.org>
References: <20200104162136.19170-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-std=gnu89 is specified by the top Makefile. Adding it in a driver
Makefile is redundant.

A driver should avoid specifying the optimization flag.
-O2, -O3, or -Os is passed by the top Makefile based on the
CONFIG_CC_OPTIMIZE_FOR_* option.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/staging/rtl8192u/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/Makefile b/drivers/staging/rtl8192u/Makefile
index a7e5d3d91d9c..0be7426b6ebc 100644
--- a/drivers/staging/rtl8192u/Makefile
+++ b/drivers/staging/rtl8192u/Makefile
@@ -1,9 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 NIC_SELECT = RTL8192U
 
-ccflags-y := -std=gnu89
-ccflags-y += -O2
-
 ccflags-y += -DCONFIG_FORCE_HARD_FLOAT=y
 ccflags-y += -DJACKSON_NEW_8187 -DJACKSON_NEW_RX
 ccflags-y += -DTHOMAS_BEACON -DTHOMAS_TASKLET -DTHOMAS_SKB -DTHOMAS_TURBO
-- 
2.17.1

