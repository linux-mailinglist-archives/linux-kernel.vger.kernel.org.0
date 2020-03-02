Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6E1754E5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 08:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCBHvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 02:51:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37495 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBHvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:51:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so11210179wrx.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 23:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ssK6C+oIWFwNTCkD/7yIjpV/97Ow/36njodjj0Oe6j0=;
        b=ACPyQ5nobeKQXw79oJkOsWUo53Ip9QiRjcgrPughOtv9giV2nycKvBkET6hBiDMcrm
         5zWeGxofOFTC6hIdoCNrxUWG3q1mpsD02kgoLr0DzIE3L/GaqCgLgngVoFRfAlX/rYCB
         A8EYpk6UDlsxkM0vSzTq8DbyPDDn5akwd2T5oJLstg+RQAx3YmWRrfx3ClTYjghOAR6t
         CfCdR3xbczqFww1eQlLGyOUKAKmomu0iguLq0KCfmKHpYPVcNH3RP9fm7FXLkglwa6Ip
         nnEO57OHqsQf9ihofBf218kPtL+x1JsYnTurtWhLMvhIoVJkfAT8B4+3aRQfhXLccCCu
         x9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ssK6C+oIWFwNTCkD/7yIjpV/97Ow/36njodjj0Oe6j0=;
        b=Q+W8Vu0QR2LgXU1s5GX6g7sxF49tX1rUQpEXM4AHBOFWTQRLhlLLPlmvi5+gI4+/2X
         B24UweL/89/knkU8godnnCNIAQcnNtCPv3dvXKzN80HXazn87ThAjXb+N0BFAwSmkv/B
         oaYGuVq1LMpf1NRvbZElb3bdjTruw72IFtiNSArnzrmyCTA59ymhueRy63gmjwD0FMlT
         4RwWypc3gkG+uv3gDNHvOCYSpttmFT5jyuflpRKjjtB0rHXY0rj1zfVhKrQ0Z6W3af2R
         R0NLoqgkLW2HQfkhnOvCG9XkhWvTEQzzVBzK/eea+nv89zjM2R/WsgNDZZK3fUs4RsGV
         e+3Q==
X-Gm-Message-State: APjAAAUMQSgpa6gnYitsDKp2nQt7ppl1GXOFHoEdEpH24buyTjsVhGe1
        6bsmHAGmaG3FE2xR0QI6V4Y=
X-Google-Smtp-Source: APXvYqwkPPiMVYVp/lg6SM+G8dzZ5h9CRibq5J/7BJ3ORyHCHJ7t23SG7ChJK1QZ3f2pRwauHYkZ/A==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr20267192wrw.193.1583135499116;
        Sun, 01 Mar 2020 23:51:39 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 19sm16387490wma.3.2020.03.01.23.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 23:51:38 -0800 (PST)
Date:   Mon, 2 Mar 2020 08:51:36 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fix
Message-ID: <20200302075136.GA48297@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 289de35984815576793f579ec27248609e75976e sched/fair: Fix statistics for find_idlest_group()

Fix a scheduler statistics bug.

 Thanks,

	Ingo

------------------>
Vincent Guittot (1):
      sched/fair: Fix statistics for find_idlest_group()


 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3c8a379c357e..c1217bfe5e81 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8337,6 +8337,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
 	sgs->group_capacity = group->sgc->capacity;
 
+	sgs->group_weight = group->group_weight;
+
 	sgs->group_type = group_classify(sd->imbalance_pct, group, sgs);
 
 	/*
