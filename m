Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A959C197276
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 04:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgC3Cdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 22:33:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35420 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgC3Cdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:32 -0400
Received: by mail-qk1-f194.google.com with SMTP id k13so17557199qki.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 19:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I4Nrsn6k3gNjz4BOh5fYXmBusY3PxyBtFMiw/JeGaFI=;
        b=jbVb7rCDOQJz/kZvzoZg+nCBb4KUFEC+TOEHwI4K8l+pGSIYeCpBI96P01eV0zI9Xp
         UNulmO6Khkf8qD/AV6xh9l+zZWLcHZ1inkxlOpcjtRZ6MlaiZ2Q7kqdApuFN8GuiCNpu
         Wr49Ico00ahZmHYOYYNSeavwXVppbVFOAov0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I4Nrsn6k3gNjz4BOh5fYXmBusY3PxyBtFMiw/JeGaFI=;
        b=oNUdB0KOvHsbhivrcO8Jti0sWQiFzdCL8q9F5vUZPfsUQSO1XT3nhKnermeJl3xcLT
         /DJv9kkEtYIXOJp2EDxVslRFNQLgO7BFJHqwSd3UR2IxbIRMiT2CbmWuSRYTSGCqXd2x
         kizHsIZLk8xkNIYTHQ8aPpnTLqE1Q/m2A8Mfwg1l4XVBbYOL9PtqHAz3XZsrwgOY3kA1
         GOFtgijIyLF9LT0q1GZNQgek4Med4J1Zlgo+Av4BcFEaQPhufLkaTFFqKDbFIPh6Fgtb
         OjHJePuDzUO/nkZUb6P+HWpN472SOJp62MndVLo/0jh2kcGDV/kzL0RZqT9JJDw6L9Vl
         Rysw==
X-Gm-Message-State: ANhLgQ0gmDkkGGYBwwUdvivssD2WO1aGVIpHUdgoU8ozVQCRakkOzal0
        47h8taqf/Jesy8zfxiSjWDqfAQCUIH4=
X-Google-Smtp-Source: ADFU+vtXh936KTMI8VcRei3o2sQCtsNDgg/nJ1FXpiRXs/K5bI0kVr1o3ZMKLWaw3v458vKR4rRcmA==
X-Received: by 2002:ae9:e00d:: with SMTP id m13mr9901951qkk.297.1585535610977;
        Sun, 29 Mar 2020 19:33:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:30 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 00/18] kfree_rcu() improvements for -rcu dev
Date:   Sun, 29 Mar 2020 22:32:30 -0400
Message-Id: <20200330023248.164994-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
These patches improve kfree_rcu() to support:
- kfree_rcu() headless usage.
- both vmalloc() and slab free'ing support using array of pointers.
- simpler debugobjects handling.

It applies on rcu/dev branch as of March 29th.

Testing with rcuperf shows following changes. The memory footprint reduces and
batches go slightly up. This is assumed an acceptable change.

with all patches:
Total time taken by all kfree'ers: 27312964461 ns, loops: 20000, batches: 3120, memory footprint: 211MB
Total time taken by all kfree'ers: 26773272309 ns, loops: 20000, batches: 3084, memory footprint: 208M

without:
Total time taken by all kfree'ers: 25711621811 ns, loops: 20000, batches: 2814, memory footprint: 230MB          
 Total time taken by all kfree'ers: 25775800546 ns, loops: 20000, batches: 2755, memory footprint: 230MB

These have been pushed to the git tree at:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch rcu/kfree)

cgit view:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=rcu/kfree

thanks,

 - Joel

Joel Fernandes (Google) (5):
rcu/tree: Simplify debug_objects handling
rcu/tree: Clarify emergency path comment better
rcu/tree: Remove extra next variable in kfree worker function
rcu/tree: Simplify is_vmalloc_addr expression
rcu/tree: Make kvfree_rcu() tolerate any alignment

Uladzislau Rezki (Sony) (13):
mm/list_lru.c: Rename kvfree_rcu() to local variant
rcu: Introduce kvfree_rcu() interface
rcu: Rename rcu_invoke_kfree_callback/rcu_kfree_callback
rcu: Rename __is_kfree_rcu_offset() macro
rcu: Rename kfree_call_rcu() to the kvfree_call_rcu().
mm/list_lru.c: Remove kvfree_rcu_local() function
rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro
rcu/tree: Maintain separate array for vmalloc ptrs
rcu/tree: Introduce expedited_drain flag
rcu/tree: Support reclaim for head-less object
rcu/tiny: Move kvfree_call_rcu() out of header
rcu/tiny: Support reclaim for head-less object
rcu: Support headless variant in the kvfree_rcu()

include/linux/rcupdate.h   |  53 ++++++-
include/linux/rcutiny.h    |   6 +-
include/linux/rcutree.h    |   2 +-
include/trace/events/rcu.h |   8 +-
kernel/rcu/tiny.c          | 168 +++++++++++++++++++-
kernel/rcu/tree.c          | 315 ++++++++++++++++++++++++++-----------
mm/list_lru.c              |  11 +-
7 files changed, 443 insertions(+), 120 deletions(-)

--
2.26.0.rc2.310.g2932bb562d-goog

