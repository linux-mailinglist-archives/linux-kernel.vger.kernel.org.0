Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B32ED12FB11
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 18:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgACRCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 12:02:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:29430 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgACRCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:02:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 09:02:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,391,1571727600"; 
   d="scan'208";a="421487048"
Received: from pg-nx13.altera.com ([10.104.4.28])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2020 09:02:25 -0800
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Joyce Ooi <joyce.ooi@intel.com>,
        Loh Tien Hock <tien.hock.loh@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>, Ooi@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO maintainer
Date:   Sat,  4 Jan 2020 01:01:55 +0800
Message-Id: <20200103170155.100743-1-joyce.ooi@intel.com>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to replace Tien Hock Loh as Altera PIO maintainer as he
has moved to a different role.

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
 MAINTAINERS |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a049abc..3401c4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -726,7 +726,7 @@ S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c
 
 ALTERA PIO DRIVER
-M:	Tien Hock Loh <thloh@altera.com>
+M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-altera.c
-- 
1.7.1

