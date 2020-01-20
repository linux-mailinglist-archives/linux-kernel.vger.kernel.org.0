Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8FB1434B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 01:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAUAOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 19:14:02 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.113]:26512 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727009AbgAUAOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 19:14:00 -0500
X-Greylist: delayed 1231 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jan 2020 19:14:00 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 7277C141ADEF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 17:53:28 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tgrIiZbYB9jb7tgrIigbNb; Mon, 20 Jan 2020 17:53:28 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xxAzhTqbOqe1BRFg2/D6CHH4pUnAKV9fRR68rERoFdo=; b=cdURJ4B2sUTFx/0XYpxi8YfVRe
        ZluDtH1/J/eWhM4ZhDHvMayLsFgRrnBpF37tElMKjlhiQrMOBiVi2RJuy5LJmCgE6XlVZ2WuM3/8j
        6cv2Ru7V6SCeZoJqvGgXnR1ZiGoR2Jq47TiCkZnHys2Hdu9rI0B0nte+GQuCxcHal1ec9O4A+jw70
        smaPrztSNaecMnmYzyHWMqDzBSv3Ua7ztO45zm5FmaWaOhvME8xLNAJZhRxk/v8d9XS+SSSWn9iRX
        n8jMvpVJjCaQ7yy/td1V3yeCDupgun+USnAgjDw0nS+YvtU+8NFMaa03OXcN0cF7Crg3AAlhH+dov
        VnKCp1AQ==;
Received: from 187-162-252-62.static.axtel.net ([187.162.252.62]:44974 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1itgrH-003oDh-72; Mon, 20 Jan 2020 17:53:27 -0600
Date:   Mon, 20 Jan 2020 17:53:26 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] char: hpet: Use flexible-array member
Message-ID: <20200120235326.GA29231@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.252.62
X-Source-L: No
X-Exim-ID: 1itgrH-003oDh-72
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-252-62.static.axtel.net (embeddedor) [187.162.252.62]:44974
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Old code in the kernel uses 1-byte and 0-byte arrays to indicate the
presence of a "variable length array":

struct something {
    int length;
    u8 data[1];
};

struct something *instance;

instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
instance->length = size;
memcpy(instance->data, source, size);

There is also 0-byte arrays. Both cases pose confusion for things like
sizeof(), CONFIG_FORTIFY_SOURCE, etc.[1] Instead, the preferred mechanism
to declare variable-length types such as the one above is a flexible array
member[2] which need to be the last member of a structure and empty-sized:

struct something {
        int stuff;
        u8 data[];
};

Also, by making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
unadvertenly introduced[3] to the codebase from now on.

[1] https://github.com/KSPP/linux/issues/21
[2] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/char/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 9ac6671bb514..aed2c45f7968 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -110,7 +110,7 @@ struct hpets {
 	unsigned long hp_delta;
 	unsigned int hp_ntimer;
 	unsigned int hp_which;
-	struct hpet_dev hp_dev[1];
+	struct hpet_dev hp_dev[];
 };
 
 static struct hpets *hpets;
-- 
2.23.0

