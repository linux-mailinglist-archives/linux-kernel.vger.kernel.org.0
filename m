Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF31C17BD33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 13:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgCFMtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 07:49:17 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:35708 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgCFMtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 07:49:15 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 151A68030792;
        Fri,  6 Mar 2020 12:49:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pjnVSfQ4wOVg; Fri,  6 Mar 2020 15:49:12 +0300 (MSK)
From:   <Sergey.Semin@baikalelectronics.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 18/22] tty: mips_ejtag_fdc: Mark expected switch fall-through
Date:   Fri, 6 Mar 2020 15:47:01 +0300
In-Reply-To: <20200306124705.6595-1-Sergey.Semin@baikalelectronics.ru>
References: <20200306124705.6595-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200306124913.151A68030792@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Mark mips_ejtag_fdc_encode() methods switch-case-4 as expecting to
fall through.

This patch fixes the following warning:

drivers/tty/mips_ejtag_fdc.c: In function ‘mips_ejtag_fdc_encode’:
drivers/tty/mips_ejtag_fdc.c:245:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
   word.word &= 0x00ffffff;
   ~~~~~~~~~~^~~~~~~~~~~~~
drivers/tty/mips_ejtag_fdc.c:246:2: note: here
  case 3:
  ^~~~

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/tty/mips_ejtag_fdc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 620d8488b83e..21e76a2ec182 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -243,6 +243,7 @@ static struct fdc_word mips_ejtag_fdc_encode(const char **ptrs,
 		/* Fall back to a 3 byte encoding */
 		word.bytes = 3;
 		word.word &= 0x00ffffff;
+		/* Fall through */
 	case 3:
 		/* 3 byte encoding */
 		word.word |= 0x82000000;
-- 
2.25.1

