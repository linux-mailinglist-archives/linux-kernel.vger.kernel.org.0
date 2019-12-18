Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79D125511
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 22:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfLRVpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 16:45:12 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44318 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRVpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:45:09 -0500
Received: by mail-qt1-f194.google.com with SMTP id t3so3179073qtr.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYhWk9A+WoXMXCHtGdQqG3zbhIals/Q0OXKZBLbp2XQ=;
        b=QWH3gSE6q8WtD1SmfrJQgiQ7LLjbeSzdGGxuU6D1LQFTRCg6sX+Tuq8LxJGMBus2zD
         s8SA/4pV/zDqSsz/AUpGJVxuSnhkKfRRoGZKKUIM/cD8oVIJpwc/hp9bUM7cgRpc1b2x
         e3CYX5n0lS+xZ9Dm2m4kfZqHGhhXHor+qk32ugSazoN4CohZ8Ghwd10B8UBseXW6eplk
         naKSnzNYpg66adMFRK03cm4O6hhn5PkVp4FCqeJQgnOrN/2gsTPFpriEvsntX2+OqusD
         uEzS4YtLoCVMdx+dvSZChAXg/LFlMZO2V3h53TAyLPr4nDyaD8ZeWSyWJZxQO5HeH76l
         ioTw==
X-Gm-Message-State: APjAAAXRI1GDnUcbNCyLCKuMfZhASzgTJJcfbC8Td7cB/iIVZEt+mEl9
        pxO4EHtHhUSv1QEBLQYVzD574yhz
X-Google-Smtp-Source: APXvYqyVlYOkfe3fso4XvPMuzSRSJge3EXhFmppUh1VucUuWzZe6xpfWThM2GjDMiqm/v641Vjf9ow==
X-Received: by 2002:aed:30e2:: with SMTP id 89mr4284513qtf.355.1576705508414;
        Wed, 18 Dec 2019 13:45:08 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u4sm1059851qkh.59.2019.12.18.13.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:45:08 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/24] console/dummycon: Remove bogus depends on from DUMMY_CONSOLE
Date:   Wed, 18 Dec 2019 16:44:43 -0500
Message-Id: <20191218214506.49252-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218214506.49252-1-nivedita@alum.mit.edu>
References: <20191218211231.GA918900@kroah.com>
 <20191218214506.49252-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit [1] consolidated console configuration in
drivers/video/console, DUMMY_CONSOLE has always been enabled, since the
dependency is always satisfied.

There is no point in trying to allow it to be configured out, since
(a) it's tiny, and (b) if VT_CONSOLE is enabled, we must have a working
console driver by the time con_init(vt.c) runs, and only dummycon is
guaranteed to work (vgacon may be configured in, but that doesn't mean
we have a VGA device).

So just remove the fake dependency.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit?id=31d2a7d36d6989c714b792ec00358ada24c039e7

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/video/console/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index c10e17fb9a9a..70c10ea1c38b 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -93,7 +93,6 @@ config SGI_NEWPORT_CONSOLE
 
 config DUMMY_CONSOLE
 	bool
-	depends on VGA_CONSOLE!=y || SGI_NEWPORT_CONSOLE!=y 
 	default y
 
 config DUMMY_CONSOLE_COLUMNS
-- 
2.24.1

