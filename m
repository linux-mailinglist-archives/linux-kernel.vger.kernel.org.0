Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2545DC30DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfJAKE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 06:04:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5935 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725765AbfJAKE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:04:57 -0400
X-UUID: 5e04e5acbef54d609690fa8a3f4104b2-20191001
X-UUID: 5e04e5acbef54d609690fa8a3f4104b2-20191001
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1278566965; Tue, 01 Oct 2019 18:04:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Oct 2019 18:04:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Oct 2019 18:04:48 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] docs: printk-formats: add ptrdiff_t type to printk-formats
Date:   Tue, 1 Oct 2019 18:04:49 +0800
Message-ID: <20191001100449.19481-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When print the difference between two pointers, we should use
the ptrdiff_t modifier %t.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 Documentation/core-api/printk-formats.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index ecbebf4ca8e7..8a0f49cd158b 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -135,6 +135,20 @@ equivalent to %lx (or %lu). %px is preferred because it is more uniquely
 grep'able. If in the future we need to modify the way the kernel handles
 printing pointers we will be better equipped to find the call sites.
 
+Pointer Differences
+-------------------
+
+::
+
+	%td	2560
+	%tx	a00
+
+For printing the pointer differences, use the %t modifier for ptrdiff_t.
+
+Example::
+
+	printk("test: difference between pointers: %td\n", ptr2 - ptr1);
+
 Struct Resources
 ----------------
 
-- 
2.18.0

