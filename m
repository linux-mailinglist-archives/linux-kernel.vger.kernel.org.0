Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E3C166178
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 16:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgBTPyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 10:54:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29559 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728528AbgBTPyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582214043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bt1+d0titgQLhNFh5svjyDyx7KYPhkET1LH3nLMC49s=;
        b=UmW0izfZLbcjgiMDwbCgc/wK0VGH4myeTlJ67f6zzgcCg8E/Eh4KWdnGFjwYyRRcqiOBO6
        8MwxeWkSgQGHR1E3/Q4gTQtB3PeKoMohICIM+F/TIAUy42Oh9o63tdnaZPEcFiljhZkYLC
        ALfz0hl0Ilvfsd06mYcll5P7JH918AM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-oY2ZP7HiOgGwYA985LMV_g-1; Thu, 20 Feb 2020 10:53:57 -0500
X-MC-Unique: oY2ZP7HiOgGwYA985LMV_g-1
Received: by mail-qv1-f69.google.com with SMTP id v19so2818273qvk.16
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bt1+d0titgQLhNFh5svjyDyx7KYPhkET1LH3nLMC49s=;
        b=GZAn/IwHQbHQ9HJCCTUJ7iAaRkZjLE/9W57tQ7S2QYsMzJ2zxmL71KPj2RHu2jTBGq
         PmWHnsTHw3fczEtf8ZiWzFOIUJQush3Wk2e9mnX5Ta4+D+cWngWTp0yyDb+/5NaJaduO
         /8xwAAgo3atKnUlmVbnA4p2CI/WspAmNxn5HZSvu+qbV5ooXdLN+Fhaqp1/NHxtJH3Ww
         BgprewACFno+5bGHe1XGyQtDUkZ+JtwSqRFWEGYOuj49m6bMVkAqwUyfmUfiSAC3qkit
         qb6HyCVIlrvfgmW0Qlh6KkhBTE2vfGlvyC9CdVw5BoQ4VEJdYKAaBYW06Rhg3mj2aDG5
         P6SQ==
X-Gm-Message-State: APjAAAWEnaG8ZmqJhcoNZvO7DmODBqc283fOwYuNaz2x0mGtKLkjjRsg
        mH7dKgBsXJi3zyzXzd5iQ/pjmBd3gneRR1LIgo/2SaRi4TrUAEFQxdu7Pn/jt6NBEHD7IKQssjl
        44IZgt6UPgKKnXibQelfmVANg
X-Received: by 2002:a37:742:: with SMTP id 63mr28733637qkh.31.1582214036700;
        Thu, 20 Feb 2020 07:53:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9VCY2D+VSq59waXKZrbNuFOOodktVtmIMdjUJndOOkfNMPF5sQK84kzKhe5Pjf4jsVs0qLg==
X-Received: by 2002:a37:742:: with SMTP id 63mr28733594qkh.31.1582214036304;
        Thu, 20 Feb 2020 07:53:56 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id h20sm1807430qkk.64.2020.02.20.07.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:53:55 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Martin Cracauer <cracauer@cons.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>, peterx@redhat.com,
        Hugh Dickins <hughd@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: [PATCH RESEND v6 00/16] mm: Page fault enhancements
Date:   Thu, 20 Feb 2020 10:53:37 -0500
Message-Id: <20200220155353.8676-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend v6]

This is v6 of the series.  It is majorly a rebase to 5.6-rc2, nothing
else to be expected (plus some tests after the rebase).  Instead of
rewrite the cover letter I decided to use what we have for v5.

Adding extra CCs for both Bobby Powers <bobbypowers@gmail.com> and
Brian Geffon <bgeffon@google.com>.

Online repo: https://github.com/xzpeter/linux/tree/mm-pf-signal-retry

Any review comment is appreciated.  Thanks,

=============== v5 cover letter ==================

This is v5 of the series.  As Matthew suggested, I split the previous
patch "mm: Return faster for non-fatal signals in user mode faults"
into a few smaller ones:

  1. One patch to introduce fatal_signal_pending(), and use it in
     archs that can directly apply

  2. A few more patches to let the rest archs to use the new helper.
     With that we can have an unified entry for signal detection

  3. One last patch to change fatal_signal_pending() to detect
     userspace non-fatal signal

Nothing should have changed in the rest patches.  Because the fault
retry patches will depend on the previous ones, I decided to simply
repost all the patches.

Here's the new patchset layout:

Patch 1-2:      cleanup, and potential bugfix of hugetlbfs on fault retry

Patch 3-9:      let page fault to respond to non-fatal signals faster

Patch 10:       remove the userfaultfd NOPAGE emulation

Patch 11-14:    allow page fault to retry more than once

Patch 15-16:    let gup code to use FAULT_FLAG_KILLABLE too

I would really appreciate any review comments for the series,
especially for the first two patches which IMHO are even not related
to this patchset and they should either cleanup or fix things.

Smoke tested on x86 only.

Thanks,

v5:
- split "mm: Return faster for non-fatal signals in user mode faults"
  into a few more patches, let all archs to use an unified entry for
  fast signal handling (fatal_signal_pending)

v4:
- use lore.kernel.org for all the links in commit messages [Kirill]
- one more patch ("mm/gup: Fix __get_user_pages() on fault retry of
  hugetlb") to fix hugetlb path on fault retry
- one more patch ("mm/gup: Allow to react to fatal signals") to:
  - use down_read_killable() properly [Linus]
  - pass in FAULT_FLAG_KILLABLE for all GUP [Linus]
- one more patch ("mm/userfaultfd: Honor FAULT_FLAG_KILLABLE in fault
  path") to let handle_userfaultfd() respect FAULT_FLAG_KILLABLE.
  Should have no functional change after previous two new patches.

v3:
- check fatal signals in __get_user_page_locked() [Linus]
- add r-bs

v2:
- resent previous version, rebase only

=============== v1 cover letter ==================

This series is split out of userfaultfd-wp series to only cover the
general page fault changes, since it seems to make sense itself.

Basically it does two things:

  (a) Allows the page fault handlers to be more interactive on not
      only SIGKILL, but also the rest of userspace signals (especially
      for user-mode faults), and,

  (b) Allows the page fault retry (VM_FAULT_RETRY) to happen for more
      than once.

I'm keeping the CC list as in uffd-wp v5, hopefully I'm not sending
too much spams...

And, instead of writting again the cover letter, I'm just copy-pasting
my previous link here which has more details on why we do this:

  https://patchwork.kernel.org/cover/10691991/

The major change from that latest version should be that we introduced
a new page fault flag FAULT_FLAG_INTERRUPTIBLE as suggested by Linus
[1] to represents that we would like the fault handler to respond to
non-fatal signals.  Also, we're more careful now on when to do the
immediate return of the page fault for such signals.  For example, now
we'll only check against signal_pending() for user-mode page faults
and we keep the kernel-mode page fault patch untouched for it.  More
information can be found in separate patches.

The patchset is only lightly tested on x86.

All comments are greatly welcomed.  Thanks,

[1] https://lkml.org/lkml/2019/6/25/1382

Peter Xu (16):
  mm/gup: Rename "nonblocking" to "locked" where proper
  mm/gup: Fix __get_user_pages() on fault retry of hugetlb
  mm: Introduce fault_signal_pending()
  x86/mm: Use helper fault_signal_pending()
  arc/mm: Use helper fault_signal_pending()
  arm64/mm: Use helper fault_signal_pending()
  powerpc/mm: Use helper fault_signal_pending()
  sh/mm: Use helper fault_signal_pending()
  mm: Return faster for non-fatal signals in user mode faults
  userfaultfd: Don't retake mmap_sem to emulate NOPAGE
  mm: Introduce FAULT_FLAG_DEFAULT
  mm: Introduce FAULT_FLAG_INTERRUPTIBLE
  mm: Allow VM_FAULT_RETRY for multiple times
  mm/gup: Allow VM_FAULT_RETRY for multiple times
  mm/gup: Allow to react to fatal signals
  mm/userfaultfd: Honor FAULT_FLAG_KILLABLE in fault path

 arch/alpha/mm/fault.c           |  6 +--
 arch/arc/mm/fault.c             | 35 +++++--------
 arch/arm/mm/fault.c             |  7 +--
 arch/arm64/mm/fault.c           | 26 +++------
 arch/hexagon/mm/vm_fault.c      |  5 +-
 arch/ia64/mm/fault.c            |  5 +-
 arch/m68k/mm/fault.c            |  7 +--
 arch/microblaze/mm/fault.c      |  5 +-
 arch/mips/mm/fault.c            |  5 +-
 arch/nds32/mm/fault.c           |  5 +-
 arch/nios2/mm/fault.c           |  7 +--
 arch/openrisc/mm/fault.c        |  5 +-
 arch/parisc/mm/fault.c          |  8 ++-
 arch/powerpc/mm/fault.c         | 20 ++-----
 arch/riscv/mm/fault.c           |  9 +---
 arch/s390/mm/fault.c            | 10 ++--
 arch/sh/mm/fault.c              | 13 +++--
 arch/sparc/mm/fault_32.c        |  5 +-
 arch/sparc/mm/fault_64.c        |  5 +-
 arch/um/kernel/trap.c           |  3 +-
 arch/unicore32/mm/fault.c       |  8 ++-
 arch/x86/mm/fault.c             | 30 +++++------
 arch/xtensa/mm/fault.c          |  5 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 12 +++--
 fs/userfaultfd.c                | 62 ++++++++++------------
 include/linux/mm.h              | 81 ++++++++++++++++++++++++----
 include/linux/sched/signal.h    | 14 +++++
 mm/filemap.c                    |  2 +-
 mm/gup.c                        | 93 +++++++++++++++++++++------------
 mm/hugetlb.c                    | 17 +++---
 mm/internal.h                   |  6 +--
 31 files changed, 281 insertions(+), 240 deletions(-)

-- 
2.24.1

