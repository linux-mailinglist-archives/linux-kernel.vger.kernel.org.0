Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 957D6169F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 08:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgBXHe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 02:34:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgBXHez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:34:55 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 559F62072D;
        Mon, 24 Feb 2020 07:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582529695;
        bh=I7YfRBGWxkRlMEz1dQKS6uyRwuKVhny5JTXAwxKMlCY=;
        h=From:To:Cc:Subject:Date:From;
        b=BAh6a8gST+T7CzfXEdyOAWr/+Yb3KcmhEa7GSiOG0d8vCIq1MmQIKipozzp2gA1t9
         bCUQVva4ipFlrTh+BpZH2TiMmm+oUOOis94t9kn+qPZUTXUMLsBYyuWGYQbWcJ6Mwd
         E6h13RRTfE+7E6gQJnitwcnoHbi8tS4xlCirtoV4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] vt: drop redundant might_sleep() in do_con_write()
Date:   Sun, 23 Feb 2020 23:34:50 -0800
Message-Id: <20200224073450.292892-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The might_sleep() in do_con_write() is redundant because console_lock()
already contains might_sleep().  Remove it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/tty/vt/vt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 0cfbb7182b5a5..a9fe30efa304b 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2576,8 +2576,6 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 	if (in_interrupt())
 		return count;
 
-	might_sleep();
-
 	console_lock();
 	vc = tty->driver_data;
 	if (vc == NULL) {
-- 
2.25.1

