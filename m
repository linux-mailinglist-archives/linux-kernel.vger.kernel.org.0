Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADCCC159D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 00:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgBKXVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 18:21:50 -0500
Received: from gateway20.websitewelcome.com ([192.185.52.45]:37750 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727597AbgBKXVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:21:49 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id B8F95400C4360
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 16:08:14 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1eqijehugRP4z1eqij6WuM; Tue, 11 Feb 2020 17:21:48 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=n5ilMfy8gku9SOZFBLYy4Y+cibBJVLrMCr+czct/SY8=; b=jZxKKx/1yNPqJcOFhRKuRMVtcJ
        TwctO5+9TOnW4gtBqVfwD0eK6eqFqRBjn6YJ9ngyF5og8apmAx14brohfTu/ctzyPkDeXfbAyRA8f
        GqLLOxvvXwKU5tnskL48XmLBRHU2decBNOW0A6XDlheOKJcwKBR2+PGQ9MtsJiG6zcG5s/fzkTBJ4
        jjNo8rzqvocHIs2kk/gJOIWXlMbUlCr/OIqX8CPph9Fy01wZh6XI7pdgsNdL10nakY1hmNgWSylQS
        I65GCsQUtPHeE2RDHqCFsJ9M4E9r/w+munDkL7kSvZL8TVSYpk5ltuaGTCjJyisOB3/8e3qDRwkmb
        l6nYkwhg==;
Received: from [200.68.140.36] (port=9177 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1eqf-003aK6-F8; Tue, 11 Feb 2020 17:21:45 -0600
Date:   Tue, 11 Feb 2020 17:24:20 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] USB: serial: ti_usb_3410_5052: Replace zero-length array
 with flexible-array member
Message-ID: <20200211232420.GA22388@embeddedor>
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
X-Exim-ID: 1j1eqf-003aK6-F8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:9177
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 44
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
 drivers/usb/serial/ti_usb_3410_5052.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index dd0ad67aa71e..db3ab25d9228 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -219,7 +219,7 @@ struct ti_write_data_bytes {
 	u8	bDataCounter;
 	__be16	wBaseAddrHi;
 	__be16	wBaseAddrLo;
-	u8	bData[0];
+	u8	bData[];
 } __packed;
 
 struct ti_read_data_request {
@@ -234,7 +234,7 @@ struct ti_read_data_bytes {
 	__u8	bCmdCode;
 	__u8	bModuleId;
 	__u8	bErrorCode;
-	__u8	bData[0];
+	__u8	bData[];
 } __packed;
 
 /* Interrupt struct */
-- 
2.25.0

