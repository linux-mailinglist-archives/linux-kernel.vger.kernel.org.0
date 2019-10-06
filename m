Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD664CCE6A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 06:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfJFEps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 00:45:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3249 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbfJFEps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 00:45:48 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 21C9011A9C1C129B634B;
        Sun,  6 Oct 2019 12:45:45 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Sun, 6 Oct 2019
 12:45:35 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <Julia.Lawall@lip6.fr>, <Gilles.Muller@lip6.fr>,
        <nicolas.palix@imag.fr>, <michal.lkml@markovi.net>,
        <maennich@google.com>, <yuehaibing@huawei.com>, <jeyu@kernel.org>,
        <gregkh@linuxfoundation.org>, <yamada.masahiro@socionext.com>,
        <Markus.Elfring@web.de>
CC:     <cocci@systeme.lip6.fr>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] scripts: add_namespace: Fix coccicheck failed
Date:   Sun, 6 Oct 2019 12:44:56 +0800
Message-ID: <20191006044456.57608-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now all scripts in scripts/coccinelle to be automatically called
by coccicheck. However new adding add_namespace.cocci does not
support report mode, which make coccicheck failed.
This add "virtual report" to  make the coccicheck go ahead smoothly.

Fixes: eb8305aecb95 ("scripts: Coccinelle script for namespace dependencies.")
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 scripts/coccinelle/misc/add_namespace.cocci | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
index c832bb6445a8..99e93a6c2e24 100644
--- a/scripts/coccinelle/misc/add_namespace.cocci
+++ b/scripts/coccinelle/misc/add_namespace.cocci
@@ -6,6 +6,8 @@
 /// add a missing namespace tag to a module source file.
 ///
 
+virtual report
+
 @has_ns_import@
 declarer name MODULE_IMPORT_NS;
 identifier virtual.ns;
-- 
2.20.1


