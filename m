Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12D59223
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 05:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfF1DpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 23:45:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34283 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1DpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:45:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so2438411plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 20:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KXeTyYem+OqmfXAB9jLbUiQJPmVsVcB9d5ZOaBgKddE=;
        b=texMjThj9ELOsjSLEq9Y653PtH5SuvN1GG5Y4WjBzQ78DmK8vothKCoDarMC/zabdf
         dOx030cYIzc2IAzYObguAgEwet0sMRx14n3TP0n0+MNWPt5RHK6rrxHbh6XcVYO1rEVP
         DEUVrqxC1J13RZ3/9TWHkAHH+H4YTqjlMVaweakNMu2a9f5z/XGDci/PJiQkZBgrKGyh
         6NDYgauYnoWeIRAl79kkIBELWXk2PqWWLlBtvxyeJkj/4GI9anNqNBhwRP2gLP9G+xuE
         ZnkeLoPywR6luGzYn0SGkGMvfKGXJk7XdVD2taqRfYJM/ermdOONmkpTjndt+g10z4Wf
         i4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KXeTyYem+OqmfXAB9jLbUiQJPmVsVcB9d5ZOaBgKddE=;
        b=QWuZjp73F+RmJ1m510LSN1vexSIf1i0Qtw6R9DEv4aJJ8/Y+ZZPtpUe32iTSA2WgLG
         iANap8Wj6RJUnUxvRie4eM5n7IOqvJpzFm29mG1z5noxBGrAuc1QHiLjeeGP/S7rukvV
         mwau8VApSKO+kM/CvxhB7jyrexd/Yvcr9QIsidJOMT1ttGhuw9rcJ9XXlF0kG22qmWY1
         TzfofCAyJttqhqB1eM4pjBZmW910PgzOxhZyZTeIpIFEnP+A9EUocPl02EKiUwFt+yQz
         IZK2fVdYxC0Yf5gK/1SRh0a/fNU4+P6jzybPLntziS1zPqsv0XBvLahz2e6YWKkbYv0c
         Vq3A==
X-Gm-Message-State: APjAAAUzfvMlNey8E6IKkg6F8dDHB6vOakh+Q84vYUGI23yiPWFJufFk
        hScQiinKNoB7J7IrdQ5PgNI3p2wp
X-Google-Smtp-Source: APXvYqziLzLlQJalN1m0zwRWAZgf0EFjLz1Ds/0ZjyAtyiCKJGWj0KUtdxBH5Eh1IDYaR6xlQFjF5w==
X-Received: by 2002:a17:902:aa83:: with SMTP id d3mr8633526plr.74.1561693507494;
        Thu, 27 Jun 2019 20:45:07 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id c69sm629715pje.6.2019.06.27.20.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 20:45:06 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] staging: erofs: don't check special inode layout
Date:   Fri, 28 Jun 2019 11:42:34 +0800
Message-Id: <20190628034234.8832-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, we will check if inode layout is compression or inline if
the inode is special in fill_inode(). Also set ->i_mapping->a_ops for
it. That is pointless since the both modes won't be set for special
inode when creating EROFS filesystem image. So, let's avoid it.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/staging/erofs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 1433f25..2fe0f6d 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -205,6 +205,7 @@ static int fill_inode(struct inode *inode, int isdir)
 			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 			inode->i_op = &erofs_generic_iops;
 			init_special_inode(inode, inode->i_mode, inode->i_rdev);
+			goto out_unlock;
 		} else {
 			err = -EIO;
 			goto out_unlock;
-- 
1.9.1

