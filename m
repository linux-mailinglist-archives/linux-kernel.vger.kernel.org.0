Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D9C90BD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 20:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfJBSXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 14:23:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35622 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfJBSXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:23:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so10909180pfw.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LeMz4C7dT0FzcwRqNC1m/9wgqjTMC7TmzNEWTD1jfe8=;
        b=yZuZNwU1Or5FVFpnm3rvPr6m2yw5OShjzOQomikgnNau24dgAB6sTtH4aUi7QS2Ogf
         Y8mooeE2eSY0D1fR26Z90RuqERzp46LzSIuRUOUENo42IMx5fGXwYbtQ2QpltO2FzVXx
         oHJgItEY0BRuxwVNj+ExfKMGsKIfvwUcWqc+KPQK9wtZVFSkLnfRR0e6l8CtJVh1iRDh
         ZbS5vmtuoHYN+J5X+qhSSOVzTa6grE1dDlihf+J6TI4yB4ULSs3bUHU6z9kysBxQdWMu
         4NNty/sfPf9ZQZp69uS6dmTzLQwyrDOkHWpDkmgxAYZMk7thg7sWniWbKP3x5Z5R8kQi
         Wf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LeMz4C7dT0FzcwRqNC1m/9wgqjTMC7TmzNEWTD1jfe8=;
        b=rL+H7oxuEuxTy6+tbBRaFCgrB9X/FnvJARingQ4ym7ngHCdagHQ/LxkERwDVi5nAvf
         KgnejvMF0kgZJPcmYTK1IoBtOLcZbGuA7Fo5qCkkuJfT5EkremNiR0z7W6Ap+okzVffC
         cIBsn2+zRSyWfRDpq8UNW0SyPec1JIIktbWWzYhr/wV7HSFGlyTbGkRr98zPUUhi5RwS
         faHeMxHPavfEBHD1W5cn+o5vraP/vGmwrcrI30UCEfn9MvaErNLPewsub16epY2eMB/F
         lLWd3d3ZQHcquiVVGHFB+7GuV380luKjuZtXi5EjjzhXbftWmLTu6a0fdna6ScZV7bu+
         UPwA==
X-Gm-Message-State: APjAAAUr2KkQMDZ7IsBrZJKym7W6T7+Z11yKdFXr5GSl5fZVDzrCAyD+
        rJQm8fMc15TJLZb03YXOvvjlxhJLwfA=
X-Google-Smtp-Source: APXvYqxynvK0ZEj9IPwHaLbnXMAtSrlJJVuvwJ+TPBsbwOVAwDgxvOrrbOZpfQjUUShTKSwcjfoYqQ==
X-Received: by 2002:a63:6b49:: with SMTP id g70mr5005563pgc.92.1570040579862;
        Wed, 02 Oct 2019 11:22:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q132sm171102pfq.16.2019.10.02.11.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 11:22:59 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v9 0/5] DMA-BUF Heaps (destaging ION)
Date:   Wed,  2 Oct 2019 18:22:50 +0000
Message-Id: <20191002182255.21808-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is yet another pass at the dma-buf heaps patchset Andrew
and I have been working on which tries to destage a fair chunk
of ION functionality.

The patchset implements per-heap devices which can be opened
directly and then an ioctl is used to allocate a dmabuf from the
heap.

The interface is similar, but much simpler then IONs, only
providing an ALLOC ioctl.

Also, I've provided relatively simple system and cma heaps.

I've booted and tested these patches with AOSP on the HiKey960
using the kernel tree here:
  https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap

And the userspace changes here:
  https://android-review.googlesource.com/c/device/linaro/hikey/+/909436

Compared to ION, this patchset is missing the system-contig,
carveout and chunk heaps, as I don't have a device that uses
those, so I'm unable to do much useful validation there.
Additionally we have no upstream users of chunk or carveout,
and the system-contig has been deprecated in the common/andoid-*
kernels, so this should be ok.

I've also removed the stats accounting, since any such accounting
should be implemented by dma-buf core or the heaps themselves.

New in v9:
* Removing needless check in cma heap (noted by Brian Starkey)
* Rename dma_heap_get_data->dma_heap_get_drvdata (suggested by
  Hilf Danton)
* Check signals after clearing memory pages to avoid doing
  needless work if the task is killed (suggested by Hilf)
* Better test error reporting (suggested d by Brian)
* Other minor cleanups (suggested by Brian)

Thoughts and feedback would be greatly appreciated!

thanks
-john

Cc: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc: Sudipto Paul <Sudipto.Paul@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: dri-devel@lists.freedesktop.org

Andrew F. Davis (1):
  dma-buf: Add dma-buf heaps framework

John Stultz (4):
  dma-buf: heaps: Add heap helpers
  dma-buf: heaps: Add system heap to dmabuf heaps
  dma-buf: heaps: Add CMA heap to dmabuf heaps
  kselftests: Add dma-heap test

 MAINTAINERS                                   |  18 ++
 drivers/dma-buf/Kconfig                       |  11 +
 drivers/dma-buf/Makefile                      |   2 +
 drivers/dma-buf/dma-heap.c                    | 250 ++++++++++++++++
 drivers/dma-buf/heaps/Kconfig                 |  14 +
 drivers/dma-buf/heaps/Makefile                |   4 +
 drivers/dma-buf/heaps/cma_heap.c              | 169 +++++++++++
 drivers/dma-buf/heaps/heap-helpers.c          | 266 ++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h          |  55 ++++
 drivers/dma-buf/heaps/system_heap.c           | 122 ++++++++
 include/linux/dma-heap.h                      |  59 ++++
 include/uapi/linux/dma-heap.h                 |  55 ++++
 tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 238 ++++++++++++++++
 14 files changed, 1272 insertions(+)
 create mode 100644 drivers/dma-buf/dma-heap.c
 create mode 100644 drivers/dma-buf/heaps/Kconfig
 create mode 100644 drivers/dma-buf/heaps/Makefile
 create mode 100644 drivers/dma-buf/heaps/cma_heap.c
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
 create mode 100644 drivers/dma-buf/heaps/system_heap.c
 create mode 100644 include/linux/dma-heap.h
 create mode 100644 include/uapi/linux/dma-heap.h
 create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
 create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c

-- 
2.17.1

