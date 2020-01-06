Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D37131399
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 15:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgAFOaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 09:30:00 -0500
Received: from www413.your-server.de ([88.198.28.140]:34370 "EHLO
        www413.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAFOaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:30:00 -0500
X-Greylist: delayed 1404 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jan 2020 09:29:59 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberus-technology.de; s=default1911; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KW11SDNZTlK7yN6ChFi9azprOFMlb/1DKxBGOgh5XZ8=; b=P9P3UkKtEz5Dlo8dbhVf8CD1A
        bLj4pxDJftJAQRIyF81VopSSYEvCiX3LWV1w3NfaupnjxcxWOKXxAdbed8XNXpr4ucsh9nJ++c1S+
        0tvALkmv57cTPxmiHNev+6iaoPf0pa5ONsKqScprNTWn7Ku+WB8nSX7E+4IujARvytujG5gfgq17L
        KL0a8mBotA0Aq7XfcxlojjJbHwK2WGHhmKv9URZiyL1YFcSmiVnIE9iDiRTfw1iTcu8pZV7tRb12Y
        ZW0QqAMGexGxfi2KMomYRVjofx2SmJ2e2dVLHCeI7sX7UK3otELyj5110HTBhaVXLqI27j0YN/glj
        4gVlzUilw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www413.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1ioT1d-0008HA-Vx; Mon, 06 Jan 2020 15:06:34 +0100
Received: from [188.25.180.214] (helo=192-168-0-109.rdsnet.ro)
        by sslproxy06.your-server.de with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.89)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1ioT1d-000Xjb-MN; Mon, 06 Jan 2020 15:06:33 +0100
From:   Julian Stecklina <julian.stecklina@cyberus-technology.de>
To:     intel-gvt-dev@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Julian Stecklina <julian.stecklina@cyberus-technology.de>,
        Zhenyu Wang <zhenyuw@linux.intel.com>, zhiyuan.lv@intel.com,
        hang.yuan@intel.com
Subject: [PATCH 1/3] drm/i915/gvt: fix file paths in documentation
Date:   Mon,  6 Jan 2020 16:06:20 +0200
Message-Id: <20200106140622.14393-1-julian.stecklina@cyberus-technology.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: julian.stecklina@cyberus-technology.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25686/Mon Jan  6 10:55:07 2020)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation had some stale paths to i915 graphics virtualization
code. Fix them to point to existing files.

Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: zhiyuan.lv@intel.com
Cc: hang.yuan@intel.com

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 Documentation/gpu/i915.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index e539c42a3e78..d644683c5249 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -43,19 +43,19 @@ Interrupt Handling
 Intel GVT-g Guest Support(vGPU)
 -------------------------------
 
-.. kernel-doc:: drivers/gpu/drm/i915/i915_vgpu.c
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/vgpu.c
    :doc: Intel GVT-g guest support
 
-.. kernel-doc:: drivers/gpu/drm/i915/i915_vgpu.c
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/vgpu.c
    :internal:
 
 Intel GVT-g Host Support(vGPU device model)
 -------------------------------------------
 
-.. kernel-doc:: drivers/gpu/drm/i915/intel_gvt.c
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/gvt.c
    :doc: Intel GVT-g host support
 
-.. kernel-doc:: drivers/gpu/drm/i915/intel_gvt.c
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/gvt.c
    :internal:
 
 Workarounds
-- 
2.24.1

