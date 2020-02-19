Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2973D163FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 09:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgBSItz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 03:49:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:49770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgBSIty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:49:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B4D30ACF2;
        Wed, 19 Feb 2020 08:49:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/10] n_gsm: switch throttled to bool
Date:   Wed, 19 Feb 2020 09:49:47 +0100
Message-Id: <20200219084949.28074-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084949.28074-1-jslaby@suse.cz>
References: <20200219084949.28074-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gsm_dlci->throttled is used as a bool, so treat it as such.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 24ce46e4fb45..6bd51d309c32 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -142,7 +142,7 @@ struct gsm_dlci {
 	u32 modem_tx;		/* Our outgoing modem lines */
 	bool dead;		/* Refuse re-open */
 	/* Flow control */
-	int throttled;		/* Private copy of throttle state */
+	bool throttled;		/* Private copy of throttle state */
 	int constipated;	/* Throttle status for outgoing */
 	/* Packetised I/O */
 	struct sk_buff *skb;	/* Frame being sent */
@@ -3172,7 +3172,7 @@ static void gsmtty_throttle(struct tty_struct *tty)
 		return;
 	if (C_CRTSCTS(tty))
 		dlci->modem_tx &= ~TIOCM_DTR;
-	dlci->throttled = 1;
+	dlci->throttled = true;
 	/* Send an MSC with DTR cleared */
 	gsmtty_modem_update(dlci, 0);
 }
@@ -3184,7 +3184,7 @@ static void gsmtty_unthrottle(struct tty_struct *tty)
 		return;
 	if (C_CRTSCTS(tty))
 		dlci->modem_tx |= TIOCM_DTR;
-	dlci->throttled = 0;
+	dlci->throttled = false;
 	/* Send an MSC with DTR set */
 	gsmtty_modem_update(dlci, 0);
 }
-- 
2.25.0

