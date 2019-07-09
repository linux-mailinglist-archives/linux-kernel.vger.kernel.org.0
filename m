Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03C763134
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 08:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfGIGqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 02:46:51 -0400
Received: from first.geanix.com ([116.203.34.67]:46428 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfGIGqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:46:42 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id EDAA3A74D;
        Tue,  9 Jul 2019 06:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1562654712; bh=RvVOJWjkEeJ3YYiPO/wa5yPU5mMrmddO6c4eYyth5Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Xh+Psw96ef2VFo2+/cICYD4N15fQLebXyacd6CPPpIAZTZTTF7sunAr/hUS605cUa
         3hRBKhO9aRAwGWc9jizOkeEaXULPhvQIdt5//kAclH37OCsMzVeZ3YvfeZm4T3Sfw5
         4j6ulCCK/OG8HZvXeckMC3v236DlZrBARwByIajGsnUsgLH46byHxDg+aAgqYrV1Wr
         reJQDAvCPgM3RVyLUxSbgaN50IAzOpDVzc4/+i+ipqXdBS3UHJ2RGL+afhyFuo/oXf
         kBNcyWHftM5Ban5dQhDMAaqgKbDZCW1ODxmMcexXHRnrL76PTYcRwe3m8H/vFS7oHY
         uZZRAe50DnxDQ==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: [PATCHv2 3/4] tty: n_gsm: add helper to convert mux-num to/from tty-base
Date:   Tue,  9 Jul 2019 08:46:32 +0200
Message-Id: <20190709064633.45411-3-martin@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190709064633.45411-1-martin@geanix.com>
References: <20190709064633.45411-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it obvious how the gsm mux number relates to the virtual tty lines
by using helper function instead of shifting 6 bits.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 drivers/tty/n_gsm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c4e16b31f9ab..cba06063c44a 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2171,6 +2171,16 @@ static inline void mux_put(struct gsm_mux *gsm)
 	kref_put(&gsm->ref, gsm_free_muxr);
 }
 
+static inline int mux_num_to_base(struct gsm_mux *gsm)
+{
+	return gsm->num * NUM_DLCI;
+}
+
+static inline unsigned int mux_line_to_num(int line)
+{
+	return line / NUM_DLCI;
+}
+
 /**
  *	gsm_alloc_mux		-	allocate a mux
  *
@@ -2361,7 +2371,7 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 	else {
 		/* Don't register device 0 - this is the control channel and not
 		   a usable tty interface */
-		base = gsm->num << 6; /* Base for this MUX */
+		base = mux_num_to_base(gsm); /* Base for this MUX */
 		for (i = 1; i < NUM_DLCI; i++)
 			tty_register_device(gsm_tty_driver, base + i, NULL);
 	}
@@ -2380,7 +2390,7 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
 	int i;
-	int base = gsm->num << 6; /* Base for this MUX */
+	int base = mux_num_to_base(gsm); /* Base for this MUX */
 
 	WARN_ON(tty != gsm->tty);
 	for (i = 1; i < NUM_DLCI; i++)
@@ -2908,7 +2918,7 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 	struct gsm_mux *gsm;
 	struct gsm_dlci *dlci;
 	unsigned int line = tty->index;
-	unsigned int mux = line >> 6;
+	unsigned int mux = mux_line_to_num(line);
 	bool alloc = false;
 	int ret;
 
-- 
2.22.0

