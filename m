Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D03E0135008
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 00:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgAHXhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 18:37:32 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:57007 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgAHXhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 18:37:32 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DB21823D09;
        Thu,  9 Jan 2020 00:37:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578526649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yIKQUIBF+OZc7Hts35piuQ5vFTf1r8jv67Ut0VYsjMk=;
        b=DoQqlLALqK8p9E6ZVtLw0Ypcw3fzijH0EdqArOMoV4sGrZeFOON1xKSmGXfnFlMtb7vwwE
        gGJz1j7scBhqHdGGt+CDEvS9vUGZwpQZkwkd+hB9LrmhfoW8XQonYPYdmdZiWKXCoR1xIZ
        3nX9Qlcyu5CG26KL55It4/WUBsHZjVg=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rahul Bedarkar <rahul.bedarkar@imgtec.com>,
        Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 0/2] mtd: spi-nor: OTP support
Date:   Thu,  9 Jan 2020 00:36:52 +0100
Message-Id: <20200108233654.29027-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Spam-Level: ****
X-Rspamd-Server: web
X-Spam-Status: No, score=4.90
X-Spam-Score: 4.90
X-Rspamd-Queue-Id: DB21823D09
X-Spamd-Result: default: False [4.90 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.698];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         FREEMAIL_CC(0.00)[microchip.com,bootlin.com,nod.at,ti.com,gmail.com,imgtec.com,walle.cc]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements the mtd otp functions to allow access to the SPI
OTP data. Specific support is added for the Winbond flash chips.

In the past there was already an attempt by Rahul Bedarkar to add this, but
there was no response. These two patches are slightly based on his work.

https://lore.kernel.org/linux-mtd/1489754636-21461-1-git-send-email-rahul.bedarkar@imgtec.com/

This series is based on top of the following patches. They are not strictly
needed, but the patches might not apply cleanly and - more importantly -
OTP support for the new W25QnnJW flashes, which are added by one of the
patches, is already added.

https://lore.kernel.org/linux-mtd/20200107222317.3527-1-michael@walle.cc/
https://lore.kernel.org/linux-mtd/20200107222317.3527-2-michael@walle.cc/
https://lore.kernel.org/linux-mtd/20200103223423.14025-1-michael@walle.cc/

To dump an OTP area which doesn't start at zero (like for the Winbond
flashes) the following patch must be applied to mtd-utils:

https://lore.kernel.org/linux-mtd/20200108232359.27372-1-michael@walle.cc/

Michael Walle (2):
  mtd: spi-nor: add OTP support
  mtd: spi-nor: implement OTP support for Winbond flashes

 drivers/mtd/spi-nor/spi-nor.c | 279 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |  52 +++++++
 2 files changed, 331 insertions(+)

-- 
2.20.1

