Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6EC18649
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 09:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfEIHlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 03:41:21 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:14607 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725961AbfEIHlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 03:41:20 -0400
X-IronPort-AV: E=Sophos;i="5.60,449,1549900800"; 
   d="scan'208";a="62230554"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 May 2019 15:40:56 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 473E44CDBCD7;
        Thu,  9 May 2019 15:40:56 +0800 (CST)
Received: from iridescent.g08.fujitsu.local (10.167.225.140) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 9 May 2019 15:40:58 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
Subject: [PATCH v2] Documentation: nvdimm: Fix typo
Date:   Thu, 9 May 2019 15:40:49 +0800
Message-ID: <20190509074049.12192-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190509023744.4936-1-ruansy.fnst@cn.fujitsu.com>
References: <20190509023744.4936-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: 473E44CDBCD7.A7B27
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the extra 'we '.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 Documentation/nvdimm/nvdimm.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/nvdimm/nvdimm.txt b/Documentation/nvdimm/nvdimm.txt
index e894de69915a..1669f626b037 100644
--- a/Documentation/nvdimm/nvdimm.txt
+++ b/Documentation/nvdimm/nvdimm.txt
@@ -284,8 +284,8 @@ A bus has a 1:1 relationship with an NFIT.  The current expectation for
 ACPI based systems is that there is only ever one platform-global NFIT.
 That said, it is trivial to register multiple NFITs, the specification
 does not preclude it.  The infrastructure supports multiple busses and
-we we use this capability to test multiple NFIT configurations in the
-unit test.
+we use this capability to test multiple NFIT configurations in the unit
+test.
 
 LIBNVDIMM: control class device in /sys/class
 
-- 
2.17.0



