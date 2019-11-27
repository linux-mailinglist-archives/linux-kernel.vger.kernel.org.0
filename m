Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6403C10B40A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 18:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfK0RDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 12:03:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50145 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726984AbfK0RDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574874214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RK6Z/QC8Et+4Op0x7LlPHwcCsvq5DcwP1lX31wAzH+8=;
        b=aCWxwjQfedbHOGozTVdnTIv94eyal/NbyP8rv2HGYrJhFhYhOR0Wb9rVtmypboeVMkkL55
        /xVjcmxbzZ3SaYCWR+gzvCv7m8j+xyg5D55k/KP6+2iwifatYupl+D1l21LoQZFBX+i7Al
        OVx3ZZOdbuQVxU210MVhZ1nFUERgEmE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-lLGEjrDlM0-Q9MUrHhkVAw-1; Wed, 27 Nov 2019 12:03:33 -0500
Received: by mail-pl1-f199.google.com with SMTP id q14so9888810plr.15
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=sXvH1TCWEfM5kCCRo+pVEE1B743fcSSjGvOi9uUGkxY=;
        b=nNgQyJ4tXWCSY/CdrTbEBqBcy+xOkLYpEnUhYxzqbbZuSMAhwTgfEcV46gFJqhCW9j
         GKI41JxQ8eMWqtD8AeAgdhy+abrS278Yz7yqmUVziWjdIa0aXUA+udMaj5KK4xI0ssmp
         ir6Zyx91w77lI4noY5SPCu7YNSLeWiStCShSgo551c5Gv6kWBQzAcuaGoczvNGmL8zt7
         ua556aTc1opYLOOty6poV1ldiwz3p4KEPhnRVa6TuhIXTDT9U0VOYTlkQdVX4iDOg7FS
         URoGz5LRjBrhyjQmkq97p7pJskNLfecFdgcTjFi358Be0CuyiCaRjWRV+wOfimgfya5c
         UEsg==
X-Gm-Message-State: APjAAAWSfMtAZq8YOpeAw9U8uwzfX5JXc/cmn4HCiTQZAgfF7Xgx9kTm
        y/etQTwtC8Pq5ihbG0C5moX3XuEdS4kcQo9kLOgHJS+lP+lL0l7PDTNuzVuzjYJu2cXS3yETmud
        tiCJplKGooTB9I12b0lXgiaXG
X-Received: by 2002:a63:9d41:: with SMTP id i62mr6329539pgd.310.1574874212192;
        Wed, 27 Nov 2019 09:03:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNbbZqoES/yWF7zu4dbbYEYKtP44S3BiMCEXJwSLbN+tUj7THW30dCd22yzMN2OQccHLo13A==
X-Received: by 2002:a63:9d41:: with SMTP id i62mr6329402pgd.310.1574874210962;
        Wed, 27 Nov 2019 09:03:30 -0800 (PST)
Received: from trix.remote.csb ([75.142.250.213])
        by smtp.gmail.com with ESMTPSA id ce22sm1766266pjb.17.2019.11.27.09.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 09:03:30 -0800 (PST)
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
From:   Tom Rix <trix@redhat.com>
Subject: [PATCH] sched: remove noop function task_fork_dl
Message-ID: <56b066c2-90fd-4263-cf31-0a08ea44fd53@redhat.com>
Date:   Wed, 27 Nov 2019 09:03:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Language: en-US
X-MC-Unique: lLGEjrDlM0-Q9MUrHhkVAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


task_fork_dl is an empty function used only for dl's
sched_class.task_fork.=C2=A0 Removing it cleans up the code a bit
and saves a function call in sched_fork.

Signed-off-by: Tom Rix <trix@redhat.com>
---
=C2=A0kernel/sched/deadline.c | 10 ----------
=C2=A01 file changed, 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a8a08030a8f7..fbafd97d883a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1821,14 +1821,6 @@ static void task_tick_dl(struct rq *rq, struct task_=
struct *p, int queued)
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 start_hrtick_dl(rq, p);
=C2=A0}
=C2=A0
-static void task_fork_dl(struct task_struct *p)
-{
-=C2=A0=C2=A0=C2=A0 /*
-=C2=A0=C2=A0=C2=A0 =C2=A0* SCHED_DEADLINE tasks cannot fork and this is ac=
hieved through
-=C2=A0=C2=A0=C2=A0 =C2=A0* sched_fork()
-=C2=A0=C2=A0=C2=A0 =C2=A0*/
-}
-
=C2=A0#ifdef CONFIG_SMP
=C2=A0
=C2=A0/* Only try algorithms three times */
@@ -2451,8 +2443,6 @@ const struct sched_class dl_sched_class =3D {
=C2=A0#endif
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0 .task_tick=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=3D task_tick_dl,
-=C2=A0=C2=A0=C2=A0 .task_fork=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D task_fork_dl,
-
=C2=A0=C2=A0=C2=A0=C2=A0 .prio_changed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D prio_changed_dl,
=C2=A0=C2=A0=C2=A0=C2=A0 .switched_from=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =3D switched_from_dl,
=C2=A0=C2=A0=C2=A0=C2=A0 .switched_to=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=3D switched_to_dl,
--=20
2.23.0


