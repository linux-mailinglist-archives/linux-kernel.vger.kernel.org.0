Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6CD2AB4F8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404168AbfIFJeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 05:34:23 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42865 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391097AbfIFJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:34:23 -0400
Received: by mail-pf1-f202.google.com with SMTP id w16so4142948pfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 02:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=1BLM+8RkYf8/MndiCshul4/7LoT+5adDFDiSgd05Noc=;
        b=JxFjM4B7HKjIXBKRIn6+p0en4hhmFlji4b8vK7raPD/Ike5uXIXHdkDZ63rRW4MS/a
         i8EuuqGHx0z/83ENaRRGpWiOoV7Js3PVN0536iSop1tJ0dKjxB8iOXDceBFTjXh5F1WE
         EAc5rGKOk+/AuhyDDWEzpXSb4ac0yuXla3BoP726wGbAbU/ofZxQg1jj1jy7gIHoEFQR
         58oWNHr87R2d8MdFVTQMSdNF+Yacm0QKsyGCv9/LetG3N/HP/HSKopGuNn11x1XISZCo
         jEU5uCMrgQkZYufvBQFuaNLHWs7jj5U4w9xoKkCsF9sH9HPlNUnzH720dq98EZA5Vj4Y
         /i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=1BLM+8RkYf8/MndiCshul4/7LoT+5adDFDiSgd05Noc=;
        b=XmSHlvPGLpokWeIUS0uc8fMu6kVs0tdKeVQJsSM3UeXgnj6VRgu55Wa6PNr7DpWhcN
         F6DYEZ7IwzR1oJ2F37Z1ZZ5mErua5dwFVi7/vti56JpKZqbWuYnG2RJJK5bapAVL4fr3
         8rNgv8Id6ThuMVRFJbdq4vN/XNy1oEvzLD5ch10RW0ba9Ws6AtnT9uC5mHTir7LFjQar
         AA4hyepL0OBLWxxfIJGE2m3XenfZpJX9jrE3J0nRIoba+XrnTGORrJpJxKaUw75iT+lw
         fj6H7tK2MJxQPlk7thVW5qM4LE6607rFxR3IQKxMt4hxxTs9JtZTYTxHhgkOVRyer+en
         Gl+g==
X-Gm-Message-State: APjAAAX1sWFS71TtWICXo+WSAOIBzSRWfdppi2yc2s1ceClz58yhiPyd
        mq29PpRJlSVDExjsSlKvA+CJVRH2+0yOkCBTfw0Nfnc2n4k/r4K7P3RUqumyQdlbjzObvK6GzHM
        fPdmCRyp1ReDI1Q2v+RpIibdzWsfvtu71hVsIgdgMUX63GISZn3Zqh5UkmYZzkw==
X-Google-Smtp-Source: APXvYqx7ko7R6Jw2+USMRIzzf5uJvWlBnbcmCVVq5z31qVPuXUgOwzU1hY4T/cYiI/zyD5rKZ/AAMrs=
X-Received: by 2002:a65:5188:: with SMTP id h8mr7110393pgq.294.1567762461979;
 Fri, 06 Sep 2019 02:34:21 -0700 (PDT)
Date:   Fri,  6 Sep 2019 02:34:11 -0700
Message-Id: <20190906093412.233463-1-xii@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH 0/1] Add micro quanta scheduling class
From:   Xi Wang <xii@google.com>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        linux-doc@vger.kernel.org, Xi Wang <xii@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a scheduling class that does one thing really well:
microsecond level scheduling granularity. There are many problems
It doesn=E2=80=99t solve, e.g. there is minimal mutlicore support. Context
switch and cache overheads are going to be higher but we found
benefits outweigh drawbacks for certain applications.

It can be used in two different but related ways:

Provide softirq like scheduling latency for kernel and userspace
threads. Somewhat safer and easier to use than both softirq and rt
classes - microsecond level time slicing means a microq task can share
a cpu with a cfs task and still maintain low scheduling latency. With
rt classes users often have to choose between starving cfs tasks (rt
bandwidht control not activated) and high rt tail latency (rt
bandwidth control activated).

When busy polling is desired, we can run the busy polling thread under
the microq class with less than 100% of allocated cpu bandwidth. The
response latency would still be low and some cpu cycles are recovered
from the busy polling loop - it is a middle ground between interrupt
driven and busy polling.


Xi Wang (1):
  sched: Add micro quanta scheduling class

 Documentation/scheduler/sched-microq.txt |  72 +++
 include/linux/sched.h                    |  12 +
 include/linux/sched/sysctl.h             |  12 +
 include/uapi/linux/sched.h               |   1 +
 init/Kconfig                             |  13 +
 kernel/sched/Makefile                    |   1 +
 kernel/sched/core.c                      | 138 ++++-
 kernel/sched/debug.c                     |  28 +
 kernel/sched/fair.c                      |   4 +-
 kernel/sched/microq.c                    | 750 +++++++++++++++++++++++
 kernel/sched/pelt.c                      |  30 +-
 kernel/sched/pelt.h                      |   6 +
 kernel/sched/rt.c                        |   6 +-
 kernel/sched/sched.h                     |  63 +-
 kernel/sysctl.c                          |  23 +
 15 files changed, 1135 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/scheduler/sched-microq.txt
 create mode 100644 kernel/sched/microq.c

--=20
2.23.0.187.g17f5b7556c-goog

