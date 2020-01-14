Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5734213AC24
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 15:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgANOUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 09:20:30 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1365 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726115AbgANOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:20:30 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EEDJ9I002429;
        Tue, 14 Jan 2020 15:20:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=WTFGUCLWTDzRKhLgs2q+UxAA1l4yHovIjS8c0XHL7Ts=;
 b=eS83FUjgp0iLFkBIkXcu/qIBlD3rdf4FW+3ea+xyHP71BDP3H/ICWz+eX+s0YAz4mjud
 05NJ1HvOgeFPWKYBkhAJPzKGvLgupHTzn4oNqI6Ek828o7VbY3b9irWi52Qlp3ht3l7E
 NUaiCPJP+S8gsOXJsQuW6TBv5UWBZPpKuQlGNr85eIiaLxj5LmISYQKpDpCjSieW+Eb8
 YTy1AG6LziF/fPIlLY+u40e7qx7lxbKPgPgh41Iq/77PDfENGSFwYR92Socl3SNKCEOo
 6bUkNG+adXmauv4zw4tfeaRPnSriPMCkzSu3h04bZvmzY5J7brDM49uJU360Lzh9UVBO AA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf78s5xb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 15:20:19 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CBD02100034;
        Tue, 14 Jan 2020 15:20:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 85D832BC7AB;
        Tue, 14 Jan 2020 15:20:14 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 14 Jan 2020 15:20:14
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] drm: fix parameters documentation style
Date:   Tue, 14 Jan 2020 15:20:12 +0100
Message-ID: <20200114142012.14389-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_04:2020-01-13,2020-01-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove old documentation style and use new one to avoid warnings when
compiling with W=1

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/gpu/drm/drm_dma.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_dma.c b/drivers/gpu/drm/drm_dma.c
index e45b07890c5a..f90bdd4ac69d 100644
--- a/drivers/gpu/drm/drm_dma.c
+++ b/drivers/gpu/drm/drm_dma.c
@@ -42,10 +42,10 @@
 #include "drm_legacy.h"
 
 /**
- * Initialize the DMA data.
+ * drm_legacy_dma_setup() - Initialize the DMA data.
  *
- * \param dev DRM device.
- * \return zero on success or a negative value on failure.
+ * @dev: DRM device.
+ * return zero on success or a negative value on failure.
  *
  * Allocate and initialize a drm_device_dma structure.
  */
@@ -71,9 +71,9 @@ int drm_legacy_dma_setup(struct drm_device *dev)
 }
 
 /**
- * Cleanup the DMA resources.
+ * drm_legacy_dma_takedown() - Cleanup the DMA resources.
  *
- * \param dev DRM device.
+ * @dev: DRM device.
  *
  * Free all pages associated with DMA buffers, the buffers and pages lists, and
  * finally the drm_device::dma structure itself.
@@ -120,10 +120,10 @@ void drm_legacy_dma_takedown(struct drm_device *dev)
 }
 
 /**
- * Free a buffer.
+ * drm_legacy_free_buffer() - Free a buffer.
  *
- * \param dev DRM device.
- * \param buf buffer to free.
+ * @dev: DRM device.
+ * @buf: buffer to free.
  *
  * Resets the fields of \p buf.
  */
@@ -139,9 +139,10 @@ void drm_legacy_free_buffer(struct drm_device *dev, struct drm_buf * buf)
 }
 
 /**
- * Reclaim the buffers.
+ * drm_legacy_reclaim_buffers() - Reclaim the buffers.
  *
- * \param file_priv DRM file private.
+ * @dev: DRM device.
+ * @file_priv: DRM file private.
  *
  * Frees each buffer associated with \p file_priv not already on the hardware.
  */
-- 
2.15.0

