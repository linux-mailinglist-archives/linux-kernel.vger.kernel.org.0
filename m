Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB04159DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 01:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgBLAT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 19:19:59 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.202]:29769 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728117AbgBLAT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 19:19:58 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 76114432A50
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 17:44:36 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1fCmjf2P7RP4z1fCmj6rDE; Tue, 11 Feb 2020 17:44:36 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3amEQsF/pWaQW0ZdmjVL4Wgo7HC7zMjKomqEb1UwY9w=; b=dtwL3ccmEPdB2X2E0oE+oR5rtA
        /OvePgquBq2tCj3A90pJUt6j3VEX92sdFacASdnozUiIGwH63hkdUUdP0OdFp4EALqKwZIgJINcSP
        9vLzP4j0/GJ5xFmMRfQG9Bo7veT/wb45fW0NRAvmLb0AeAIArFB4nAlVYl3sebz//FICGNra2PYzz
        WCZb1AVMMdZAZoi4bpPrCL68Ry85T5YzQ7FD4G3QX5xuY05ghibdyNdM1jV3x5i6YuWrW4scavTep
        xfpFZ5Kh29Fv+GFx0kIMF+swh3eRVhKz2+DtxT2dfWp6Jel3z6I9zqRazEMQTwBaF7UA+nsCCKPeU
        s+yseETQ==;
Received: from [200.68.140.36] (port=7097 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1fCl-003kXF-2z; Tue, 11 Feb 2020 17:44:35 -0600
Date:   Tue, 11 Feb 2020 17:47:10 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] regulator: da9063: Replace zero-length array with
 flexible-array member
Message-ID: <20200211234710.GA29532@embeddedor>
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
X-Exim-ID: 1j1fCl-003kXF-2z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:7097
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 60
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
 drivers/regulator/da9063-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 2b0c7a85306a..368f8ad2a9f9 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -119,7 +119,7 @@ struct da9063_regulator {
 struct da9063_regulators {
 	unsigned				n_regulators;
 	/* Array size to be defined during init. Keep at end. */
-	struct da9063_regulator			regulator[0];
+	struct da9063_regulator			regulator[];
 };
 
 /* BUCK modes for DA9063 */
-- 
2.25.0

