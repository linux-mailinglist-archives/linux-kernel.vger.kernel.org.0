Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD43614EA06
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 10:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgAaJZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 04:25:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33220 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgAaJZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:25:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id m10so8352284wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 01:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DCb/xDvlwv6fnMWcXIG/HuzVabukmnqhy19nDjpW0Wc=;
        b=qw7cjjs1E8pWma/72zrvOGI0LqLcmxYxDNX+xebO0ZXD6XnnEZrYR2icMTWMxOo11x
         F+wRvfqULKxmJcGxieJbO086EJay6OGEsbHP6tHgABYafP/Teswf2cZwWrXYsa7SqmbI
         3bb4SNv6etWoSXR/9ozFtALKoJGqTFLxUICBAguPNVkhjtXoXRCf+uvvKvyk6AHNgbkU
         DaJzmtjCJbLCCnejvJ9bAecH55lijryvFRtmRABSNSaMqWMXNiitRQ2SsZd20oAw28M5
         T4AFoEMW+8wabyt5BGv0AeHmdzruE70Hpd+8bQ2XK30FWlM68XNb17vgB/rWvtraOpGx
         buiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DCb/xDvlwv6fnMWcXIG/HuzVabukmnqhy19nDjpW0Wc=;
        b=qL5jIcc4aphMapLvr2LQ3TJrX53VyWso11bXSHCGvtfk8GvQm/AktQTIJXzy+QTDZg
         RT+TqqsJYYY4j8ME+EVLOtwMabHiMjMYSTc/ZMky6TPmx+JT7KY3WeGLh1saPbgyChlp
         D0K/8jD9M/iBXJyx9v5GF7rRNG9M8DSt48zpLDYY/Oh7z0r2L1YIRp2OiuM//Wo8AKSW
         DVLCVd2xVpggmmzo5DD4nRfYkPCTIVOrzZe8b5r+NH1zkzYt03MQ0EnejdXM78dv7KMP
         Q/wBRIYR1D6/C9e9OzLE/FF0BFuq3hNW8lHAO53tuB+qRGUn4OQtRa0VjsXC3lgxWGr0
         orLw==
X-Gm-Message-State: APjAAAV28mo7CF4ipA/mndiQDypyjOTfsydNEH/L0kSeX6Q2gJYXnk+7
        1NlPCmzj+MlOYkhVASzEUcSlpw==
X-Google-Smtp-Source: APXvYqwccI1zx5QiGLNXp4CTKPCYw4Fm19ZA2sJEKNWeNsHlMN4OdFKxyBQLewXej8EjpkXXtknjmA==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr11728395wmk.68.1580462703028;
        Fri, 31 Jan 2020 01:25:03 -0800 (PST)
Received: from localhost.localdomain (88-147-73-186.dyn.eolo.it. [88.147.73.186])
        by smtp.gmail.com with ESMTPSA id 16sm10144364wmi.0.2020.01.31.01.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 01:25:02 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 6/6] block, bfq: clarify the goal of bfq_split_bfqq()
Date:   Fri, 31 Jan 2020 10:24:09 +0100
Message-Id: <20200131092409.10867-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200131092409.10867-1-paolo.valente@linaro.org>
References: <20200131092409.10867-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The exact, general goal of the function bfq_split_bfqq() is not that
apparent. Add a comment to make it clear.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 28770ec7c06f..347e96292117 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5983,6 +5983,8 @@ static void bfq_finish_requeue_request(struct request *rq)
 }
 
 /*
+ * Removes the association between the current task and bfqq, assuming
+ * that bic points to the bfq iocontext of the task.
  * Returns NULL if a new bfqq should be allocated, or the old bfqq if this
  * was the last process referring to that bfqq.
  */
-- 
2.20.1

