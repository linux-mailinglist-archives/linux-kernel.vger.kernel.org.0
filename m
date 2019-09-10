Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFAFAE361
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 07:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393203AbfIJF73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 01:59:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfIJF72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 01:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fIGfMlrxJV5LsPD/0GOyEkA6JJ43g2NcxaloY4HpG0M=; b=Pms1SD+dyyIaw6SRkOF4c6iO4
        lcMmT2URpL21DKmeVp6SfzrfceFPYvotTK/2UWo7RXWv89qtZDTgIMhvdF34xf1WIEZAgnRwcPRJw
        USkGPbRn3gJns6zoyz5NgYHUgJoNiy1PHjEDs/WDlXaKQI0sMvfc/LkGPndJV/H76pBOtlR2clFb/
        g49DsmWumNLCDUBsf943t7H9dourO/VKW09emXKV7o690l9PKRgyry2oOUr8rb+KvTCV5BQFtnNdp
        9YCjEphyWjA2VMHowPV+UI3jeAQZludF+ZSTUkzsYOzwsYzwpGak0zuuOOuoEO7LV/wlPyXCrwPrN
        D8nSf690g==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7ZBV-0001Vn-4L; Tue, 10 Sep 2019 05:59:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     paul.walmsley@sifive.com, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date:   Tue, 10 Sep 2019 07:59:23 +0200
Message-Id: <20190910055923.28384-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sifive serial driver implements earlycon support, but unless
another driver is built in that supports earlycon support it won't
be usable.  Explicitly select SERIAL_EARLYCON instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 530cb966092f..6b77a72278e3 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1075,6 +1075,7 @@ config SERIAL_SIFIVE_CONSOLE
 	bool "Console on SiFive UART"
 	depends on SERIAL_SIFIVE=y
 	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
 	help
 	  Select this option if you would like to use a SiFive UART as the
 	  system console.
-- 
2.20.1

