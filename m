Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E86E0880
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbfJVQQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:16:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56775 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388205AbfJVQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:16:35 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iMwpm-0000p1-I6; Tue, 22 Oct 2019 18:16:34 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>, kernel@pengutronix.de
Subject: [PATCH v2] MAINTAINERS: add reset controller framework keywords
Date:   Tue, 22 Oct 2019 18:16:33 +0200
Message-Id: <20191022161633.30302-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a regex that matches users of the reset controller API.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 296de2b51c83..5d77a376a45c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13851,6 +13851,7 @@ F:	include/dt-bindings/reset/
 F:	include/linux/reset.h
 F:	include/linux/reset/
 F:	include/linux/reset-controller.h
+K:      \b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b
 
 RESTARTABLE SEQUENCES SUPPORT
 M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
-- 
2.20.1

