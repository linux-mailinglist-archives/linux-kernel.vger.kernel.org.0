Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034E4A5225
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbfIBIsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 04:48:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:46896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729328AbfIBIsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:48:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5FE18B114;
        Mon,  2 Sep 2019 08:48:30 +0000 (UTC)
Date:   Mon, 2 Sep 2019 10:48:38 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] eeprom: Deprecate the legacy eeprom driver
Message-ID: <20190902104838.058725c2@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Time has come to get rid of the old eeprom driver. The at24 driver
should be used instead. So mark the eeprom driver as deprecated and
give users some time to migrate. Then we can remove the legacy
eeprom driver completely.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/eeprom/Kconfig |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-5.2.orig/drivers/misc/eeprom/Kconfig	2019-08-23 18:40:44.140314063 +0200
+++ linux-5.2/drivers/misc/eeprom/Kconfig	2019-09-02 10:44:05.633190675 +0200
@@ -45,13 +45,16 @@ config EEPROM_AT25
 	  will be called at25.
 
 config EEPROM_LEGACY
-	tristate "Old I2C EEPROM reader"
+	tristate "Old I2C EEPROM reader (DEPRECATED)"
 	depends on I2C && SYSFS
 	help
 	  If you say yes here you get read-only access to the EEPROM data
 	  available on modern memory DIMMs and Sony Vaio laptops via I2C. Such
 	  EEPROMs could theoretically be available on other devices as well.
 
+	  This driver is deprecated and will be removed soon, please use the
+	  better at24 driver instead.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called eeprom.
 


-- 
Jean Delvare
SUSE L3 Support
