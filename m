Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E20D318F00C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 08:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgCWHC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 03:02:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55221 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgCWHCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 03:02:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id c81so2928892wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 00:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5jTrjO4QSy5fUBmSLfWHrfzpqSWpoJNJJJo1AqTJhfE=;
        b=VDtaFZaUmPZr8jbxDzrfRDjnl5Dg2m1FlJrzku7TJJmh8Farbm29/l5MlqLy7GiEhW
         86f3P+aU8L6NeTKE7s15nCKzF3cBavJZfXPVg0falO+Z61B6UwrjNLhCI7Vo1ifnWIOQ
         lQ3wXJH5Y7x7gaLAAInH+p/RAPt+szD5urRJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5jTrjO4QSy5fUBmSLfWHrfzpqSWpoJNJJJo1AqTJhfE=;
        b=rqf6lc+6BBVFRoOFznR/8tigp31MvTZ1UETFju1/oTMJCkSPA9ljs361LQKTmj/A/e
         jMErgPhY+n0pFfiYDcnJrs995/hujFqqBoYQAlCuV0/kgzzjZ8MuY1jUKeiDRcnK9Hyh
         rercwzGKEgW+jlGy0zFVczi1xSvP2e9v4gwo4f8GG7uKfft1m/JMCmsems+l1qFRF8U6
         k6xu3u/SY54oPbIHX2jIELTFZwmbFWSf9nNYfIulaHiKCcjW7Ej5vJIAwHa7mOP8AhbU
         zzLavm6ppfOE+eHlDvpNxpyvNwbDCZSuTwHDBe/4N5fxQsuwsDL3eH5teXrJX+lEgfGN
         Njnw==
X-Gm-Message-State: ANhLgQ1CK6BRJILGFHM5GY7mOb1qgSWb/MzbeRqPsMbDCfN80klbxRqj
        3MTaTKTYjA1CcuDn0njqRhmnbQ==
X-Google-Smtp-Source: ADFU+vt8wlEJzuyTBKieIQvIghcKvOFk9qC+BSzFe8laRmww4Kq84qj6x71Ht8C6r0LiJct+CW+zkA==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr25954016wmd.16.1584946973457;
        Mon, 23 Mar 2020 00:02:53 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t2sm8198735wml.30.2020.03.23.00.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 00:02:52 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 1/1] firmware: tee_bnxt: remove unused variable assignment
Date:   Mon, 23 Mar 2020 12:32:42 +0530
Message-Id: <20200323070242.16873-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable assignment.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index ed10da5313e8..6fd62657e35f 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -143,8 +143,6 @@ int tee_bnxt_copy_coredump(void *buf, u32 offset, u32 size)
 	prepare_args(TA_CMD_BNXT_COPY_COREDUMP, &arg, param);
 
 	while (rbytes)  {
-		nbytes = rbytes;
-
 		nbytes = min_t(u32, rbytes, param[0].u.memref.size);
 
 		/* Fill additional invoke cmd params */
-- 
2.17.1

