Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB5DC49EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 10:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfJBIsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 04:48:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:43540 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727158AbfJBIsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:48:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A765B155;
        Wed,  2 Oct 2019 08:48:36 +0000 (UTC)
Date:   Wed, 2 Oct 2019 10:48:44 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] eeprom: Warn that the driver is deprecated
Message-ID: <20191002104844.1dc4d8f3@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecating the driver in Kconfig is one thing, but we also need to
let the users themselves know. Log a warning each time a device is
bound to the deprecated eeprom driver.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/eeprom/eeprom.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-5.2.orig/drivers/misc/eeprom/eeprom.c	2019-07-08 00:41:56.000000000 +0200
+++ linux-5.2/drivers/misc/eeprom/eeprom.c	2019-10-02 10:46:23.363974060 +0200
@@ -175,6 +175,10 @@ static int eeprom_probe(struct i2c_clien
 		}
 	}
 
+	/* Let the users know they are using deprecated driver */
+	dev_notice(&client->dev,
+		   "eeprom driver is deprecated, please use at24 instead\n");
+
 	/* create the sysfs eeprom file */
 	return sysfs_create_bin_file(&client->dev.kobj, &eeprom_attr);
 }


-- 
Jean Delvare
SUSE L3 Support
