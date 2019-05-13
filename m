Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F7E1BB96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 19:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbfEMROb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 13:14:31 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:54000 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730043AbfEMROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:14:31 -0400
Received: (qmail 5524 invoked by uid 2102); 13 May 2019 13:14:29 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 May 2019 13:14:29 -0400
Date:   Mon, 13 May 2019 13:14:29 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg KH <greg@kroah.com>
cc:     andreyknvl@google.com, <gustavo@embeddedor.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, <suwan.kim027@gmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] USB: Fix slab-out-of-bounds write in usb_get_bos_descriptor
In-Reply-To: <00000000000061c7cd0588c6933c@google.com>
Message-ID: <Pine.LNX.4.44L0.1905131313100.1478-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syzkaller USB fuzzer found a slab-out-of-bounds write bug in the
USB core, caused by a failure to check the actual size of a BOS
descriptor.  This patch adds a check to make sure the descriptor is at
least as large as it is supposed to be, so that the code doesn't
inadvertently access memory beyond the end of the allocated region
when assigning to dev->bos->desc->bNumDeviceCaps later on.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: syzbot+71f1e64501a309fcc012@syzkaller.appspotmail.com
CC: <stable@vger.kernel.org>

---


[as1898]


 drivers/usb/core/config.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: usb-devel/drivers/usb/core/config.c
===================================================================
--- usb-devel.orig/drivers/usb/core/config.c
+++ usb-devel/drivers/usb/core/config.c
@@ -932,8 +932,8 @@ int usb_get_bos_descriptor(struct usb_de
 
 	/* Get BOS descriptor */
 	ret = usb_get_descriptor(dev, USB_DT_BOS, 0, bos, USB_DT_BOS_SIZE);
-	if (ret < USB_DT_BOS_SIZE) {
-		dev_err(ddev, "unable to get BOS descriptor\n");
+	if (ret < USB_DT_BOS_SIZE || bos->bLength < USB_DT_BOS_SIZE) {
+		dev_err(ddev, "unable to get BOS descriptor or descriptor too short\n");
 		if (ret >= 0)
 			ret = -ENOMSG;
 		kfree(bos);

