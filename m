Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5801382C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 09:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfHFHPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 03:15:07 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:58589 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731557AbfHFHPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:15:06 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x767EoCh021608;
        Tue, 6 Aug 2019 16:14:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x767EoCh021608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565075691;
        bh=+KO0GXqHBx/JdwcSNmb/i/NoE7oTZbbCDFWzqqlfVso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQv0vU9dgq8hLlTeg/S8JB4XdNM+x1Rbx4Y6Re16hbUseBADjkCWinXvLzW0noZiJ
         1MPRdnt2ghXiJvkNOeY+uMHhb0+Xol1HTMM62Vhcn1dP3vYDe45GvM1UhNjpzVY0l/
         zLPAP3bA+J02RgdWBOaIlfW5OPFVM6EXJbpiREPAb7BzJM/Ic4jOpn28yL+ZigSaQ6
         KPYcvZQZEl8l2h3zGGs+mpfwzR+m5km0QQ6UAgqvRkcNrz3RZ4w4pDHTtVAOWLRLBA
         wGEBtEDPxT1TSyIGGQ9FY9S7S38C3vCWLfR7cwHoIeJXBPxqlnnoj8oSKKweuNv4MA
         8sQYuE6tgPf5g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] auxdisplay: charlcd: add include guard to charlcd.h
Date:   Tue,  6 Aug 2019 16:14:45 +0900
Message-Id: <20190806071445.13705-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806071445.13705-1-yamada.masahiro@socionext.com>
References: <20190806071445.13705-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/auxdisplay/charlcd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 8cf6c18b0adb..00911ad0f3de 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -6,6 +6,9 @@
  * Copyright (C) 2016-2017 Glider bvba
  */
 
+#ifndef _CHARLCD_H
+#define _CHARLCD_H
+
 struct charlcd {
 	const struct charlcd_ops *ops;
 	const unsigned char *char_conv;	/* Optional */
@@ -37,3 +40,5 @@ int charlcd_register(struct charlcd *lcd);
 int charlcd_unregister(struct charlcd *lcd);
 
 void charlcd_poke(struct charlcd *lcd);
+
+#endif /* CHARLCD_H */
-- 
2.17.1

