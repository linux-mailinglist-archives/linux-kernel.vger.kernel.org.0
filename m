Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE1526AADE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbfGPOt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 10:49:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbfGPOt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 10:49:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 947A4335C9;
        Tue, 16 Jul 2019 14:49:26 +0000 (UTC)
Received: from laptop.jcline.org (ovpn-125-22.rdu2.redhat.com [10.10.125.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72F0A1001DC2;
        Tue, 16 Jul 2019 14:49:26 +0000 (UTC)
Received: from laptop.jcline.org.com (localhost [IPv6:::1])
        by laptop.jcline.org (Postfix) with ESMTP id 96759704C8E5;
        Tue, 16 Jul 2019 10:49:25 -0400 (EDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH] docs/vm: transhuge: fix typo in madvise reference
Date:   Tue, 16 Jul 2019 10:49:08 -0400
Message-Id: <20190716144908.25843-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 16 Jul 2019 14:49:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an off-by-one typo in the transparent huge pages admin
documentation.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 7ab93a8404b9..bd5714547cee 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -53,7 +53,7 @@ disabled, there is ``khugepaged`` daemon that scans memory and
 collapses sequences of basic pages into huge pages.
 
 The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
-interface and using madivse(2) and prctl(2) system calls.
+interface and using madvise(2) and prctl(2) system calls.
 
 Transparent Hugepage Support maximizes the usefulness of free memory
 if compared to the reservation approach of hugetlbfs by allowing all
-- 
2.21.0

