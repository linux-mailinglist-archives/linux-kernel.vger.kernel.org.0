Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5FEA12DF02
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 14:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgAANOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 08:14:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39196 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAANOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 08:14:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so13828788plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 05:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=iJ6RsG9cvRBP8rs1VDh1iywU1VHG716HyNaNKvXn9TU=;
        b=d3K+fRDTbe1Ivun2PuE5bYF81aptwI3rlmW7nscDLJYsg7ZVz294IMcbkQi2L4wYwW
         8rmMvNx9BZZ4pAHRxH+UM6nydI5ZCF6VxxZJNxL8D6haecmycK+pCh+srrd+QqoFlyqD
         S56MaaI1t45gCxzlY0McTImx4aQcyL7VUSsOezYY5AYNMGeVCfcuDSatYsJwidDsmUUZ
         ES6qwKfEGGEwp3DvpxYvMzCSc2gG7pgkFD48GyL3mZWzbMy1ficfQnQdCMgsl0IK4wuA
         9QkGi8nV7cWJiNeM6BEO4M/bDfe8CaqdTc3eBE/1sTwXDm1Zfobfy3v6wftVHP/nyJk2
         L+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=iJ6RsG9cvRBP8rs1VDh1iywU1VHG716HyNaNKvXn9TU=;
        b=rhjNnqXC2GQfHCqm79CFhPvS+bAgPvJs2sj/uT+kK6JR0q5P6YIhz8VA1e4Je0Owau
         64EU5dOjXmKquXAWSaGbW1aKcz9Z43lVP8AOlBnhaXu/GBYkhK5BQhBnoBgVbO4LLTcP
         M0v4+LBl1UbYQPGcz1aq2821D+VRGbQrbooyW1qB6CbSKDvMgEunIEIWBKQ35xn9G/a0
         +YZ6NuMWN36lqzk0Nku/69+HPAANvHit1lkHwkBpY51OonZbOSrFI0Rj5lO1fCCX2HHq
         iWKZEUkVU0GE5m0z/PSNSRlCllqwgxjFpYjL4W6WloZVPzeeKZusSW6ozNQbobp97BX/
         LiRQ==
X-Gm-Message-State: APjAAAXGWkfODOP63LNVI4HRmG9lGJJpWxMvHImdA/5FWofu2pul1PtJ
        pc4tvJb1o4cq+DTyL9IpjVKy4hXWGk0=
X-Google-Smtp-Source: APXvYqxKBHjYr9//Qi4OTCQB5A+2VajbgZg6b2q0W1NTsX2VfUvz3GK+UA6SMEyKsoweX1U20ScPmw==
X-Received: by 2002:a17:90b:11d7:: with SMTP id gv23mr13845389pjb.94.1577884469512;
        Wed, 01 Jan 2020 05:14:29 -0800 (PST)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id n4sm2828058pgg.88.2020.01.01.05.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jan 2020 05:14:29 -0800 (PST)
Date:   Wed, 1 Jan 2020 18:44:23 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Thorsten Scherer <t.scherer@eckelmann.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] siox: Use the correct style for SPDX License Identifier
Message-ID: <20200101131418.GA3110@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to Eckelmann SIOX driver.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes in v2:
  - Correct the spelling of the word Eckelmann.
---
 drivers/siox/siox.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/siox/siox.h b/drivers/siox/siox.h
index c674bf6fb119..f08b43b713c5 100644
--- a/drivers/siox/siox.h
+++ b/drivers/siox/siox.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2015-2017 Pengutronix, Uwe Kleine-König <kernel@pengutronix.de>
  */
-- 
2.17.1

