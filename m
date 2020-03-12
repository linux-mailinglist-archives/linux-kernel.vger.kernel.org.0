Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E139E183956
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 20:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCLTTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 15:19:09 -0400
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:42804 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726553AbgCLTTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:19:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 2162F1800EC2E;
        Thu, 12 Mar 2020 19:19:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:967:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3870:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6261:7903:9025:10004:10848:11026:11473:11658:11914:12043:12048:12297:12438:12555:12679:12895:12986:13069:13311:13357:13894:13972:14096:14181:14384:14394:14721:21080:21433:21627:21811:21939:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: tank01_6c88f0addf926
X-Filterd-Recvd-Size: 2400
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 19:19:05 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm: drm_vm: Use fallthrough;
Date:   Thu, 12 Mar 2020 12:17:12 -0700
Message-Id: <398db73cdc8a584fd7f34f5013c04df13ba90f64.1584040050.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1584040050.git.joe@perches.com>
References: <cover.1584040050.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert /* fallthrough */ style comments to fallthrough;

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/

And by hand:

This file has a fallthrough comment outside of an #ifdef block
that causes gcc to emit a warning if converted in-place.

So move the new fallthrough; inside the containing #ifdef/#endif too.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/drm_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index 64619f..fd65c59 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -595,8 +595,8 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
 			vma->vm_ops = &drm_vm_ops;
 			break;
 		}
+		fallthrough;	/* to _DRM_FRAME_BUFFER... */
 #endif
-		/* fall through - to _DRM_FRAME_BUFFER... */
 	case _DRM_FRAME_BUFFER:
 	case _DRM_REGISTERS:
 		offset = drm_core_get_reg_ofs(dev);
@@ -621,7 +621,7 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
 		    vma->vm_end - vma->vm_start, vma->vm_page_prot))
 			return -EAGAIN;
 		vma->vm_page_prot = drm_dma_prot(map->type, vma);
-		/* fall through - to _DRM_SHM */
+		fallthrough;	/* to _DRM_SHM */
 	case _DRM_SHM:
 		vma->vm_ops = &drm_vm_shm_ops;
 		vma->vm_private_data = (void *)map;
-- 
2.24.0

