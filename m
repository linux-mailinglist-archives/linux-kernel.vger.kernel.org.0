Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 750E2159B03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 22:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbgBKVOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 16:14:50 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.129]:45160 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730074AbgBKVOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:14:50 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id F17A05AAD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 15:14:48 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1croj7keFEfyq1crojHinV; Tue, 11 Feb 2020 15:14:48 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UxXLm2e5tI+unjVCZMlCPtSbwk/EQxrDUm9dV5vSwYM=; b=BfvKwi6nIvn6jAS8xL4I+BfQ6A
        Kt6HICeS/cN87mOJIZoWN8ukUE5bGFgZSZBBI6+OQYoQjyzK2ACiXNfK1uUR274QfOJmW2wIjMXID
        sp7gWOqOXPw2kC6komMHMfPjSxa6ml6jF/fMDHGJ0OhveAEoKOa9IRwsAS7HTipkkxi/F0k1xQpmF
        xS6WZsU9yBunn/lSUyrU9jYM6DzNixC4UFQCJjhqHxhnEeiswnHOWEJMV+TvRA9c/6fgLWu7KEP5c
        VNZ3P5NIWBwsvnbObFajjtKjS/pTR/G5PbXibcqOGAfpoi0ohorhBDnIR9DMuhJbX3DqY5UEZ1WkN
        dOuzA3mg==;
Received: from [200.68.140.36] (port=21551 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1crn-002Eb7-GS; Tue, 11 Feb 2020 15:14:47 -0600
Date:   Tue, 11 Feb 2020 15:17:22 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     sparmaintainer@unisys.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] staging: unisys: visorinput: Replace zero-length array with
 flexible-array member
Message-ID: <20200211211722.GA1640@embeddedor>
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
X-Source-IP: 200.68.140.36
X-Source-L: No
X-Exim-ID: 1j1crn-002Eb7-GS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:21551
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 33
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertenly introduced[3] to the codebase from now on.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/staging/unisys/visorinput/visorinput.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/unisys/visorinput/visorinput.c b/drivers/staging/unisys/visorinput/visorinput.c
index 9693fb559052..6d202cba8575 100644
--- a/drivers/staging/unisys/visorinput/visorinput.c
+++ b/drivers/staging/unisys/visorinput/visorinput.c
@@ -111,7 +111,7 @@ struct visorinput_devdata {
 	/* size of following array */
 	unsigned int keycode_table_bytes;
 	/* for keyboard devices: visorkbd_keycode[] + visorkbd_ext_keycode[] */
-	unsigned char keycode_table[0];
+	unsigned char keycode_table[];
 };
 
 static const guid_t visor_keyboard_channel_guid = VISOR_KEYBOARD_CHANNEL_GUID;
-- 
2.25.0

