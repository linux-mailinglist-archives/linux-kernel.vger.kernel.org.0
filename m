Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47079159D16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 00:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgBKXTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 18:19:18 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.196]:11412 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727905AbgBKXTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:19:18 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 3F60F1332478
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 17:19:15 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1eoFjYgA38vkB1eoFjWpZ7; Tue, 11 Feb 2020 17:19:15 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3ukPiRuumhyjQE2a3H1TwfC2YcfYXQVvQ3fpynTB+oY=; b=zhCYtFoMtUJqzr7Me6tN01lX5t
        v5qecBOHt3Ar+8zQLmqaPAGSNVU5RY9XTgKOsckb9Jd48kpw7XZjgi5A0TDsNRMqze4IdDUHDkh0R
        k5NyvGVCK25spCDFLqUOgtdLAbaEkFmbUtocAq7p3TUKoN2jMZ5RwehThuzYwKIcycrYhCAOjiVE2
        RTD2njB1zPS+odqA7+Ag1Wu9mhYMFfBjM9WZhi09JGjs0dB2aP/7RLGxoHX1qf5QIIiLUYETzdyrx
        w7DVPbU4zHgrJIJV/nZUvDpBFN4mgaTBh3QqkjFcutaQy9iwpoL4z27rXor55yY/eSVixqXJRRhec
        Wf1J92Ig==;
Received: from [200.68.140.36] (port=13213 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1eoD-003Z4z-Ra; Tue, 11 Feb 2020 17:19:13 -0600
Date:   Tue, 11 Feb 2020 17:21:48 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Matthieu CASTET <castet.matthieu@free.fr>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] USB: atm: Replace zero-length array with flexible-array
 member
Message-ID: <20200211232148.GA20644@embeddedor>
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
X-Exim-ID: 1j1eoD-003Z4z-Ra
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:13213
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 36
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
 drivers/usb/atm/ueagle-atm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index 2754b4ce7136..25cf94131987 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -394,7 +394,7 @@ struct l1_code {
 	u8 string_header[E4_L1_STRING_HEADER];
 	u8 page_number_to_block_index[E4_MAX_PAGE_NUMBER];
 	struct block_index page_header[E4_NO_SWAPPAGE_HEADERS];
-	u8 code[0];
+	u8 code[];
 } __packed;
 
 /* structures describing a block within a DSP page */
-- 
2.25.0

