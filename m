Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4034CC1F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 19:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbfJDRou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 13:44:50 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:40340 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDRou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:44:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 9EEA027E168B;
        Fri,  4 Oct 2019 19:44:48 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2bC4j2hYHyUN; Fri,  4 Oct 2019 19:44:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 408ED27E1685;
        Fri,  4 Oct 2019 19:44:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 408ED27E1685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1570211088;
        bh=lNJg/LV7yB630AqjOoxpn34nOdtDsm/AxVz9zmDuLU4=;
        h=From:To:Date:Message-Id;
        b=j6MuNcPaqOU1llFHRnYhX1E9/lJGgWhz1jYW0pv0wEC/Oi2dlIox6VR2SRUaGy5fY
         nQLAao3PsCTEuEPlrd7uBvMgtezjOOs4OaiMmut4ajE2GMMkxl3Vc3qZbMjQZTMKV/
         hQjKBogu1XRdIK8iZWtIBw76WM1jcg/ZARTBLnVE=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gsKztxltXw-l; Fri,  4 Oct 2019 19:44:48 +0200 (CEST)
Received: from triton.lin.mbt.kalray.eu (unknown [192.168.37.25])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 2976227E0415;
        Fri,  4 Oct 2019 19:44:48 +0200 (CEST)
From:   Clement Leger <cleger@kalray.eu>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <cleger@kalray.eu>
Subject: [PATCH] remoteproc: remove useless typedef
Date:   Fri,  4 Oct 2019 19:44:24 +0200
Message-Id: <20191004174424.21898-1-cleger@kalray.eu>
X-Mailer: git-send-email 2.15.0.276.g89ea799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rproc_handle_resources_t is not used anymore, remove it.

Signed-off-by: Clement Leger <cleger@kalray.eu>
---
 drivers/remoteproc/remoteproc_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 48feebd6d0a2..78e00194e72f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -52,8 +52,6 @@
 static DEFINE_MUTEX(rproc_list_mutex);
 static LIST_HEAD(rproc_list);
 
-typedef int (*rproc_handle_resources_t)(struct rproc *rproc,
-				struct resource_table *table, int len);
 typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
 				 void *, int offset, int avail);
 
-- 
2.15.0.276.g89ea799

