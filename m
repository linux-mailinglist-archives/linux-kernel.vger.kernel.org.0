Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 349AC103D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 15:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbfKTOg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 09:36:28 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:57112 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbfKTOgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:36:25 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id UEcN2100k5USYZQ01EcNZg; Wed, 20 Nov 2019 15:36:23 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXR5i-00020v-Lz; Wed, 20 Nov 2019 15:36:22 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXR5i-0000HZ-JM; Wed, 20 Nov 2019 15:36:22 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] driver core: Improve warning backtrace in device probing
Date:   Wed, 20 Nov 2019 15:36:17 +0100
Message-Id: <20191120143619.1027-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Greg, Rafael,

Once in a while, the WARN_ON() in really_probe() is triggered due to a
bug in a driver or subsystem.  While the backtrace provides some clues,
it does not reveal the offending device.

Hence this patch series adds a new dev_WARN_ON() helper, and uses that.

Thanks!

Geert Uytterhoeven (2):
  driver core: Add dev_WARN_ON() helper
  driver core: Print device in really_probe() warning backtrace

 drivers/base/dd.c      | 2 +-
 include/linux/device.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
