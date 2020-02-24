Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE01169F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 08:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBXHeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 02:34:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:46658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgBXHeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:34:46 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12E0120637;
        Mon, 24 Feb 2020 07:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582529686;
        bh=NDSfGAZJkI2k4YRiySz/EZUqqWywWhOvsrbaf1qAO24=;
        h=From:To:Cc:Subject:Date:From;
        b=FAmLxyGoTTVz+50p3SKuwseMvxLgDnn3ypXIC5tRP5yPoKvLykQSgOfeKYK15HHXr
         WzyOxgh6JVf8cpEekCSCARyR/YfUrLV5q0kowovT5JQ07Qmpse3kw9dXj04XLTiZk8
         zwk4k6rw6MMxwxzFkAfjN3OeioDlDUJkoxT+Q2HY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: drop outdated comments about release_tty() locking
Date:   Sun, 23 Feb 2020 23:33:59 -0800
Message-Id: <20200224073359.292795-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The current version of the TTY code unlocks the tty_struct(s) before
release_tty() rather than after.  Moreover, tty_unlock_pair() no longer
exists.  Thus, remove the outdated comments regarding tty_unlock_pair().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/tty/tty_io.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index a1453fe108621..1fcf7ad83dfa0 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1589,9 +1589,7 @@ void tty_kclose(struct tty_struct *tty)
 	tty_debug_hangup(tty, "freeing structure\n");
 	/*
 	 * The release_tty function takes care of the details of clearing
-	 * the slots and preserving the termios structure. The tty_unlock_pair
-	 * should be safe as we keep a kref while the tty is locked (so the
-	 * unlock never unlocks a freed tty).
+	 * the slots and preserving the termios structure.
 	 */
 	mutex_lock(&tty_mutex);
 	tty_port_set_kopened(tty->port, 0);
@@ -1621,9 +1619,7 @@ void tty_release_struct(struct tty_struct *tty, int idx)
 	tty_debug_hangup(tty, "freeing structure\n");
 	/*
 	 * The release_tty function takes care of the details of clearing
-	 * the slots and preserving the termios structure. The tty_unlock_pair
-	 * should be safe as we keep a kref while the tty is locked (so the
-	 * unlock never unlocks a freed tty).
+	 * the slots and preserving the termios structure.
 	 */
 	mutex_lock(&tty_mutex);
 	release_tty(tty, idx);
-- 
2.25.1

