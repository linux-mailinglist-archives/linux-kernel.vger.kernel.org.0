Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B40B010ABC7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 09:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfK0IcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 03:32:12 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:5582 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfK0IcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:32:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 7F79F47EA1;
        Wed, 27 Nov 2019 09:32:09 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=q/LGqXta;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a_IqFsCwa9rn; Wed, 27 Nov 2019 09:32:05 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 6B5A547E6D;
        Wed, 27 Nov 2019 09:32:05 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 2B8F9360613;
        Wed, 27 Nov 2019 09:32:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1574843523; bh=jwqCDK65X9Nr+vj6cWmXV754kCheRvIPRNrCN2QVJEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/LGqXta7HOJSbHX/Md2zh0jsJ6qRrtj0g/2wNu8YavfwNFdcBSaGLnfG9bGlBx54
         l3vHs/z975lQhi7pZRVPM2xcSfTHe+ChIzxduIRP2Svv1dd0UyPzehiVX5v7wVijKy
         sUmId1v0OlERZKw/qG4aWNUjCBV9exIglLuPq1CM=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-graphics-maintainer@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC PATCH 7/7] drm/vmwgfx: Hook up the helpers to align buffer objects
Date:   Wed, 27 Nov 2019 09:31:20 +0100
Message-Id: <20191127083120.34611-8-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191127083120.34611-1-thomas_os@shipmail.org>
References: <20191127083120.34611-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Start using the helpers that align buffer object user-space addresses and
buffer object vram addresses to huge page boundaries.
This is to improve the chances of allowing huge page-table entries.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        | 13 +++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h        |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 81a95651643f..ebeaea4b87e9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1216,6 +1216,18 @@ static void vmw_remove(struct pci_dev *pdev)
 	drm_put_dev(dev);
 }
 
+static unsigned long
+vmw_get_unmapped_area(struct file *file, unsigned long uaddr,
+		      unsigned long len, unsigned long pgoff,
+		      unsigned long flags)
+{
+	struct drm_file *file_priv = file->private_data;
+	struct vmw_private *dev_priv = vmw_priv(file_priv->minor->dev);
+
+	return drm_get_unmapped_area(file, uaddr, len, pgoff, flags,
+				     &dev_priv->vma_manager);
+}
+
 static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long val,
 			      void *ptr)
 {
@@ -1387,6 +1399,7 @@ static const struct file_operations vmwgfx_driver_fops = {
 	.compat_ioctl = vmw_compat_ioctl,
 #endif
 	.llseek = noop_llseek,
+	.get_unmapped_area = vmw_get_unmapped_area,
 };
 
 static struct drm_driver driver = {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index b18842f73081..7232e912dbc0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -918,6 +918,7 @@ extern int vmw_mmap(struct file *filp, struct vm_area_struct *vma);
 
 extern void vmw_validation_mem_init_ttm(struct vmw_private *dev_priv,
 					size_t gran);
+
 /**
  * TTM buffer object driver - vmwgfx_ttm_buffer.c
  */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index d8ea3dd10af0..c319fe0ca912 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -754,7 +754,7 @@ static int vmw_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 		break;
 	case TTM_PL_VRAM:
 		/* "On-card" video ram */
-		man->func = &ttm_bo_manager_func;
+		man->func = &ttm_bo_manager_huge_func;
 		man->gpu_offset = 0;
 		man->flags = TTM_MEMTYPE_FLAG_FIXED | TTM_MEMTYPE_FLAG_MAPPABLE;
 		man->available_caching = TTM_PL_FLAG_CACHED;
-- 
2.21.0

