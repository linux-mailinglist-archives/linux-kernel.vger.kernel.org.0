Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E198D76577
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 14:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfGZMOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 08:14:11 -0400
Received: from mail.saltedge.com ([148.251.41.210]:48540 "EHLO
        mail.saltedge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfGZMOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:14:10 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jul 2019 08:14:10 EDT
Received: from [192.168.100.145] (unknown [195.22.227.78])
        by mail.saltedge.com (Postfix) with ESMTPSA id 8238060538;
        Fri, 26 Jul 2019 12:07:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.saltedge.com 8238060538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saltedge.com;
        s=mail; t=1564142821;
        bh=x+Z5a9e8cJYLnAWaP567zFw2cFIDZlyHj4wl4q4yb28=;
        h=Subject:From:To:Cc:Date:From;
        b=WFgDVPynf+7Gr9tbYyHNLsmEWubiJz39Z8O6fkbxNhUm2xX1rFXCRKmGyv1+jhYqQ
         HUvEGIaY8DjCZkLZJUPHwNJ0uw9vdfujBUJUKo2iBXPZLy+Mkoy8yYJpN6pfOfs4Ho
         7PdoFXe78twwr9PXRySqy8OLml/xxXDZbAV4FlWU=
Message-ID: <667a5b466e7daa22e1901d02cc708542020513b0.camel@saltedge.com>
Subject: [PATCH][RESEND] drm/amdkfd: add missing 'break' statement
From:   Alexandr Savca <alexandr.savca@saltedge.com>
To:     linux-kernel@vger.kernel.org
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, oded.gabbay@gmail.com
Date:   Fri, 26 Jul 2019 15:07:15 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at mail.saltedge.com
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing 'break' statement which was introduced by the previous
commit.

Signed-off-by: Alexandr Savca <alexandr.savca@saltedge.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 792371442195..4e3fc284f6ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -668,6 +668,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev
*kdev,
        case CHIP_RAVEN:
                pcache_info = raven_cache_info;
                num_of_cache_types = ARRAY_SIZE(raven_cache_info);
+               break;
        case CHIP_NAVI10:
                pcache_info = navi10_cache_info;
                num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
-- 
2.20.1

