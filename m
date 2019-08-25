Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 009329C23D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 08:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfHYFzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 01:55:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfHYFy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 01:54:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 005772173E;
        Sun, 25 Aug 2019 05:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566712498;
        bh=NdaBtys0Xoqbyh7UBV+CzsxLktWj/rPrZ2icefpM21M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dxIZxPnsag9Fgeyj7KycYHUhKgOtNVy2XvFhs6ctdVZQS674vT0OMffS5p8kWhUIh
         5zvjtETsTYodao///2wQced4FnACJ/rMIjdq5AZiV8FOHvMdOc1FkVVtQVKJAMdWFr
         usDi3Bt+ZgH/0Iu5roZLXtovd0P96h5d6snkoy8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/9] staging: greybus: hd: Fix up some alignment checkpatch issues
Date:   Sun, 25 Aug 2019 07:54:23 +0200
Message-Id: <20190825055429.18547-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190825055429.18547-1-gregkh@linuxfoundation.org>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some function prototypes do not match the expected alignment formatting
so fix that up so that checkpatch is happy.

Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: greybus-dev@lists.linaro.org
Cc: devel@driverdev.osuosl.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/greybus/hd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/greybus/hd.c b/drivers/staging/greybus/hd.c
index 969f86697673..e2b9ab5f6ec2 100644
--- a/drivers/staging/greybus/hd.c
+++ b/drivers/staging/greybus/hd.c
@@ -31,7 +31,7 @@ int gb_hd_output(struct gb_host_device *hd, void *req, u16 size, u8 cmd,
 EXPORT_SYMBOL_GPL(gb_hd_output);
 
 static ssize_t bus_id_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+			   struct device_attribute *attr, char *buf)
 {
 	struct gb_host_device *hd = to_gb_host_device(dev);
 
@@ -70,7 +70,7 @@ EXPORT_SYMBOL_GPL(gb_hd_cport_release_reserved);
 
 /* Locking: Caller guarantees serialisation */
 int gb_hd_cport_allocate(struct gb_host_device *hd, int cport_id,
-				unsigned long flags)
+			 unsigned long flags)
 {
 	struct ida *id_map = &hd->cport_id_map;
 	int ida_start, ida_end;
@@ -122,9 +122,9 @@ struct device_type greybus_hd_type = {
 };
 
 struct gb_host_device *gb_hd_create(struct gb_hd_driver *driver,
-					struct device *parent,
-					size_t buffer_size_max,
-					size_t num_cports)
+				    struct device *parent,
+				    size_t buffer_size_max,
+				    size_t num_cports)
 {
 	struct gb_host_device *hd;
 	int ret;
-- 
2.23.0

