Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A16D596AC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfF1JBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 05:01:23 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:40954 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfF1JBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:01:23 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: from pc-niv.weinmann.com (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id B9C964B8A3;
        Fri, 28 Jun 2019 11:01:20 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, nv@vosn.de
Subject: [PATCH 1/2] drivers/usb/typec/tps6598x.c: fix portinfo width
Date:   Fri, 28 Jun 2019 11:01:08 +0200
Message-Id: <f8daf204d49fff00db33e2b417a20afcc58ad56e.1561712364.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628083417.GA21701@kuha.fi.intel.com>
References: <20190628083417.GA21701@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Portinfo bit field is 3 bits wide, not 2 bits. This led to
a wrong driver configuration for some tps6598x configurations.

Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/usb/typec/tps6598x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
index c674abe3cf99..a170c49c2542 100644
--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -41,7 +41,7 @@
 #define TPS_STATUS_VCONN(s)		(!!((s) & BIT(7)))
 
 /* TPS_REG_SYSTEM_CONF bits */
-#define TPS_SYSCONF_PORTINFO(c)		((c) & 3)
+#define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
 
 enum {
 	TPS_PORTINFO_SINK,
-- 
2.17.1

