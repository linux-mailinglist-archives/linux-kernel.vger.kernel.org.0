Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB401564AE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 15:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgBHOJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 09:09:16 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:44516 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgBHOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 09:09:15 -0500
Received: from localhost.localdomain ([93.22.133.23])
        by mwinf5d31 with ME
        id 0E99220030WSqZ103E99Z5; Sat, 08 Feb 2020 15:09:12 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Feb 2020 15:09:12 +0100
X-ME-IP: 93.22.133.23
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     oss@buserror.net, galak@kernel.crashing.org,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] powerpc/83xx: Fix some typo in some warning message
Date:   Sat,  8 Feb 2020 15:09:04 +0100
Message-Id: <20200208140904.7521-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"couldn;t" should be "couldn't".

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/platforms/83xx/km83xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index ada42f03915a..306be75faec7 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -53,13 +53,13 @@ static void quirk_mpc8360e_qe_enet10(void)
 
 	np_par = of_find_node_by_name(NULL, "par_io");
 	if (np_par == NULL) {
-		pr_warn("%s couldn;t find par_io node\n", __func__);
+		pr_warn("%s couldn't find par_io node\n", __func__);
 		return;
 	}
 	/* Map Parallel I/O ports registers */
 	ret = of_address_to_resource(np_par, 0, &res);
 	if (ret) {
-		pr_warn("%s couldn;t map par_io registers\n", __func__);
+		pr_warn("%s couldn't map par_io registers\n", __func__);
 		return;
 	}
 
-- 
2.20.1

