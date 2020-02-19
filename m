Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4704163D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 08:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgBSG77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 01:59:59 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51887 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgBSG77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 01:59:59 -0500
X-Originating-IP: 79.86.19.127
Received: from debian.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B888D20005;
        Wed, 19 Feb 2020 06:59:55 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] documentation: vm: Advertise support for pte_special in riscv
Date:   Wed, 19 Feb 2020 01:59:53 -0500
Message-Id: <20200219065953.27350-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Risc-V architecture has actually supported pte_special since its merge
upstream, simply add this info to the documentation.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 Documentation/features/vm/pte_special/arch-support.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index 2dc5df6a1cf5..3d492a34c8ee 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -23,7 +23,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-- 
2.20.1

