Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B95130378
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 17:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgADQWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 11:22:09 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:16409 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgADQWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:22:08 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 004GLdDO002506;
        Sun, 5 Jan 2020 01:21:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 004GLdDO002506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578154899;
        bh=inGRar/36DuAvId9san8la6FXfoLzIDHO0k/ekyTCzk=;
        h=From:To:Cc:Subject:Date:From;
        b=oBklGmFOApViN6lRtO/l5EJXmd+Kd1MlnRq0rHNF0dt7I/lvZvSFwg+mEtDGOc6Ws
         HHVvt1+BRoPl3JgY6z2hv8EEz6iqhzq2Z1/HTLUp/t3ryjIWT4BrAOtQ1TdNkkOTJP
         vHxeOvau22MHGM70WWbhz6uwUNpmUPSwm0tf4EQfM7M6U0reXvVnSGHBBJRm8nr1W0
         h5Z/nd7Fn034CSsIAw29cz1PpFWSG8dGFGwCR1Cazb+4Uh7ny0MXdp9W2ond5yunij
         9/7lC5OAWquwR6Msgcl8Cmcoqz4V31Pqhiz5kqGSZDc5zhPwhVvyZaqDrVbkDdb3US
         UiWUOsatXIDGQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: rtl8192u: remove unused Makefile
Date:   Sun,  5 Jan 2020 01:21:34 +0900
Message-Id: <20200104162136.19170-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/staging/rtl8192u/ieee80211/Makefile is not used at all.
All the build rules are described in drivers/staging/rtl8192u/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/staging/rtl8192u/ieee80211/Makefile | 27 ---------------------
 1 file changed, 27 deletions(-)
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/Makefile

diff --git a/drivers/staging/rtl8192u/ieee80211/Makefile b/drivers/staging/rtl8192u/ieee80211/Makefile
deleted file mode 100644
index 0d4d6489f767..000000000000
--- a/drivers/staging/rtl8192u/ieee80211/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-NIC_SELECT = RTL8192U
-
-ccflags-y := -O2
-ccflags-y += -DJACKSON_NEW_8187 -DJACKSON_NEW_RX
-
-ieee80211-rsl-objs := ieee80211_rx.o \
-		      ieee80211_softmac.o \
-		      ieee80211_tx.o \
-		      ieee80211_wx.o \
-		      ieee80211_module.o \
-		      ieee80211_softmac_wx.o\
-		      rtl819x_HTProc.o\
-		      rtl819x_TSProc.o\
-		      rtl819x_BAProc.o\
-		      dot11d.o
-
-ieee80211_crypt-rsl-objs := ieee80211_crypt.o
-ieee80211_crypt_tkip-rsl-objs := ieee80211_crypt_tkip.o
-ieee80211_crypt_ccmp-rsl-objs := ieee80211_crypt_ccmp.o
-ieee80211_crypt_wep-rsl-objs := ieee80211_crypt_wep.o
-
-obj-m +=ieee80211-rsl.o
-obj-m +=ieee80211_crypt-rsl.o
-obj-m +=ieee80211_crypt_wep-rsl.o
-obj-m +=ieee80211_crypt_tkip-rsl.o
-obj-m +=ieee80211_crypt_ccmp-rsl.o
-- 
2.17.1

