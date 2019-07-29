Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0474179B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 23:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfG2VdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 17:33:12 -0400
Received: from gateway20.websitewelcome.com ([192.185.59.4]:12775 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728894AbfG2VdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:33:11 -0400
X-Greylist: delayed 1336 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 17:33:11 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 8DDC6400D1C60
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 15:07:26 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sCv1hhE6i4FKpsCv1hr2JK; Mon, 29 Jul 2019 16:10:55 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vyp07Q2BMZxkBU4I91lGXX/CgC/9r6rOUx013x0Y1/g=; b=dc0L4KP/HtmIe4hcEzHC+YuT1A
        cUbxGgV3pXJAvpHt4MZ9EvTS3AtAF3Fw9DoZ7DNyikCjesw7pthWqml/8BWGAOSKWnDBSDkAK205g
        6CU1I/oXWNav0CYtfi5RvFV2mJcLRK35CpwESSwraUhf46MFi6axNphdI1S0hu5SU5r/Inv5VLWGR
        t+fy+IGmvMZCeKdKqkOOpwQewQJPCh4D8j8uKSL0NZsrwfWfznDp+wW+YsAhcAmvxd4gwH9JsTWk/
        4BW2Ajk622cRYA3iKfocNTRmi6OMVfNis9/OIKya4DTF2ZbF/h5iPPuj9jt/OCh2MRaVGqsHQsI04
        I5DWICaA==;
Received: from [187.192.11.120] (port=60400 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsCv0-001Tpb-2B; Mon, 29 Jul 2019 16:10:54 -0500
Date:   Mon, 29 Jul 2019 16:10:53 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] ataflop: Mark expected switch fall-through
Message-ID: <20190729211053.GA6735@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsCv0-001Tpb-2B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:60400
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: m68k):

drivers/block/ataflop.c: In function ‘fd_locked_ioctl’:
drivers/block/ataflop.c:1728:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   set_capacity(floppy->disk, MAX_DISK_SIZE * 2);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/block/ataflop.c:1729:2: note: here
  case FDFMTEND:
  ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/ataflop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 85f20e371f2f..bd7d3bb8b890 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1726,6 +1726,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 		/* MSch: invalidate default_params */
 		default_params[drive].blocks  = 0;
 		set_capacity(floppy->disk, MAX_DISK_SIZE * 2);
+		/* Fall through */
 	case FDFMTEND:
 	case FDFLUSH:
 		/* invalidate the buffer track to force a reread */
-- 
2.22.0

