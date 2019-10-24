Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F75E36CF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 17:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503329AbfJXPiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 11:38:02 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:38806 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503151AbfJXPiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:38:02 -0400
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id HTdz2100b5USYZQ01Te0tX; Thu, 24 Oct 2019 17:38:00 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNfBX-0007CB-T1; Thu, 24 Oct 2019 17:37:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNfBX-0008Id-QU; Thu, 24 Oct 2019 17:37:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] MAINTAINERS: Mark linux-i3c mailing list moderated
Date:   Thu, 24 Oct 2019 17:37:56 +0200
Message-Id: <20191024153756.31861-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-i3c mailing list is moderated for non-subscribers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f361fba6c4070ae..937017266a2edf08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7746,7 +7746,7 @@ F:	drivers/i2c/i2c-stub.c
 
 I3C SUBSYSTEM
 M:	Boris Brezillon <bbrezillon@kernel.org>
-L:	linux-i3c@lists.infradead.org
+L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
 C:	irc://chat.freenode.net/linux-i3c
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git
 S:	Maintained
-- 
2.17.1

