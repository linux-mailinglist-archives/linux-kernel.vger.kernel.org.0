Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F22E6667DA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfGLHiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 03:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfGLHix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:38:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E619208E4;
        Fri, 12 Jul 2019 07:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562917132;
        bh=2qIqkpyUwKy5ZEg6KI4VLnowH1Qpn3q5tnQKn5M+iiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SocOGJdYS12ewRV0pv3s74pJMdr91qiXFF8Ku/1UEgVOlKku22bL54eFvoS0DY7gD
         gjVF3y0n/P3SGwJ4sjM5zMGFUduUW0XIP+7rECgbvG6Hyvf0Zbst3WUb48CwAeFC2m
         J5jztwHBRjPBoey3UYkN2UZg1RZqSyiSzHAvpCFk=
Date:   Fri, 12 Jul 2019 09:38:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core patches for 5.3-rc1
Message-ID: <20190712073850.GC16253@kroah.com>
References: <20190712073623.GA16253@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20190712073623.GA16253@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2019 at 09:36:23AM +0200, Greg KH wrote:
> The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:
> 
>   Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.3-rc1
> 
> for you to fetch changes up to c33d442328f556460b79aba6058adb37bb555389:
> 
>   debugfs: make error message a bit more verbose (2019-07-08 10:44:57 +0200)
> 
> ----------------------------------------------------------------
> Driver Core and debugfs changes for 5.3-rc1
> 
> Here is the "big" driver core and debugfs changes for 5.3-rc1
> 
> It's a lot of different patches, all across the tree due to some api
> changes and lots of debugfs cleanups.  Because of this, there is going
> to be some merge issues with your tree at the moment, I'll follow up
> with the expected resolutions to make it easier for you.
> 
> Other than the debugfs cleanups, in this set of changes we have:
> 	- bus iteration function cleanups (will cause build warnings
> 	  with s390 and coresight drivers in your tree)

Here's the s390 patch that was sent previously to resolve this issue.




--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="s390-fixup.patch"

From: Christian Borntraeger <borntraeger@de.ibm.com>

commit 92ce7e83b4e5 ("driver_find_device: Unify the match function with
class_find_device()") changed the prototype of driver_find_device to
use a const void pointer.

Change match_apqn accordingly.

Fixes: ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kernel")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 2c9fb1423a39..7e85ba7c6ef0 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -26,7 +26,7 @@
 
 static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
 
-static int match_apqn(struct device *dev, void *data)
+static int match_apqn(struct device *dev, const void *data)
 {
 	struct vfio_ap_queue *q = dev_get_drvdata(dev);
 
-- 
2.21.0


--SLDf9lqlvOQaIe6s--
