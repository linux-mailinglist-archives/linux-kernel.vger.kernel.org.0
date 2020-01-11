Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B3137D19
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 10:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAKJxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 04:53:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20213 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728767AbgAKJxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578736426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=1Mw1TdPobJl6WJC81TWqRK1f1Db0Fv8lIBs247IxI5U=;
        b=W2zVxTYh6jFpSTYnXpbR4XprNRLd9fEsngOIlfb7zJ6mFcvcHX6vw7iVc07nob77q2PIfq
        jqHK1wffYTcKYN//9EmVA1j5oWIgFvRGBW/swQbDAWxVJpMlr5loGfoXNrSKszBrsYTTiW
        ZpHlYxB+RuQe16P+AHnvki8I9phoGsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-2Qf2B6rfNG6-At1gfoCMRA-1; Sat, 11 Jan 2020 04:53:45 -0500
X-MC-Unique: 2Qf2B6rfNG6-At1gfoCMRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 000261800D4A;
        Sat, 11 Jan 2020 09:53:40 +0000 (UTC)
Received: from intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com (intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com [10.19.176.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FFA1272A6;
        Sat, 11 Jan 2020 09:53:40 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Track loadavg changes during full nohz
Date:   Sat, 11 Jan 2020 04:53:37 -0500
Message-Id: <1578736419-14628-1-git-send-email-swood@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: drop the first couple patches that appear unnecessary

Peter Zijlstra (Intel) (1):
  timers/nohz: Update nohz load in remote tick

Scott Wood (1):
  sched/core: Don't skip remote tick for idle cpus

 include/linux/sched/nohz.h |  2 ++
 kernel/sched/core.c        | 22 +++++++++++++---------
 kernel/sched/loadavg.c     | 33 +++++++++++++++++++++++----------
 3 files changed, 38 insertions(+), 19 deletions(-)

-- 
1.8.3.1

