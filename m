Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA89163F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 09:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgBSIlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 03:41:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:44300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgBSIl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E9A3BAED8;
        Wed, 19 Feb 2020 08:41:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 24/24] n_hdlc: wrap a comment properly
Date:   Wed, 19 Feb 2020 09:41:18 +0100
Message-Id: <20200219084118.26491-24-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index b74a8ecc65b5..cd1319d26c45 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -385,8 +385,10 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 	/* get a free HDLC buffer */
 	buf = n_hdlc_buf_get(&n_hdlc->rx_free_buf_list);
 	if (!buf) {
-		/* no buffers in free list, attempt to allocate another rx buffer */
-		/* unless the maximum count has been reached */
+		/*
+		 * no buffers in free list, attempt to allocate another rx
+		 * buffer unless the maximum count has been reached
+		 */
 		if (n_hdlc->rx_buf_list.count < MAX_RX_BUF_COUNT)
 			buf = kmalloc(struct_size(buf, buf, maxframe),
 				      GFP_ATOMIC);
-- 
2.25.0

