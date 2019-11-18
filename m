Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84800100D04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 21:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKRUXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 15:23:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37912 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfKRUXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:23:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id c13so10926494pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 12:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XAQisB4dl7aAbIG9o/3Fhs9EnGFzGUZ+Rh3JFJPeyUo=;
        b=fnKkNnpKHlNbmv516hbcaEVWV22ATAFpClGc5Mdu+VVOigCtBLxcu6J5CNtzvEghSM
         POZZtYYNU5wABbzevm8CUIdywLovEthS4H95eRLUYEFNQ4gJwmyX/G8C+t4QtRwkh4Ko
         EE5RcRpBRcAFa9w+g/xgOr8zRRPVCaus9YPRdsbxtTBFPhlzUHyqImODxk7ySg3BqoIx
         Wz1uMJ7Vc1ySCOJZKskur+Uyp+wEz2sUjacf/Tq7j7JGZpHlEwcZ7OLvWa1F78LEgnms
         LiVhHaw11wI9VHIZSqGjTiKlRIExquPZVj0X2xCSAIQNk4l22x+k8LJM310TV2eg56oc
         b7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XAQisB4dl7aAbIG9o/3Fhs9EnGFzGUZ+Rh3JFJPeyUo=;
        b=n9NAj+bKqrxWm1gDvwTAUGaO+Ctesg1r5AF7H7WBN9SQjTzMpXBnyWq7q6fLzoVxKG
         fWvzoKeboO6012OifEHaDk4YYQtxj8IQ/RH+KvliF0Lni2xXi+svouZQUgkn9K9rZ+bH
         nPGbT0Op7+eC2GKSHvDn8PqYzRElwDPYVlDo09FDPFXnWUa4NM00If5BaWfM5IRTLnup
         pbPkF60MQjpb5IolXJlkf438yZbkmZzge06mVeDStL0n+3ZTRD7CJI6/kkKVdbR2leoE
         m4Y4FzTw5H2UrRhiIpzJm/hycFC4lUAI6M0HEqZOMhqd3vuqQKEfvPrrktjZ9LT5nPj4
         tnbA==
X-Gm-Message-State: APjAAAXyFfVofj0adXqOaf6bXuRutA/U9GU2d8c+DF6G8w+ry6akiyDz
        oG5f4Ad1/bKWMi+d0rjS9pNTnY6vJ2I=
X-Google-Smtp-Source: APXvYqzszKweGiIVWPVEYmvVa4MfrnoT/NXciccAdxnbe9x2+dCK8nky7DqCpR/Q+xoBIN4KAiMfzQ==
X-Received: by 2002:a63:5246:: with SMTP id s6mr1260904pgl.349.1574108615429;
        Mon, 18 Nov 2019 12:23:35 -0800 (PST)
Received: from localhost.localdomain (c-67-170-172-113.hsd1.or.comcast.net. [67.170.172.113])
        by smtp.gmail.com with ESMTPSA id 7sm11021871pgk.25.2019.11.18.12.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:23:34 -0800 (PST)
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
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v16 0/5] DMA-BUF Heaps (destaging ION)
Date:   Mon, 18 Nov 2019 20:23:27 +0000
Message-Id: <20191118202332.109172-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just wanted to resend v16 with a few minor changes.

This patchset implements per-heap devices which can be opened
directly and then an ioctl is used to allocate a dmabuf from the
heap.

The interface is similar, but much simpler then IONs, only
providing an ALLOC ioctl.

Also, I've provided relatively simple system and cma heaps.

I've booted and tested these patches with AOSP on the HiKey960
using the kernel tree here:
  https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap

And the reviewed (+2'ed) userspace changes here:
  https://android-review.googlesource.com/c/device/linaro/hikey/+/909436

Compared to ION, this patchset is missing the system-contig,
carveout and chunk heaps, as I don't have a device that uses
those, so I'm unable to do much useful validation there.
Additionally we have no upstream users of chunk or carveout,
and the system-contig has been deprecated in the common/andoid-*
kernels, so this should be ok.

I've also removed the stats accounting, since any such
accounting should be implemented by dma-buf core or the heaps
themselves.

New in v16:
* Typo fix suggested by Hridya Valsaraju <hridya@google.com>
* Add extra error and ioctl compatibility testing suggested by
  Daniel Vetter to the kselftest test

Thanks again for all the reviews and feedback!
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
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org

Andrew F. Davis (1):
  dma-buf: Add dma-buf heaps framework

John Stultz (4):
  dma-buf: heaps: Add heap helpers
  dma-buf: heaps: Add system heap to dmabuf heaps
  dma-buf: heaps: Add CMA heap to dmabuf heaps
  kselftests: Add dma-heap test

 MAINTAINERS                                   |  18 +
 drivers/dma-buf/Kconfig                       |  11 +
 drivers/dma-buf/Makefile                      |   2 +
 drivers/dma-buf/dma-heap.c                    | 297 +++++++++++++
 drivers/dma-buf/heaps/Kconfig                 |  14 +
 drivers/dma-buf/heaps/Makefile                |   4 +
 drivers/dma-buf/heaps/cma_heap.c              | 177 ++++++++
 drivers/dma-buf/heaps/heap-helpers.c          | 271 ++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h          |  53 +++
 drivers/dma-buf/heaps/system_heap.c           | 123 ++++++
 include/linux/dma-heap.h                      |  59 +++
 include/uapi/linux/dma-heap.h                 |  53 +++
 tools/testing/selftests/dmabuf-heaps/Makefile |   6 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 396 ++++++++++++++++++
 14 files changed, 1484 insertions(+)
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

