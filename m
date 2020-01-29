Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2F414D21C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 21:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgA2UvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 15:51:22 -0500
Received: from ned.t-8ch.de ([212.47.237.191]:44324 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgA2UvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 15:51:14 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1580330625;
        bh=NKUmMyQPNMW9j4FgzjMYHkAPpVi0GsN0og9K81e2G90=;
        h=From:To:Cc:Subject:Date:From;
        b=J2ASqw0ExW8TjRkwaPHTq1UXNlQHF04mTpvQe4Ac5u720QAxiyIM6i7LkPRjfebcb
         TOjyIVcMgBnZiNIIh6t6pX+HouH/1MmsMkvHA67f15jr7WFp9SvkRBk8z/Y1On1KAY
         Y06i0dLP+2ZPjMaI5NUPdSGTTDDKaipIh42bcLwo=
To:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] platform/x86: thinkpad_acpi: use standard charge control attribute names
Date:   Wed, 29 Jan 2020 21:43:35 +0100
Message-Id: <20200129204338.4055-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series switches over the battery control sysfs attributes to their
standard names as documented in Documentation/ABI/testing/sysfs-class-power.

If backwards compatability is not required please drop patch 3 of this series.
The old names were not documented explicitly and new generic software should
automatically use the new attributes, which may allow us to drop the old names.

Thomas Weißschuh (3):
  platform/x86: thinkpad_acpi: remove unused defines
  platform/x86: thinkpad_acpi: use standard charge control attribute
    names
  platform/x86: thinkpad_acpi: restore old battery charge attributes

 drivers/platform/x86/thinkpad_acpi.c | 29 +++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

-- 
2.25.0

