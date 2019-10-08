Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED24CF286
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 08:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfJHGNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 02:13:43 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:38443 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729876AbfJHGNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:13:43 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x985uS4f075344;
        Tue, 8 Oct 2019 13:56:28 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 8 Oct 2019
 14:12:20 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     <alankao@andestech.com>, <paul.walmsley@sifive.com>,
        <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <aryabinin@virtuozzo.com>, <glider@google.com>,
        <dvyukov@google.com>, <corbet@lwn.net>, <alexios.zavras@intel.com>,
        <allison@lohutok.net>, <Anup.Patel@wdc.com>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>, <atish.patra@wdc.com>,
        <kstewart@linuxfoundation.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>
CC:     Nick Hu <nickhu@andestech.com>
Subject: [PATCH v3 3/3] kasan: Add riscv to KASAN documentation.
Date:   Tue, 8 Oct 2019 14:11:53 +0800
Message-ID: <8f3c66f3f24450b21b749a5e6e6eabf066632ac9.1570514545.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1570514544.git.nickhu@andestech.com>
References: <cover.1570514544.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x985uS4f075344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add riscv to the KASAN documentation to mention that riscv
is supporting generic kasan now.

Signed-off-by: Nick Hu <nickhu@andestech.com>
---
 Documentation/dev-tools/kasan.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index b72d07d70239..34fbb7212cbc 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -21,8 +21,8 @@ global variables yet.
 
 Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
 
-Currently generic KASAN is supported for the x86_64, arm64, xtensa and s390
-architectures, and tag-based KASAN is supported only for arm64.
+Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 and
+riscv architectures, and tag-based KASAN is supported only for arm64.
 
 Usage
 -----
-- 
2.17.0

