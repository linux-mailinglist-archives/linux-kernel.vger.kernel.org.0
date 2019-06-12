Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AFC448EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 19:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393608AbfFMRMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 13:12:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:38392 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbfFLWNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 18:13:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 15:13:31 -0700
X-ExtLoop1: 1
Received: from fei-dev-host.jf.intel.com ([10.7.198.158])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2019 15:13:31 -0700
From:   fei.yang@intel.com
To:     felipe.balbi@linux.intel.com, john.stultz@linaro.org,
        mgautam@codeaurora.org, andrzej.p@samsung.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH] usb: gadget: f_fs: data_len used before properly set
Date:   Wed, 12 Jun 2019 15:13:26 -0700
Message-Id: <1560377606-40855-1-git-send-email-fei.yang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fei Yang <fei.yang@intel.com>

The following line of code in function ffs_epfile_io is trying to set
flag io_data->use_sg in case buffer required is larger than one page.

    io_data->use_sg = gadget->sg_supported && data_len > PAGE_SIZE;

However at this point of time the variable data_len has not been set
to the proper buffer size yet. The consequence is that io_data->use_sg
is always set regardless what buffer size really is, because the condition
(data_len > PAGE_SIZE) is effectively an unsigned comparison between
-EINVAL and PAGE_SIZE which would always result in TRUE.

Fixes: 772a7a724f69 ("usb: gadget: f_fs: Allow scatter-gather buffers")
Signed-off-by: Fei Yang <fei.yang@intel.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 47be961..c7ed900 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -997,7 +997,6 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 		 * earlier
 		 */
 		gadget = epfile->ffs->gadget;
-		io_data->use_sg = gadget->sg_supported && data_len > PAGE_SIZE;
 
 		spin_lock_irq(&epfile->ffs->eps_lock);
 		/* In the meantime, endpoint got disabled or changed. */
@@ -1012,6 +1011,8 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 		 */
 		if (io_data->read)
 			data_len = usb_ep_align_maybe(gadget, ep->ep, data_len);
+
+		io_data->use_sg = gadget->sg_supported && data_len > PAGE_SIZE;
 		spin_unlock_irq(&epfile->ffs->eps_lock);
 
 		data = ffs_alloc_buffer(io_data, data_len);
-- 
2.7.4

