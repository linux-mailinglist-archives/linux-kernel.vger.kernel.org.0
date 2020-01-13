Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A5213964D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 17:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAMQ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 11:28:51 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37937 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728905AbgAMQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:28:48 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 13 Jan 2020 18:28:42 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 00DGSefX032667;
        Mon, 13 Jan 2020 18:28:42 +0200
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v3 02/11] Documentation/ABI: Fix documentation inconsistency for mlxreg-io sysfs interfaces
Date:   Mon, 13 Jan 2020 16:28:30 +0000
Message-Id: <20200113162839.18103-3-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200113162839.18103-1-vadimp@mellanox.com>
References: <20200113162839.18103-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix attribute name from "jtag_enable", which described twice to
"cpld3_version", which is expected to be instead of second appearance
of "jtag_enable".

Fixes: 2752e34442b5 ("Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
v1-v2:
 Comments pointed out by Andy:
 - Explain that patch fixes documentation inconsistency.
---
 Documentation/ABI/stable/sysfs-driver-mlxreg-io | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
index 8ca498447aeb..8b1461fa3538 100644
--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -29,13 +29,13 @@ Description:	This file shows the system fans direction:
 
 		The files are read only.
 
-What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/jtag_enable
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld3_version
 
 Date:		November 2018
 KernelVersion:	5.0
 Contact:	Vadim Pasternak <vadimpmellanox.com>
 Description:	These files show with which CPLD versions have been burned
-		on LED board.
+		on LED or Gearbox board.
 
 		The files are read only.
 
-- 
2.11.0

