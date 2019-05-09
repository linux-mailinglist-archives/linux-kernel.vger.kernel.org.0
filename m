Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7582819016
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 20:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfEISSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 14:18:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40883 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEISSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:18:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so1615164pgl.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxtcoPDWC0ufZrnJnCPrEikgsmND9jfYfVByhehXHBY=;
        b=ZeXHdBW3JljXP43YRKjboAEyfk6WCudV2frx/3SqauL9A84L2sXrHdlnEgw2D/auAc
         Sw38NiL/aobwNHbh6YNuoOinZmantk6paxO9u69iwqQlgXEoqu5TWXsVns0OUNqJnxyp
         3MRDKTBBnLNje9sp7mlCCLXd6o8xeBFicJbCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxtcoPDWC0ufZrnJnCPrEikgsmND9jfYfVByhehXHBY=;
        b=hWdjeRVHSry6YMyNNcZjeBYqBfExxhBwIp+jcr06yp39XucyqwNWd3As/jkJ3M68LZ
         g1hbkcJRVBJZ8tLhT4AaQY5guKiKhKJ0yjknbPq0FSF71RSEynPF4jd6wYa3r+jEvjQS
         +CJO77u2WMHh2vOv8G3mP3bxCI9RWgoJey+apxoFiAToXtn6gcNc6lb0MH3MUyzofz3E
         tB7aGjK724C91eg+GefvmyBcNpvvIvFl63U6Fw9dn4jKG46v8AXfwPMKsMa8YTQC08dC
         ZzehZgDp0dI4GF0bSZ6EUuLDLBUd/NGgnGj0vOLcQ54DynzYbIZ1xe60KlHtQDhjmnfZ
         /6NA==
X-Gm-Message-State: APjAAAXJ5O0i3nkgjYF+OF4wGpndBmuSnBUE4vWHMoI/EUa0mma16Ue0
        f3dOWci9i6kFlgiZJBBS2SMrzQ==
X-Google-Smtp-Source: APXvYqzXFEFQd4xYOcB6VXrjjNez5N4F3akklJXvBWG2Z7vR5G8pPXz8eSBeS9TPiGZWlt1bHQ815A==
X-Received: by 2002:a62:2703:: with SMTP id n3mr7334160pfn.199.1557425879792;
        Thu, 09 May 2019 11:17:59 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id l68sm6545207pfb.20.2019.05.09.11.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 May 2019 11:17:59 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec_spi: Always add of_match_table
Date:   Thu,  9 May 2019 11:17:50 -0700
Message-Id: <20190509181750.134960-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Chrome OS EC driver attaches to devices using the of_match_table
even when ACPI is the underlying firmware. It does this using the
magic PRP0001 ACPI HID, which tells ACPI to go find an OF compatible
string under the hood and match on that.

The cros_ec_spi driver needs to provide the of_match_table regardless
of whether CONFIG_OF is enabled or not, since the table is used by
ACPI for PRP0001 devices.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/platform/chrome/cros_ec_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index ffc38f9d4829..3df315fce60b 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -709,7 +709,7 @@ MODULE_DEVICE_TABLE(spi, cros_ec_spi_id);
 static struct spi_driver cros_ec_driver_spi = {
 	.driver	= {
 		.name	= "cros-ec-spi",
-		.of_match_table = of_match_ptr(cros_ec_spi_of_match),
+		.of_match_table = cros_ec_spi_of_match,
 		.pm	= &cros_ec_spi_pm_ops,
 	},
 	.probe		= cros_ec_spi_probe,
-- 
2.20.1

