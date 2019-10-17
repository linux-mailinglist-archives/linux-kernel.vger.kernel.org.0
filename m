Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36CD7DAB66
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502112AbfJQLov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 07:44:51 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53999 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502103AbfJQLov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:44:51 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iL4D2-0003qt-SM; Thu, 17 Oct 2019 12:44:48 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iL4D2-0005Kg-Ej; Thu, 17 Oct 2019 12:44:48 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: include <pcmcia/ds.h> for pcmcia_parse_tuple
Date:   Thu, 17 Oct 2019 12:44:47 +0100
Message-Id: <20191017114447.20455-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <pcmcia/ds.h> for pcmcia_parse_tuple declaration
to fix the following sparse warning:

drivers/pcmcia/cistpl.c:1287:5: warning: symbol 'pcmcia_parse_tuple' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
.. (open list)
---
 drivers/pcmcia/cistpl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index 629359fe3513..cf109d9a1112 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -28,6 +28,7 @@
 #include <pcmcia/ss.h>
 #include <pcmcia/cisreg.h>
 #include <pcmcia/cistpl.h>
+#include <pcmcia/ds.h>
 #include "cs_internal.h"
 
 static const u_char mantissa[] = {
-- 
2.23.0

