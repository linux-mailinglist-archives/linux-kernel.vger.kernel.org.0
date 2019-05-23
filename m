Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D479D27404
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 03:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfEWBdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 21:33:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38035 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfEWBdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:33:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id l3so4875111qtj.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 18:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AamLO/X/2HFW4+8OQqzF4OMXoHcsEVisRKCkgWHRdBI=;
        b=NY+76YSaThUkioGyKoXDynhJQ1jm7W5HmM96xMkzvko8Ocl1qBMOe0YYwBf5JtducB
         81/zREAC2Wf3cRbMvq+36hvHbQyRj4mWmFaxngal9YqA2PtCm+gusF6PHedzcYcDXXp2
         nxkb5VKHMp56NOcCa4ZPPa8ziaHOkeUG93h9aSu+AodgvuHC6M3ugshxjvFSRmyzKd4r
         1v1O9leuI3gcSvxrbyzFV2yBAtX6Gwt6vx/j6LvrxMJCdOtxZLWN73qN8d77Q1zeNUlQ
         CgwYG9S8Z8reLts4pmk7cEicmE7H7UYM0H1cazPbptv6bYkzMxcsc4mQxXoWAhZS97HQ
         sR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AamLO/X/2HFW4+8OQqzF4OMXoHcsEVisRKCkgWHRdBI=;
        b=Sls3ejNiuxyp2JLNpsgTq83qRcE9uxDGOK3wmu3vAEHTg910d3CCet8y7Yh98IreJO
         UU9Nu2A+htsTACjGtJxr8tANkpO7fF0yICqUmzo6SUY+SQXN5sRGWRraBcZQhTFpMAzW
         VFLpbmnSLCEAWV8j9C7lNB6G5lDOZtxFbS+YDjmAYE8wojswHwJITPUvpIxcQ8pAgRB5
         HXwwfDnVyaS9pvwFkmywvI8RsfoEogSSaS//4wzqU1S9gz9mWUDUrprk1HDX+nwmfFQo
         wsw3CUQdcX9TgFaQXUIDhrJ1Zh0CUDv6OjbSXNucyvmrEtZEZ/9m2m/CcZHrUTDbzXY0
         Kfsw==
X-Gm-Message-State: APjAAAWRzqCQPk6+K3BH5YiruuL1Nm5WckH9f8QWwe1UItQWeMS7Qfmo
        sHwuJKO6yXmg3EhHtha9Xq2zCAPLFLI=
X-Google-Smtp-Source: APXvYqx5MfUdVLYzIj0g4Pnb3ek/AOecqzC1HqvGl7gFPc6FwlwF35cD3VyHW9X27tAxbfSTWll7xA==
X-Received: by 2002:ac8:309d:: with SMTP id v29mr77648603qta.195.1558575211371;
        Wed, 22 May 2019 18:33:31 -0700 (PDT)
Received: from ovpn-121-0.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r129sm12798151qkb.9.2019.05.22.18.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 May 2019 18:33:30 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     jroedel@suse.de, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] iommu/intel: fix variable 'iommu' set but not used
Date:   Wed, 22 May 2019 21:33:14 -0400
Message-Id: <20190523013314.2732-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit cf04eee8bf0e ("iommu/vt-d: Include ACPI devices in iommu=pt")
added for_each_active_iommu() in iommu_prepare_static_identity_mapping()
but never used the each element, i.e, "drhd->iommu".

drivers/iommu/intel-iommu.c: In function
'iommu_prepare_static_identity_mapping':
drivers/iommu/intel-iommu.c:3037:22: warning: variable 'iommu' set but
not used [-Wunused-but-set-variable]
 struct intel_iommu *iommu;

Fixed the warning by appending a compiler attribute __maybe_unused for it.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a209199f3af6..09b8ff0d856a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3034,7 +3034,8 @@ static int __init iommu_prepare_static_identity_mapping(int hw)
 {
 	struct pci_dev *pdev = NULL;
 	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
+	/* To avoid a -Wunused-but-set-variable warning. */
+	struct intel_iommu *iommu __maybe_unused;
 	struct device *dev;
 	int i;
 	int ret = 0;
-- 
2.20.1 (Apple Git-117)

