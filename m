Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4426163F80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 09:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBSIm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 03:42:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:44302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgBSIlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E4C47B031;
        Wed, 19 Feb 2020 08:41:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/24] n_hdlc: remove unused flags
Date:   Wed, 19 Feb 2020 09:41:03 +0100
Message-Id: <20200219084118.26491-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are only set to 0 and never read.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index e40561caa450..d0e538ba51ea 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -124,7 +124,6 @@ struct n_hdlc_buf_list {
 /**
  * struct n_hdlc - per device instance data structure
  * @magic - magic value for structure
- * @flags - miscellaneous control flags
  * @tty - ptr to TTY structure
  * @backup_tty - TTY to use if tty gets closed
  * @tbusy - reentrancy flag for tx wakeup code
@@ -136,7 +135,6 @@ struct n_hdlc_buf_list {
  */
 struct n_hdlc {
 	int			magic;
-	__u32			flags;
 	struct tty_struct	*tty;
 	struct tty_struct	*backup_tty;
 	int			tbusy;
@@ -808,8 +806,7 @@ static struct n_hdlc *n_hdlc_alloc(void)
 	
 	/* Initialize the control block */
 	n_hdlc->magic  = HDLC_MAGIC;
-	n_hdlc->flags  = 0;
-	
+
 	return n_hdlc;
 	
 }	/* end of n_hdlc_alloc() */
-- 
2.25.0

