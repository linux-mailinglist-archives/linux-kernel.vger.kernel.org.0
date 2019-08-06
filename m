Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4647C82F6F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 12:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbfHFKEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 06:04:38 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42999 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732472AbfHFKEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:04:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id s19so60590769lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5TEpMf9ydlfbXzNe485u5gwcmlpP2W7mB7vtw4xNQQ4=;
        b=k1k+QDSCc7OEAmnqo1P0gvMHj8zkLFalVRTHvMQKj0URb9HudpNuUObP9zjBvKqYUX
         bCp2hwTwOlfE0p0ddM+hJrCFL9oiky6xK0F7+cu1S3XiXKkiUpT6OWLR1FVZXBljQXIy
         K7dYo96ycFB5ghJ+yjERH8T/bCn0mmhCluh150MJMR40LU/0AZb1Ni0cLceGbsvLpu0X
         AqCDRS5n3bsL7Xviv/rAKvczZSFv5As+y06g6NlZr4obtGbu9vu8ERq32VFhaMSmcEKZ
         +YQ9dmlQMJRhsikM9tdkn1LTjfjeMuPvr9UcTyHR/xKGLnyeFCBsfgf5hrS+aYg0qAEm
         rizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5TEpMf9ydlfbXzNe485u5gwcmlpP2W7mB7vtw4xNQQ4=;
        b=s8PSF5fgQ9VAPC0BClcv1Vrfoh6/JO0vN+2yHgsDOL+aH4KpSu1Z6nopojgWWAf2KJ
         5DE3fAaH7NCLjgClh/UZNtnYnyT5SLf8FKsl1M1Vd0XvtFdeuYJ7eZhO38z+UadELPZC
         dghaZeHgKUMD49aZ149+HMKM4f1Le887s4023hFiomhldihEbUCwYNwloWwoUw8zr5lk
         8dori7fqXBysdG4dKFCXGf2LV29cGFBp+ewsJKpXsZyXgDpfXof4xilYvDbxcVIqSl9U
         EctxraKB1E02Ojrl2y1XZDWPgs3L75Zq5pxM/CFhEIgpSHPgMchG2PrHQC2XABiQwNZi
         1fOg==
X-Gm-Message-State: APjAAAWy5QqlX/AWNxkRgLDHRd9s4qpxYRpxt/POaVppUX6axT2gPZOa
        c67KeDmdyGInjYA54WDmRIluGQ==
X-Google-Smtp-Source: APXvYqyfqIcqLMxQy4UrrDCOjB1zyM8flnzvJDPhVWpUqIEOQO3yu5z8e/qA1WIffnWRVOfpYdcMQQ==
X-Received: by 2002:ac2:5492:: with SMTP id t18mr1889487lfk.41.1565085876500;
        Tue, 06 Aug 2019 03:04:36 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id p19sm1388903ljg.97.2019.08.06.03.04.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 03:04:35 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     vinicius.gomes@intel.com, davem@davemloft.net
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH] net: sched: sch_taprio: fix memleak in error path for sched list parse
Date:   Tue,  6 Aug 2019 13:04:25 +0300
Message-Id: <20190806100425.4356-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case off error, all entries should be freed from the sched list
before deleting it. For simplicity use rcu way.

Fixes: 5a781ccbd19e46 ("tc: Add support for configuring the taprio scheduler")
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net/master

 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index b55a82c1e1bc..4f6333035841 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1451,7 +1451,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	spin_unlock_bh(qdisc_lock(sch));
 
 free_sched:
-	kfree(new_admin);
+	if (new_admin)
+		call_rcu(&new_admin->rcu, taprio_free_sched_cb);
 
 	return err;
 }
-- 
2.17.1

