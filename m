Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925BD5BF02
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 17:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfGAPGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 11:06:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:38742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727568AbfGAPGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:06:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95587AFFC;
        Mon,  1 Jul 2019 15:06:40 +0000 (UTC)
Date:   Mon, 1 Jul 2019 17:06:38 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Sickler <Matt.Sickler@daktronics.com>,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: kpc2000: drop useless softdep statement
Message-ID: <20190701170638.68bd414d@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-dev module is for access to I2C buses from user-space.
Kernel drivers do not care about its presence.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Matt Sickler <Matt.Sickler@daktronics.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/kpc2000/kpc_i2c/i2c_driver.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-5.2-rc7.orig/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c	2019-06-30 05:25:36.000000000 +0200
+++ linux-5.2-rc7/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c	2019-07-01 11:33:17.336697545 +0200
@@ -26,7 +26,6 @@
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Matt.Sickler@Daktronics.com");
-MODULE_SOFTDEP("pre: i2c-dev");
 
 struct i2c_device {
     unsigned long           smba;


-- 
Jean Delvare
SUSE L3 Support
