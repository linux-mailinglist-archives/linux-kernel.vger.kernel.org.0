Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C2AFD44B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 06:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfKOF3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 00:29:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46419 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfKOF3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 00:29:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id r18so5236795pgu.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 21:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CUnOECriyCGPMUs77nJPQe7W5fpmBDeLqmFUMqLQ4ns=;
        b=Gf4KiRVkt5957A/5n6CMLoowxR8z89RL/D0JR0F6914IPtMblpAY4h5Xoi9sdMp3/E
         mISlvAOtrAE+Wx+DOFWewx7Vc/MHnH7dcYrwhGCUKGBdejf3nj9TgYxOoQ2Le92rls14
         //g9j6jhqKm04JhOvkLBp2rT6njmcbRAPBs7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CUnOECriyCGPMUs77nJPQe7W5fpmBDeLqmFUMqLQ4ns=;
        b=WqGOHzz0GftYEfqI2RBdeJ42WAKGmXbgGoI9c80GAYTUPwubT8kb/X/kfRIwso2bPc
         olmyOAyTdBghM51l2QZ3M2R5Zx7QHBfRKfWp0jDT6diUPoJEqFLKMRPm+XqBtFqKbArz
         vjYV2YAHFmzMgFTHZ1J0GxNoliPPRU+LgiyqBJ5UNIy6PVXGzKCRFelfZsOYy4Kqfsdu
         lIMToiFhV9jSRrGYRvMjMQ+4iKrjzIbq9E7QCQDcRpSR4m6iZAIu8vg5DBJKWfqzO6ce
         /t8TV+mkSGNTNFNQJ++Bef0kBAXp5X7g4sE0BfMgwDJQAlObszM/mJxnfotXjYHCANox
         eDQg==
X-Gm-Message-State: APjAAAUdbmPWWrTSeoZWVNfz8cuI7F9Geo4RSVGynbU+TYHFTJuCp5sB
        Sr9dBQI5Xm8FEGxrJjSuW1G6gg==
X-Google-Smtp-Source: APXvYqxCchciC7RO/ge8MF6qR0zrw7E75p61yGCLl/oKfJf8e1BMGrQHsuVEhe+hQi9MUpPZRZKyEw==
X-Received: by 2002:a63:ca05:: with SMTP id n5mr14155578pgi.187.1573795785766;
        Thu, 14 Nov 2019 21:29:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w6sm661086pge.92.2019.11.14.21.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 21:29:42 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-everest-linux-l2@marvell.com,
        Sami Tolvanen <samitolvanen@google.com>,
        netdev@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] bnx2x: Remove format_fw_ver_t function casts
Date:   Thu, 14 Nov 2019 21:07:14 -0800
Message-Id: <20191115050715.6247-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115050715.6247-1-keescook@chromium.org>
References: <20191115050715.6247-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return values for format_fw_ver_t callbacks are supposed to be
"int", not "u8". Ultimately, the top-level caller doesn't actually check
the return value at all, but just clean this all up anyway and fix the
prototypes so that casts are no longer needed.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_link.c  | 22 +++++++++----------
 .../net/ethernet/broadcom/bnx2x/bnx2x_link.h  |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
index 2bc6408ce00d..7dd35aa75925 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c
@@ -11767,7 +11767,7 @@ static const struct bnx2x_phy phy_7101 = {
 	.read_status	= bnx2x_7101_read_status,
 	.link_reset	= bnx2x_common_ext_link_reset,
 	.config_loopback = bnx2x_7101_config_loopback,
-	.format_fw_ver	= (format_fw_ver_t)bnx2x_7101_format_ver,
+	.format_fw_ver	= bnx2x_7101_format_ver,
 	.hw_reset	= (hw_reset_t)bnx2x_7101_hw_reset,
 	.set_link_led	= bnx2x_7101_set_link_led,
 	.phy_specific_func = NULL
@@ -11798,7 +11798,7 @@ static const struct bnx2x_phy phy_8073 = {
 	.read_status	= bnx2x_8073_read_status,
 	.link_reset	= bnx2x_8073_link_reset,
 	.config_loopback = NULL,
-	.format_fw_ver	= (format_fw_ver_t)bnx2x_format_ver,
+	.format_fw_ver	= bnx2x_format_ver,
 	.hw_reset	= NULL,
 	.set_link_led	= NULL,
 	.phy_specific_func = bnx2x_8073_specific_func
@@ -11826,7 +11826,7 @@ static const struct bnx2x_phy phy_8705 = {
 	.read_status	= bnx2x_8705_read_status,
 	.link_reset	= bnx2x_common_ext_link_reset,
 	.config_loopback = NULL,
-	.format_fw_ver	= (format_fw_ver_t)bnx2x_null_format_ver,
+	.format_fw_ver	= bnx2x_null_format_ver,
 	.hw_reset	= NULL,
 	.set_link_led	= NULL,
 	.phy_specific_func = NULL
@@ -11855,7 +11855,7 @@ static const struct bnx2x_phy phy_8706 = {
 	.read_status	= bnx2x_8706_read_status,
 	.link_reset	= bnx2x_common_ext_link_reset,
 	.config_loopback = NULL,
-	.format_fw_ver	= (format_fw_ver_t)bnx2x_format_ver,
+	.format_fw_ver	= bnx2x_format_ver,
 	.hw_reset	= NULL,
 	.set_link_led	= NULL,
 	.phy_specific_func = NULL
@@ -11887,7 +11887,7 @@ static const struct bnx2x_phy phy_8726 = {
 	.read_status	= bnx2x_8726_read_status,
 	.link_reset	= bnx2x_8726_link_reset,
 	.config_loopback = bnx2x_8726_config_loopback,
-	.format_fw_ver	= (format_fw_ver_t)bnx2x_format_ver,
+	.format_fw_ver	= bnx2x_format_ver,
 	.hw_reset	= NULL,
 	.set_link_led	= NULL,
 	.phy_specific_func = NULL
@@ -11918,7 +11918,7 @@ static const struct bnx2x_phy phy_8727 = {
 	.read_status	= bnx2x_8727_read_status,
 	.link_reset	= bnx2x_8727_link_reset,
 	.config_loopback = NULL,
-	.format_fw_ver	= (format_fw_ver_t)bnx2x_format_ver,
+	.format_fw_ver	= bnx2x_format_ver,
 	.hw_reset	= (hw_reset_t)bnx2x_8727_hw_reset,
 	.set_link_led	= bnx2x_8727_set_link_led,
 	.phy_specific_func = bnx2x_8727_specific_func
@@ -11953,7 +11953,7 @@ static const struct bnx2x_phy phy_8481 = {
 	.read_status	= bnx2x_848xx_read_status,
 	.link_reset	= bnx2x_8481_link_reset,
 	.config_loopback = NULL,
-	.format_fw_ver	= (format_fw_ver_t)bnx2x_848xx_format_ver,
+	.format_fw_ver	= bnx2x_848xx_format_ver,
 	.hw_reset	= (hw_reset_t)bnx2x_8481_hw_reset,
 	.set_link_led	= bnx2x_848xx_set_link_led,
 	.phy_specific_func = NULL
@@ -11990,7 +11990,7 @@ static const struct bnx2x_phy phy_84823 = {
 	.read_status	= bnx2x_848xx_read_status,
 	.link_reset	= bnx2x_848x3_link_reset,
 	.config_loopback = NULL,
-	.format_fw_ver	= (format_fw_ver_t)bnx2x_848xx_format_ver,
+	.format_fw_ver	= bnx2x_848xx_format_ver,
 	.hw_reset	= NULL,
 	.set_link_led	= bnx2x_848xx_set_link_led,
 	.phy_specific_func = bnx2x_848xx_specific_func
@@ -12025,7 +12025,7 @@ static const struct bnx2x_phy phy_84833 = {
 	.read_status	= bnx2x_848xx_read_status,
 	.link_reset	= bnx2x_848x3_link_reset,
 	.config_loopback = NULL,
-	.format_fw_ver	= (format_fw_ver_t)bnx2x_848xx_format_ver,
+	.format_fw_ver	= bnx2x_848xx_format_ver,
 	.hw_reset	= (hw_reset_t)bnx2x_84833_hw_reset_phy,
 	.set_link_led	= bnx2x_848xx_set_link_led,
 	.phy_specific_func = bnx2x_848xx_specific_func
@@ -12059,7 +12059,7 @@ static const struct bnx2x_phy phy_84834 = {
 	.read_status	= bnx2x_848xx_read_status,
 	.link_reset	= bnx2x_848x3_link_reset,
 	.config_loopback = NULL,
-	.format_fw_ver	= (format_fw_ver_t)bnx2x_848xx_format_ver,
+	.format_fw_ver	= bnx2x_848xx_format_ver,
 	.hw_reset	= (hw_reset_t)bnx2x_84833_hw_reset_phy,
 	.set_link_led	= bnx2x_848xx_set_link_led,
 	.phy_specific_func = bnx2x_848xx_specific_func
@@ -12093,7 +12093,7 @@ static const struct bnx2x_phy phy_84858 = {
 	.read_status	= bnx2x_848xx_read_status,
 	.link_reset	= bnx2x_848x3_link_reset,
 	.config_loopback = NULL,
-	.format_fw_ver	= (format_fw_ver_t)bnx2x_8485x_format_ver,
+	.format_fw_ver	= bnx2x_8485x_format_ver,
 	.hw_reset	= (hw_reset_t)bnx2x_84833_hw_reset_phy,
 	.set_link_led	= bnx2x_848xx_set_link_led,
 	.phy_specific_func = bnx2x_848xx_specific_func
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.h
index d31d15c78a17..cae03c89dc73 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.h
@@ -135,7 +135,7 @@ typedef void (*link_reset_t)(struct bnx2x_phy *phy,
 			     struct link_params *params);
 typedef void (*config_loopback_t)(struct bnx2x_phy *phy,
 				  struct link_params *params);
-typedef u8 (*format_fw_ver_t)(u32 raw, u8 *str, u16 *len);
+typedef int (*format_fw_ver_t)(u32 raw, u8 *str, u16 *len);
 typedef void (*hw_reset_t)(struct bnx2x_phy *phy, struct link_params *params);
 typedef void (*set_link_led_t)(struct bnx2x_phy *phy,
 			       struct link_params *params, u8 mode);
-- 
2.17.1

