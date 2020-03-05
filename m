Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7717B25C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 00:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCEXpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 18:45:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCEXpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 18:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Uk/NnFaedsIKaqmkbXLKmTyfgDQfxXne9D3bjNy3D+E=; b=DTuk1cbf1vv9XCLI/5QCLm8Ul3
        /8ZYfLTvFfZQolGUsIY2hMtVYDrasGErdfLzyHTyQY38PEV/J1udmWuKGxnsaL/72WLRyVI1Zj4Ds
        iByEDkQpaccyht2YJ6bHb3ZLmVkMOY+Zc8mr6CS3ZZ12sXunNAqjaEb64fQ5gkhpugq1ukWgRX3vT
        JgbJSHh5VDrK/prAFW6hsRWB7zLRZfsTmEYuE/j5n1xKPisi6TzFqluAlCq4ai3gPQ+xCT/nuj6Xm
        MEHHelGlTGBoBX3vodJGlHo6EvN9RyrKNpT9xQtsp97PqGOlrrULvDxEAx1QP+uOX0zFzSbvIYSXR
        g2ZQZTYA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jA0Ba-0003cx-Qb; Thu, 05 Mar 2020 23:45:50 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 2/2] tty: source all tty/*/Kconfig files from tty/Kconfig
Message-ID: <a1118619-5b10-91e0-2914-fba4172f1eaa@infradead.org>
Date:   Thu, 5 Mar 2020 15:45:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

'source' (include) all of the tty/*/Kconfig files from
drivers/tty/Kconfig instead of from drivers/char/Kconfig.
This consolidates them both in source code and in menu
presentation to the user.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Follows [PATCH] char: group some /dev configs together and un-split tty configs
as [PATCH 2/2], where [PATCH (1/2)] is here:
https://lore.kernel.org/lkml/4e90d9af-c1ec-020f-b66b-a5a02e7fbe59@infradead.org/


 drivers/char/Kconfig |    5 -----
 drivers/tty/Kconfig  |    6 ++++++
 2 files changed, 6 insertions(+), 5 deletions(-)

--- linux-next-20200304.orig/drivers/char/Kconfig
+++ linux-next-20200304/drivers/char/Kconfig
@@ -7,9 +7,6 @@ menu "Character devices"
 
 source "drivers/tty/Kconfig"
 
-source "drivers/tty/serial/Kconfig"
-source "drivers/tty/serdev/Kconfig"
-
 config TTY_PRINTK
 	tristate "TTY driver to output user messages via printk"
 	depends on EXPERT && TTY
@@ -94,8 +91,6 @@ config PPDEV
 
 	  If unsure, say N.
 
-source "drivers/tty/hvc/Kconfig"
-
 config VIRTIO_CONSOLE
 	tristate "Virtio console"
 	depends on VIRTIO && TTY
--- linux-next-20200304.orig/drivers/tty/Kconfig
+++ linux-next-20200304/drivers/tty/Kconfig
@@ -478,3 +478,9 @@ config LDISC_AUTOLOAD
 	  only set the default value of this functionality.
 
 endif # TTY
+
+source "drivers/tty/serial/Kconfig"
+
+source "drivers/tty/serdev/Kconfig"
+
+source "drivers/tty/hvc/Kconfig"

