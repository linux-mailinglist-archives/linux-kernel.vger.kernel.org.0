Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB384213
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 04:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfHGCGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 22:06:04 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:34123 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfHGCGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 22:06:04 -0400
Received: by mail-pl1-f201.google.com with SMTP id 71so49474016pld.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 19:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bdbKWZyjXxZ8gdygSGa9lktCzX8kxlzXL6a6uqaX3bg=;
        b=Kl5CEiJl/MaPfmQJRxpS2c1fPM5g/w735FsApDzzZzR56wnn0csvwjboJv9Jbjz6HU
         vULA/nOTL4J4BJHrQftcA5iZOBear0d0K+loneShngKG8oeNAQuDxzwMKm1WisYQt+bT
         TfB1p2/qViJhOuUXXbCYyBckBgngIgMdLbnJBHq6gDAG3/oAHyA7PT0r5upuG9zuUFT2
         Uh2jMJhH1OR0iTVbYZOqnGrUHeA4q+AEZq8T+tELAUzKJhpyHiw1EAs5RE6tv+80w1d5
         mhDvo5Gw65tAIC6BvkdzOdnOmeVyQTjv5vOEt/cktNZ2pwNHbN/kH1xN5qdmBgHTU780
         4bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bdbKWZyjXxZ8gdygSGa9lktCzX8kxlzXL6a6uqaX3bg=;
        b=abn9ikNQo+dM5bQN9KGkrAL2vB6TXyu0dGBY3RnuVOKRle5kjFHvPbgnL1aGb6A+qE
         EnDqkW2Q5Y7+jtvdiwdRl7mx6Tm4SZTiD/QpwSK2RWDTvynhUnTCS2UeQM+6yRPh0v77
         Z+Wj9JpGomZwMB/ULMfUv4derv0yCEc6wUWHIA+9nzFHi7gWUBh7e/iF/KurjnIDSpHs
         dkRKtn0af127yk8BlD2BntIVKO2lFCldAP6+Uq7lZxILopr+wnoWmQvEWFrRgjcuMbX6
         hG39T8uEvNF9LiWqZC3TdxuU22OJLCjuSp4adXdoYx1Eb40MvJOXnz6goNTpgcXGoThc
         Q+eg==
X-Gm-Message-State: APjAAAWl3ouyrjAJffedTTo6bsDiwE6DjPhpvLe1/COoroOq8mBVGK09
        oZrsGalIwXgDNBysbY2zWEus5oyQ2h6apRg=
X-Google-Smtp-Source: APXvYqxcuEsLSdZXABfbaGLaPekdX0qCbxv3NGBtyC6zvs/T/8g2c6CDTAef9YrNBjb4Nx8tt8f2dLmZFckRn/4=
X-Received: by 2002:a63:f07:: with SMTP id e7mr5914306pgl.238.1565143563303;
 Tue, 06 Aug 2019 19:06:03 -0700 (PDT)
Date:   Tue,  6 Aug 2019 19:05:58 -0700
Message-Id: <20190807020559.74458-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH] of/platform: Fix device_links_supplier_sync_state_resume() warning
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, Qian Cai <cai@lca.pw>,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In platforms/devices which have CONFIG_OF turned on but don't have a
populated DT, the calls to device_links_supplier_sync_state_pause() and
device_links_supplier_sync_state_resume() can get mismatched. This will
cause a warning during boot. Fix the warning by making sure the calls are
matched even in that case.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index a2a4e4b79d43..e5f7e40df439 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -723,7 +723,8 @@ arch_initcall_sync(of_platform_default_populate_init);
 
 static int __init of_platform_sync_state_init(void)
 {
-	device_links_supplier_sync_state_resume();
+	if (of_have_populated_dt())
+		device_links_supplier_sync_state_resume();
 	return 0;
 }
 late_initcall_sync(of_platform_sync_state_init);
-- 
2.23.0.rc1.153.gdeed80330f-goog

