Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E1413AEFE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 17:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgANQPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 11:15:54 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49062 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbgANQPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:15:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AB6638EE24E;
        Tue, 14 Jan 2020 08:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579018553;
        bh=02Zx84XMsoxh7GzrzKK9m0tPh6L4+QOXtmWVHzMsKtw=;
        h=Subject:From:To:Cc:Date:From;
        b=kOTtIyG0qEwPYFG8te35hTmv5Fut53abcZsDMENe4IlPYLWaJx7MGQVtTZNGSrZ0B
         q6eHsGvRWfU3yf7ES9I/LRUSVpfB2WkgzMzqqS+PWDPSbVyeLuvB8rdiaA1L8TUdwQ
         SfvpSNyjQ6LjxhwHRUq1ICMAJbYyrsJyVxrWP5xo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tEzRh7KVHe4h; Tue, 14 Jan 2020 08:15:53 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E35808EE056;
        Tue, 14 Jan 2020 08:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579018553;
        bh=02Zx84XMsoxh7GzrzKK9m0tPh6L4+QOXtmWVHzMsKtw=;
        h=Subject:From:To:Cc:Date:From;
        b=kOTtIyG0qEwPYFG8te35hTmv5Fut53abcZsDMENe4IlPYLWaJx7MGQVtTZNGSrZ0B
         q6eHsGvRWfU3yf7ES9I/LRUSVpfB2WkgzMzqqS+PWDPSbVyeLuvB8rdiaA1L8TUdwQ
         SfvpSNyjQ6LjxhwHRUq1ICMAJbYyrsJyVxrWP5xo=
Message-ID: <1579018551.3390.13.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.5-rc6
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jan 2020 08:15:51 -0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two simple fixes in the upper drivers (so both fairly core), one in
enclosures, which fixes replugging a device into an enclosure slot and
one in the disk driver which fixes revalidating a drive with protection
information (PI) to make it a non-PI drive ... previously we were still
remembering the old PI state.  Both fixed issues are quite rare in the
field.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

James Bottomley (1):
      scsi: enclosure: Fix stale device oops with hot replug

Xiang Chen (1):
      scsi: sd: Clear sdkp->protection_type if disk is reformatted without PI

And the diffstat:

 drivers/misc/enclosure.c | 3 +--
 drivers/scsi/sd.c        | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

With full diff below.

James

---

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index 6d27ccfe0680..3c2d405bc79b 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -406,10 +406,9 @@ int enclosure_remove_device(struct enclosure_device *edev, struct device *dev)
 		cdev = &edev->component[i];
 		if (cdev->dev == dev) {
 			enclosure_remove_links(cdev);
-			device_del(&cdev->cdev);
 			put_device(dev);
 			cdev->dev = NULL;
-			return device_add(&cdev->cdev);
+			return 0;
 		}
 	}
 	return -ENODEV;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index cea625906440..65ce10c7989c 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2211,8 +2211,10 @@ static int sd_read_protection_type(struct scsi_disk *sdkp, unsigned char *buffer
 	u8 type;
 	int ret = 0;
 
-	if (scsi_device_protection(sdp) == 0 || (buffer[12] & 1) == 0)
+	if (scsi_device_protection(sdp) == 0 || (buffer[12] & 1) == 0) {
+		sdkp->protection_type = 0;
 		return ret;
+	}
 
 	type = ((buffer[12] >> 1) & 7) + 1; /* P_TYPE 0 = Type 1 */
 
