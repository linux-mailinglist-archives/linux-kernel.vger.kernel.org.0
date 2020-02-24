Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E0816A036
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 09:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgBXIjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 03:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbgBXIjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:39:22 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66A5B20661;
        Mon, 24 Feb 2020 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582533561;
        bh=i6Nzvo7MFgvQK+Kwv//m7fnUr/Yby9wrtOGUf97vUc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x88gTQHRYmutwqv2YL5+EuTyw2DJ3U+u2XEyOrOVBOWrPALGx7ZHfp1u9u5l37YqH
         GlLJrK6+HtQrfU7zMai7ZarA+By/bMbiEKjyW+VeZwsCjAqnKRMmrK+6sqoR07sGQW
         54lG5DnoQ+ER1hP4v+8rzWQTpxWQgRSXQHRAx+4U=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] tty: fix compat TIOCGSERIAL leaking uninitialized memory
Date:   Mon, 24 Feb 2020 00:38:38 -0800
Message-Id: <20200224083838.306381-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <000000000000387920059f4e0351@google.com>
References: <000000000000387920059f4e0351@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Commit 77654350306a ("take compat TIOC[SG]SERIAL treatment into
tty_compat_ioctl()") changed the compat version of TIOCGSERIAL to start
copying a whole struct to userspace rather than individual fields, but
failed to initialize all padding and fields -- namely the hole after the
'iomem_reg_shift' field, and the 'reserved' field.

Fix this by initializing the struct to zero.

Reported-by: syzbot+8da9175e28eadcb203ce@syzkaller.appspotmail.com
Fixes: 77654350306a ("take compat TIOC[SG]SERIAL treatment into tty_compat_ioctl()")
Cc: <stable@vger.kernel.org> # v4.20+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/tty/tty_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1fcf7ad83dfa0..d24c250312edf 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2731,6 +2731,7 @@ static int compat_tty_tiocgserial(struct tty_struct *tty,
 	struct serial_struct v;
 	int err;
 	memset(&v, 0, sizeof(struct serial_struct));
+	memset(&v32, 0, sizeof(struct serial_struct32));
 
 	if (!tty->ops->set_serial)
 		return -ENOTTY;
-- 
2.25.1

