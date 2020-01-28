Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFDFE14BEEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 18:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgA1Rup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 12:50:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51111 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1Rup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:50:45 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B8D3AF71F;
        Tue, 28 Jan 2020 12:50:43 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=Q+/
        6TsAi07c3WjpX7xvEfYiz/p0=; b=f+NYoWYrsNIzBLhr2MWYMAxkJ1qbDaozCJD
        QmrUBOzYkBfTaAgaITbdmApZ6g76+pALRKuaHazXuIpVWbAw23PIuMRYBasFySdg
        yeLWxtdoAjg4LueTDVj98VEjJF7izQEI2icP+w4srmTnFD9cLpw2rCLs/0RAiDD7
        95aeZVUI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 436F2AF71E;
        Tue, 28 Jan 2020 12:50:43 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2016-12.pbsmtp; bh=QSzYoKchC8bAVwKEjJbgLQFSIOW5hbn3tY7WNGl53+0=;
 b=HeAZfQyauHikkz/pJy1a6oiqIOAmugWNSQNj04kpw13XJZw3nxkhBmxj8r1MQ5zlhBu+TA8ZLeE30MmbwG8KCTMW/cY2Ov5AZD9VbKE6i4MTmpY83eMCg+2gmVVlioIT1lKZNQksTQ2lEtGYfc3BswhtZLrL/O6vfKiNK7dc5iI=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3B531AF71D;
        Tue, 28 Jan 2020 12:50:40 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 5DADC2DA00E3;
        Tue, 28 Jan 2020 12:50:38 -0500 (EST)
Date:   Tue, 28 Jan 2020 12:50:33 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] vt: fix scrollback flushing on background consoles
Message-ID: <nycvar.YSQ.7.76.2001281205560.1655@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: B29C772E-41F6-11EA-9629-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a6dbe4427559 ("vt: perform safe console erase in the right 
order") provided fixes to an earlier commit by gathering all console
scrollback flushing operations in a function of its own. This includes
the invocation of vc_sw->con_switch() as previously done through a
update_screen() call. That commit failed to carry over the 
con_is_visible() conditional though, as well as cursor handling, which 
caused problems when "\e[3J" was written to a background console.

One could argue for preserving the call to update_screen(). However
this does far more than we need, and it is best to remove scrollback 
assumptions from it. Instead let's gather the minimum needed to actually
perform scrollback flushing properly in that one place.

While at it, let's document the vc_sw->con_switch() side effect being
relied upon.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
Reported-and-tested-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 34aa39d1ae..3b4ccc2a30 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -936,10 +936,21 @@ static void flush_scrollback(struct vc_data *vc)
 	WARN_CONSOLE_UNLOCKED();
 
 	set_origin(vc);
-	if (vc->vc_sw->con_flush_scrollback)
+	if (vc->vc_sw->con_flush_scrollback) {
 		vc->vc_sw->con_flush_scrollback(vc);
-	else
+	} else if (con_is_visible(vc)) {
+		/*
+		 * When no con_flush_scrollback method is provided then the
+		 * legacy way for flushing the scrollback buffer is to use
+		 * a side effect of the con_switch method. We do it only on
+		 * the foreground console as background consoles have no
+		 * scrollback buffers in that case and we obviously don't
+		 * want to switch to them.
+		 */
+		hide_cursor(vc);
 		vc->vc_sw->con_switch(vc);
+		set_cursor(vc);
+	}
 }
 
 /*
