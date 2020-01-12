Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53EAA138724
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 17:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbgALQ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 11:56:18 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:41944 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733102AbgALQ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:56:17 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id pUwG2100B5USYZQ01UwGad; Sun, 12 Jan 2020 17:56:16 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgXA-00082w-6V; Sun, 12 Jan 2020 17:56:16 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgXA-0005Su-5P; Sun, 12 Jan 2020 17:56:16 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Philip Blundell <philb@gnu.org>
Cc:     linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] dio: Fix dio_bus_match() kerneldoc
Date:   Sun, 12 Jan 2020 17:56:12 +0100
Message-Id: <20200112165613.20960-3-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200112165613.20960-1-geert@linux-m68k.org>
References: <20200112165613.20960-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kerneldoc for dio_bus_match() was obviously copied from
dio_match_device(), but wasnt't updated for the different calling
context and semantics.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/dio/dio-driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dio/dio-driver.c b/drivers/dio/dio-driver.c
index daf87e214a7794c2..69c46935ffc78cef 100644
--- a/drivers/dio/dio-driver.c
+++ b/drivers/dio/dio-driver.c
@@ -105,9 +105,9 @@ void dio_unregister_driver(struct dio_driver *drv)
  *  @dev: the DIO device structure to match against
  *  @drv: the &device_driver that points to the array of DIO device id structures to search
  *
- *  Used by a driver to check whether a DIO device present in the
- *  system is in its list of supported devices. Returns the matching
- *  dio_device_id structure or %NULL if there is no match.
+ *  Used by the driver core to check whether a DIO device present in the
+ *  system is in a driver's list of supported devices. Returns 1 if supported,
+ *  and 0 if there is no match.
  */
 
 static int dio_bus_match(struct device *dev, struct device_driver *drv)
-- 
2.17.1

