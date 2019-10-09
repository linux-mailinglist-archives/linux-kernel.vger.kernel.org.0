Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9C5ED14E1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbfJIRHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 13:07:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37338 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:07:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id f22so3395491wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wMt/20RYp2D24CkBqBwCHIn8mXh3zufzv+vPas0B+0k=;
        b=GjStgMNmlQcql2h79zEjsgzRpSMp111EWYQQpRfavS0uctuUzoLjyUfnFgBSKp1s41
         lmkJ0opea5nMrr8eKVZIiKs5eoiFx7LerCbgeIbLwLB3PZvsaNQQQAFtfGE1165AUyT5
         bD0A/PlgiavK3Ww4Z2KmvSyVSOjTG1gYevA/crgqjGL9N5zAxBoaSZmZGO6+iXSybp/L
         5oJruPPhUq9a9TPXzkCVLbC5N2mV1kV0O1YsZfkUKlXi9zr+nX3ohY9bXxkiyv5kJhJX
         8j+Kx/Z+WkQPgud1ZuEarSz+WU4Llh6+7X3M/6tVXUqVDE55FDhAILwOZl9rFzcJ11oG
         yDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wMt/20RYp2D24CkBqBwCHIn8mXh3zufzv+vPas0B+0k=;
        b=jSDO13mviNtmSEuF4sPUFUQsVdmAye6ytrf+yNPd/10o8GgrQfERYFv6hMPm2Ru/V5
         czeVR495ecJxNv6MYM5UQi9WDKuk+VxH5n19FFMBCDvsMnS0VOnTUZzU7oVfZ2eMIsXR
         o9dgKK8HQBw4elUNi8/qBrEUNeXVcEhhe1v3QClhrI6m1Oy5hbR1IwvSH2sGm+yed6Z1
         6Y76Ma7OicxsJ5zqA17SDEmdCtVSDQEwseXUlUA1jWmHK737fuOPYVEqGuqWRpaG+RQ6
         HDCrdrcc/ymS3/g8wkmT2qcRqGKpfWoJ0YmXcuxOjeZDvWIvU9ctxIb/N5IpaA3FzO6V
         j9NQ==
X-Gm-Message-State: APjAAAU6940dtHZp4DCpJjQh+NhnHlZT1EC9HVGVFor/viS9zK6901NB
        9Jjd4wOEdF5zcurtBNkOog4=
X-Google-Smtp-Source: APXvYqzMzjWTtK9YbbVjs2nZryVk+iRT4q3A0Pi5EV3RxZBL/OERsoSvJzdAh27UabSfuZmh38KHwA==
X-Received: by 2002:a1c:c90c:: with SMTP id f12mr3304633wmb.97.1570640829812;
        Wed, 09 Oct 2019 10:07:09 -0700 (PDT)
Received: from wambui ([197.237.61.225])
        by smtp.gmail.com with ESMTPSA id y14sm4020193wrd.84.2019.10.09.10.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:07:09 -0700 (PDT)
Date:   Wed, 9 Oct 2019 20:07:03 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: kpc2000: Remove unnecessary return variable
Message-ID: <20191009170703.GA2869@wambui>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary variable `val` in kp_spi_read_reg() that only holds
the return value from readq().
Issue found by coccinelle using the script:

@@
local idexpression ret;
expression e;
@@

-ret =
+return
     e;
-return ret;

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 3be33c450cab..6ba94b0131da 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -162,14 +162,12 @@ union kp_spi_ffctrl {
 kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
 {
 	u64 __iomem *addr = cs->base;
-	u64 val;
 
 	addr += idx;
 	if ((idx == KP_SPI_REG_CONFIG) && (cs->conf_cache >= 0))
 		return cs->conf_cache;
 
-	val = readq(addr);
-	return val;
+	return readq(addr);
 }
 
 	static inline void
-- 
2.23.0

