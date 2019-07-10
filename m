Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A58864DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 22:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfGJUf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 16:35:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39843 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfGJUf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:35:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so3429538ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKFc1Wq9QBg2lW0t341DLmsTyWawFPwecMNk4oaiTPY=;
        b=uTwZ4SVG0MeSMc+IiWS4bcYIK1/Jsjtw7/x8O1aXh6EesgPFAtzwbum8meOxBxuy1J
         mR64l2T1mFOenH5qOVNDjTARfoVsFMEMlrfw0e0qqwrv4KQDRgkgUSJvfa8das+T9UOU
         eAdZU4sedsdsADSkE18PH2S0X1n33b0E+D8JAYnscfZLFprk3R9ERU1AoVZNYEHeFEte
         Xpk1FZn3065trsbIzfW824VF8o01cNsoqs7PTcg0UfTPZKr5CZrz9I3nWEfnEVW2Z3Ng
         wAYDfV39S2zNrRFPFcfZhQd7V/G8ViaiT9MUMFJjX0mHiaC5XwVbSp0/vYj2da9ljmvk
         3aFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKFc1Wq9QBg2lW0t341DLmsTyWawFPwecMNk4oaiTPY=;
        b=GVlSS2/K3cV775FJJso7TIuix+xytGo91yvZjMfNxiKtoPbR4FwV0uc+jfbmrvW9v+
         lw5OMVkIRgzjjxD/VsKO9Jw0gsp5fxXFdjGzdUViJ5ZGUrp22xnRPWKuYqgNH4y2qd2F
         QvHj6IwnVRmlYgqK8qncM4xRnOC10a6ULnQhQCAJ0SuIY32r/nuewmBGJFpdoGSkPS1Q
         Tgn94oRWXpYm/I6IYedXp5EX1PJ9fb1aUj43wMKR4eU7FhlR/46ta8K873O3iEUFDkKE
         W80DODo/3sbZYD9tdSh9FO6lL3Oy9+eUY/EfM0ddg3GV5MNozX3aFVuP4YIex162oJHM
         Kjuw==
X-Gm-Message-State: APjAAAWu0QvPBE3ZXwb5RYjUmzdsqRuu/y9Ffbbf2FfR7dknPFuAzIPt
        FsfIU6vYT1IpR7iVhOK0DWM=
X-Google-Smtp-Source: APXvYqxz3ja1YNV5lfOWOxXgUi8GNOWPkV3FDNEtOtbXK2rBxkm9JMwsz1Gd9zvSZjt1NlT6QeDgOQ==
X-Received: by 2002:a2e:9b84:: with SMTP id z4mr85314lji.75.1562790954703;
        Wed, 10 Jul 2019 13:35:54 -0700 (PDT)
Received: from localhost.mts.local ([5.144.106.90])
        by smtp.gmail.com with ESMTPSA id r24sm706126ljb.72.2019.07.10.13.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:35:53 -0700 (PDT)
From:   Ivan Bornyakov <brnkv.i1@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        benchan@chromium.org, toddpoynor@google.com, rspringer@google.com,
        Ivan Bornyakov <brnkv.i1@gmail.com>
Subject: [PATCH] staging: gasket: apex: fix copy-paste typo
Date:   Wed, 10 Jul 2019 23:45:18 +0300
Message-Id: <20190710204518.16814-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sysfs_show() case-branches ATTR_KERNEL_HIB_PAGE_TABLE_SIZE and
ATTR_KERNEL_HIB_SIMPLE_PAGE_TABLE_SIZE do the same. It looks like
copy-paste mistake.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 drivers/staging/gasket/apex_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 2be45ee9d061..464648ee2036 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -532,7 +532,7 @@ static ssize_t sysfs_show(struct device *device, struct device_attribute *attr,
 		break;
 	case ATTR_KERNEL_HIB_SIMPLE_PAGE_TABLE_SIZE:
 		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
-				gasket_page_table_num_entries(
+				gasket_page_table_num_simple_entries(
 					gasket_dev->page_table[0]));
 		break;
 	case ATTR_KERNEL_HIB_NUM_ACTIVE_PAGES:
-- 
2.21.0

