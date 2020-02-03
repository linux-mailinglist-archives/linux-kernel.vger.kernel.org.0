Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E1E1505C5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 13:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgBCMCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 07:02:02 -0500
Received: from ned.t-8ch.de ([212.47.237.191]:51346 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgBCMCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 07:02:02 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1580731317;
        bh=4/3u1sKFM78XGpkDgV4KNfly5sI7hYOdhg5y4muK8Lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tiRuLmOWmKUlsf73d/RpDcRBqodTshHrmqFSOw6g4NxO89rr24sIkdXWp1HV/waeW
         KbD0P6owGs/uQbY3CVho8b6vGx+lSKtV+ql606cvMUqDcJ8OHPr3y5OF0P8/Q/w+Vk
         6ek0jfNIDR/0qAfst1ekEGCTyra6Il8maH0xwDpA=
To:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 1/2] platform/x86: thinkpad_acpi: remove unused defines
Date:   Mon,  3 Feb 2020 13:01:31 +0100
Message-Id: <20200203120132.102576-2-linux@weissschuh.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203120132.102576-1-linux@weissschuh.net>
References: <20200131143650.4149-1-linux@weissschuh.net>
 <20200203120132.102576-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They were never used.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/thinkpad_acpi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index da794dcfdd92..2d3a99e3efb7 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9323,9 +9323,6 @@ static struct ibm_struct mute_led_driver_data = {
 #define GET_STOP	"BCSG"
 #define SET_STOP	"BCSS"
 
-#define START_ATTR "charge_start_threshold"
-#define STOP_ATTR  "charge_stop_threshold"
-
 enum {
 	BAT_ANY = 0,
 	BAT_PRIMARY = 1,
-- 
2.25.0

