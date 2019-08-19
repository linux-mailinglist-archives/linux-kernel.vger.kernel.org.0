Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACCE191DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 09:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfHSHRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 03:17:15 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:56187 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHSHRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:17:12 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x7J7GBU2031989;
        Mon, 19 Aug 2019 16:16:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x7J7GBU2031989
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566198972;
        bh=5ohnxPHZ/8JpLqASFbRTalb4WfhP8eVHfNmv1OoKdd0=;
        h=From:To:Cc:Subject:Date:From;
        b=tNkd32tV+iKfY6y8FNMZsp3wtLHsG/jHFMRurCVZ9pf1V/+1+jxir43PweAj0HCA2
         t+ycshZXU2zAmQgFqOyTCX3Pb73EF1pXjFanf6QJTCTjPpSMsmx/ly1+VaH9wNld/i
         KRBpZCVpYucwBy1pz9QTlMlCSEBaBu/Lmo/1F8wlOy7qPp+Z2S3NPFqA55yeqBlMHl
         aWN7CwSlwCvqRyLRXsgVsIr6XEO3sjIUrX7YRFzSTdSHt8GMezo2IN2xgs6LR6gOP6
         FhHl2qvo19w0grb12sn9xr+zrkyppr+xYS49Yqo/59jrL7zlN1sdWvrUHWwlF8MOJu
         DDY9nMdK5Ldeg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] driver-core: add include guard to linux/container.h
Date:   Mon, 19 Aug 2019 16:16:06 +0900
Message-Id: <20190819071606.10965-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/container.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/container.h b/include/linux/container.h
index 0cc2ee91905c..2566a1baa736 100644
--- a/include/linux/container.h
+++ b/include/linux/container.h
@@ -6,6 +6,9 @@
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
 
+#ifndef _LINUX_CONTAINER_H
+#define _LINUX_CONTAINER_H
+
 #include <linux/device.h>
 
 /* drivers/base/power/container.c */
@@ -20,3 +23,5 @@ static inline struct container_dev *to_container_dev(struct device *dev)
 {
 	return container_of(dev, struct container_dev, dev);
 }
+
+#endif /* _LINUX_CONTAINER_H */
-- 
2.17.1

