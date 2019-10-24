Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD76E3932
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 19:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410084AbfJXRFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 13:05:11 -0400
Received: from dougal.metanate.com ([90.155.101.14]:18348 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405819AbfJXRFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mQaqDJfBUJCKU7f6avq0mzD47+ygTkCFs3EjoJcaN+4=; b=FlWPxduvtt9U8hlkrCWU30aFS2
        Xb0YnEt4mEuav2Od5AyttpkUw55dCU6CFJm3Zgs+bGhLBRBx0BzMiq6dJ0OVs7IoJysSYCZvY5+HG
        Z6v5Okdi599VEl+TJL/YcHdr8Q4rUEBSv8fG8wSz6mVC6FAa0CzxrkI7UzLckZyuuE0Isx8AEpuwq
        h6uow3vlflYQ/kj4s/QZmIui8/ijUo/GxSq3j/gDHZe/5OikLxob/4Ks40QvHAdG/YjJ3giTIvxp4
        3UYe45ageLPt04rWFuGxoxJPRK9i5xXptUWkUNUFHSq2cO+fMrQYNg5Km+Q4sws2utg2CHenNtcZ2
        zYcfCHDA==;
Received: from 188-39-28-98.static.enta.net ([188.39.28.98] helo=donbot.corp.numark.com)
        by email.metanate.com with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <john@metanate.com>)
        id 1iNgF9-0004oc-LY; Thu, 24 Oct 2019 17:45:47 +0100
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH 2/6] USB: gadget: f_hid: switch to IDR for tracking minors
Date:   Thu, 24 Oct 2019 17:45:34 +0100
Message-Id: <20191024164538.3161474-3-john@metanate.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024164538.3161474-1-john@metanate.com>
References: <20191024164538.3161474-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following commits, we are going to move the cdev allocation up to
the module initialisation, and will look up the associated f_hidg
structure from the open operation.

Start preparing for this by switching from IDA to IDR.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/gadget/function/f_hid.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index e9e45f9eae80..838256086bd2 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -24,8 +24,8 @@
 
 static int major, minors;
 static struct class *hidg_class;
-static DEFINE_IDA(hidg_ida);
-static DEFINE_MUTEX(hidg_ida_lock); /* protects access to hidg_ida */
+static DEFINE_IDR(hidg_idr);
+static DEFINE_MUTEX(hidg_idr_lock); /* protects access to hidg_idr */
 
 /*-------------------------------------------------------------------------*/
 /*                            HID gadget struct                            */
@@ -851,9 +851,9 @@ static inline int hidg_get_minor(void)
 {
 	int ret;
 
-	ret = ida_simple_get(&hidg_ida, 0, 0, GFP_KERNEL);
+	ret = idr_alloc(&hidg_idr, NULL, 0, 0, GFP_KERNEL);
 	if (ret >= HIDG_MINORS) {
-		ida_simple_remove(&hidg_ida, ret);
+		idr_remove(&hidg_idr, ret);
 		ret = -ENODEV;
 	}
 
@@ -996,7 +996,7 @@ static const struct config_item_type hid_func_type = {
 
 static inline void hidg_put_minor(int minor)
 {
-	ida_simple_remove(&hidg_ida, minor);
+	idr_remove(&hidg_idr, minor);
 }
 
 static void hidg_free_inst(struct usb_function_instance *f)
@@ -1005,9 +1005,9 @@ static void hidg_free_inst(struct usb_function_instance *f)
 
 	opts = container_of(f, struct f_hid_opts, func_inst);
 
-	mutex_lock(&hidg_ida_lock);
+	mutex_lock(&hidg_idr_lock);
 	hidg_put_minor(opts->minor);
-	mutex_unlock(&hidg_ida_lock);
+	mutex_unlock(&hidg_idr_lock);
 
 	if (opts->report_desc_alloc)
 		kfree(opts->report_desc);
@@ -1027,7 +1027,7 @@ static struct usb_function_instance *hidg_alloc_inst(void)
 	opts->func_inst.free_func_inst = hidg_free_inst;
 	ret = &opts->func_inst;
 
-	mutex_lock(&hidg_ida_lock);
+	mutex_lock(&hidg_idr_lock);
 
 	opts->minor = hidg_get_minor();
 	if (opts->minor < 0) {
@@ -1038,7 +1038,7 @@ static struct usb_function_instance *hidg_alloc_inst(void)
 	config_group_init_type_name(&opts->func_inst.group, "", &hid_func_type);
 
 unlock:
-	mutex_unlock(&hidg_ida_lock);
+	mutex_unlock(&hidg_idr_lock);
 	return ret;
 }
 
-- 
2.23.0

