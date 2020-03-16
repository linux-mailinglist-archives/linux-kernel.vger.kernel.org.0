Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63918654D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 07:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgCPG7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 02:59:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbgCPG7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 02:59:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B45B1AD5C;
        Mon, 16 Mar 2020 06:59:12 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/3] vt: use min() to limit intervals
Date:   Mon, 16 Mar 2020 07:59:09 +0100
Message-Id: <20200316065911.11024-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of awkward ternary operator with comparison, use simple min()
for blankinterval and vesa_off_interval.

No functional change intended and "objdump -d" proves that.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c4d75edde923..e0d2cb93f6cf 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1927,7 +1927,7 @@ static void setterm_command(struct vc_data *vc)
 			update_attr(vc);
 			break;
 		case 9:	/* set blanking interval */
-			blankinterval = ((vc->vc_par[1] < 60) ? vc->vc_par[1] : 60) * 60;
+			blankinterval = min(vc->vc_par[1], 60U) * 60;
 			poke_blanked_console();
 			break;
 		case 10: /* set bell frequency in Hz */
@@ -1951,7 +1951,7 @@ static void setterm_command(struct vc_data *vc)
 			poke_blanked_console();
 			break;
 		case 14: /* set vesa powerdown interval */
-			vesa_off_interval = ((vc->vc_par[1] < 60) ? vc->vc_par[1] : 60) * 60 * HZ;
+			vesa_off_interval = min(vc->vc_par[1], 60U) * 60 * HZ;
 			break;
 		case 15: /* activate the previous console */
 			set_console(last_console);
-- 
2.25.1

