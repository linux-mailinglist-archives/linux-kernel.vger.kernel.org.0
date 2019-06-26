Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C074556BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 16:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfFZO1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 10:27:54 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:40862 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZO1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:27:54 -0400
Received: by mail-qk1-f201.google.com with SMTP id c1so2761266qkl.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r4ItmzOajsz46SiEckz8j+X5GgZKewiKuJJu0la+VeE=;
        b=Obt/qbqCs/bsHGPLzrNGMBKdEVVjbJIIBymqIDhJeO1ke0sGLX/925KyG2CxVcciHo
         5uEUeJJRXcGvNUoB2idEYM2BOk9ugowXvoP4Nu/4ySo7CByG0YDh1DQtB3Anx71bi3Zq
         xXWdUKPuJ620a7XPTZxFzOBN8B6Qzr8Hej2qFEE90En3bjM96NRZY6es1n/HnIHtnouh
         zcVOwNBXhEi2oklJO7kGV2MJ83wm0KHwOaPSnkztN/1M30iNj7hOpa+5eagHwfzxRvDQ
         dFzVHe8QVvyBrwypZO7fGM3vGURartVLGtOVDhDbfTKdKpqQlTdlZtpaAN2K6EBWE+nI
         jDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r4ItmzOajsz46SiEckz8j+X5GgZKewiKuJJu0la+VeE=;
        b=fTitGEjulwtfbjm8poAc/gEUGxXuzJ+O+pcKnOsBKa6w5hnae+A60Lz4mEi0zz1HM+
         /pGwX13dLwqrNaVTNI6eYARavPyjRh6w6R4ccJyE2hkXVMv23cXUIdrrb9gfDbANGqFD
         sIKuCsxTDoTcLVSvgiRZu7W6qXCneS8EdyX8klfNbZmkiDdWxxqgs5EdQ7KHVsy/mFkR
         R/ieelGJXNa8eDvC54iMK6sfPjCu3SxWPiPtrkxnl/PzanfWvHn3TwcuBvZPWQhiiH5J
         jKyVOiMFposD2cYYjT5wj5vsLPgY291ycZlqhnUOSK+C4GhSP5wJ0eDMnpR994Vvnx6j
         m2uQ==
X-Gm-Message-State: APjAAAUQV2OHBqr8hx9s5cCUpJGzVOPsCW/lsB9q4E3NcFQeibh0XUYe
        bAx259ZKUwvVtGLpKrZ+XpCKjpSYrg==
X-Google-Smtp-Source: APXvYqzr74PSeU2y6FOA03uUNS0dApgjOP/jRZUTpufkeZ++4HYMPmrj9Hcs4rnDGQJZ9/uHvmMAxYzh+w==
X-Received: by 2002:ac8:29c9:: with SMTP id 9mr4065369qtt.196.1561559273101;
 Wed, 26 Jun 2019 07:27:53 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:20:09 +0200
Message-Id: <20190626142014.141844-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 0/5] mm/kasan: Add object validation in ksize()
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version addresses formatting in kasan-checks.h and splits
introduction of __kasan_check and returning boolean into 2 patches.

Previous version:
http://lkml.kernel.org/r/20190626122018.171606-1-elver@google.com

Marco Elver (5):
  mm/kasan: Introduce __kasan_check_{read,write}
  mm/kasan: Change kasan_check_{read,write} to return boolean
  lib/test_kasan: Add test for double-kzfree detection
  mm/slab: Refactor common ksize KASAN logic into slab_common.c
  mm/kasan: Add object validation in ksize()

 include/linux/kasan-checks.h | 47 ++++++++++++++++++++++++++++++------
 include/linux/kasan.h        |  7 ++++--
 include/linux/slab.h         |  1 +
 lib/test_kasan.c             | 17 +++++++++++++
 mm/kasan/common.c            | 14 +++++------
 mm/kasan/generic.c           | 13 +++++-----
 mm/kasan/kasan.h             | 10 +++++++-
 mm/kasan/tags.c              | 12 +++++----
 mm/slab.c                    | 28 +++++----------------
 mm/slab_common.c             | 45 ++++++++++++++++++++++++++++++++++
 mm/slob.c                    |  4 +--
 mm/slub.c                    | 14 ++---------
 12 files changed, 147 insertions(+), 65 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

