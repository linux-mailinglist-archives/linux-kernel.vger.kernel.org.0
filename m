Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B00159D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 00:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBKXQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 18:16:39 -0500
Received: from gateway23.websitewelcome.com ([192.185.49.218]:36925 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727770AbgBKXQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:16:39 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id DEC3C2C53
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 17:16:37 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1elhjA1qsEfyq1elhjJydw; Tue, 11 Feb 2020 17:16:37 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t8jOCByl/+oOmdkjlnU8AU+JzuMxScO8sVhn8lDHLNM=; b=kMEQmdim4IZ8kPaIhgRSDTVaA6
        7Z2F+Avd7zbKC4yL0TZ3npV/MoXWRRVCDq/eS0+5a9efcZlrgJe58i/EfiOz7anLV/B3LYji/xHq6
        NNL95Ye5HcqeOcUYLf//v2B7DHDKbBP+t0Vz8qiUzokdR+c6qUX0mctglvuqS0+ofgvU6auA6n+Hm
        ZYTwjXe4ob47GBp95yCTJjfahMpPR4DxFqWYeLx2D8FsiVxq4qJ7G4+7x+IPIENEkcaBtUEozk0Xl
        o1DyUhhI9GPP79LfOHtv7lNAYpahPImdU3KLfn+G5Sv5MyWevJT8s0pv4DoflBK+RT4rabKEt+X+h
        JBxyCmwQ==;
Received: from [200.68.140.36] (port=4701 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1elg-003Xvz-Iy; Tue, 11 Feb 2020 17:16:36 -0600
Date:   Tue, 11 Feb 2020 17:19:11 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] thunderbolt: eeprom: Replace zero-length array with
 flexible-array member
Message-ID: <20200211231911.GA18208@embeddedor>
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
X-Exim-ID: 1j1elg-003Xvz-Iy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:4701
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 26
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
 drivers/thunderbolt/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 81e8ac4c5805..96e885e48f5e 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -208,7 +208,7 @@ struct tb_drom_entry_header {
 
 struct tb_drom_entry_generic {
 	struct tb_drom_entry_header header;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct tb_drom_entry_port {
-- 
2.25.0

