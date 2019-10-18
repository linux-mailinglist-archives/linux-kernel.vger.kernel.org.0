Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6567BDD509
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 00:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395080AbfJRWml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 18:42:41 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44116 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfJRWmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:42:40 -0400
Received: by mail-yb1-f193.google.com with SMTP id v1so2300682ybo.11;
        Fri, 18 Oct 2019 15:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WvT6llug8K7grtGTEVP8teBbNB9xwEIQgTbnaQCarqA=;
        b=NTI6bv/Phk+bn8UhCzQDEe8765VKffHg6fSlaLZ9tOdvyvi8kxdKlKifkp2iNuAQWg
         f8p7zHL4OtfLIsgLu43eGXPeueYzKzWMOvgmTCqNFbdxBu8cmEtg059hsuoTx5nQKcbb
         PXJg/YRtQPNDcl2VCq5Y/U3kpgKiWWC59tgPOZrGYFLq9v1dkzikBPO4aq7tXM2KAN52
         z5n5pK2Mm0PExWMUHiLkQYHuK0cHyjjGKyv1t53uFVKZDUP+uHgZ5CuoNM4B2uQjMFeD
         O3gYXehL2GjSVA6D9zU2E/fN4CVwB1MF9DcQ1BjXGJlEcW3TbppomFlRALPWxc9g9mEq
         Y6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WvT6llug8K7grtGTEVP8teBbNB9xwEIQgTbnaQCarqA=;
        b=BzgO+XfZKcJnCCuM5rghFZNpihTarywv8Ce49yeC8sBu8/uc33vLh6960SY3Lo4Hbx
         PTO4DWs+mhNr6UtwnSXVnRcrnYLFETw1WFtMi2RVDoDVAHrHIpDDIXDvUWBjH3FElBdw
         ZLTln34IZ3HCe7D447NIAbcXiEZjY61Z3GuUDa3GgZ/JULC9x/o9Z/B5SwVrj6nI+/zf
         oPKA5Z09oYtgyyooe6FwtX9Xg+Spoqi3GCHXxq0Z0bGqX3qIHmZlldtlw/ys2m7gpod9
         rNzGmyLGMJV2ei1IGYzxBw6G+/15VIfAYk3w5Zx6aiaA0fUZo+iz+TgFAOnjnjXUb4sQ
         TPPQ==
X-Gm-Message-State: APjAAAXvwCo9+1/247JMQvgyI9TzGrUvIrCESzQYuM6ZOt1pYEtVbiw7
        k1bdZymmAhIsS0dsPtBIig==
X-Google-Smtp-Source: APXvYqyGiQ5zs3604TFg/MCSHC7inrtSY7DzlvMyqOrSpFF4P4OJqc4ntmgqGz1UIBCzpQKl1dPNEg==
X-Received: by 2002:a05:6902:510:: with SMTP id x16mr7341660ybs.324.1571438559250;
        Fri, 18 Oct 2019 15:42:39 -0700 (PDT)
Received: from 960.localdomain ([64.192.53.12])
        by smtp.gmail.com with ESMTPSA id d188sm1645412ywa.88.2019.10.18.15.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:42:38 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Mattias Jacobsson <2pi@mok.nu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kbuild test robot <lkp@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: huawei-wmi: No need to check for battery name
Date:   Fri, 18 Oct 2019 18:42:14 -0400
Message-Id: <20191018224221.15495-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191018224221.15495-1-ayman.bagabas@gmail.com>
References: <20191018224221.15495-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to check for battery name, we already check if the WMI function is
available in huawei_wmi_battery_setup.
---
 drivers/platform/x86/huawei-wmi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 26041d44286a..7373a65a61d3 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -471,10 +471,6 @@ static DEVICE_ATTR_RW(charge_control_thresholds);
 
 static int huawei_wmi_battery_add(struct power_supply *battery)
 {
-	/* Huawei laptops come with one battery only */
-	if (strcmp(battery->desc->name, "BAT") != 1)
-		return -ENODEV;
-
 	device_create_file(&battery->dev, &dev_attr_charge_control_start_threshold);
 	device_create_file(&battery->dev, &dev_attr_charge_control_end_threshold);
 
-- 
2.21.0

