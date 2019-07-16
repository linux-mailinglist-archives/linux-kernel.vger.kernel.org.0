Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E56ABB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 17:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbfGPP1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 11:27:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39366 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfGPP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 11:27:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so5295917pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxedKsOlRoMuH0YAi3w5n8XgUhrmrip/11U2C/L62+s=;
        b=ZZcN5b+L7iWZo3iArIcmAzXPEGsGU2NeexpNaf6SNsgDDLXVphrRU+sEQ/hrnLmpHJ
         8xzFTZLinKyISv9p9ErZE3Rpojfjh4dJRIelGwba8icXvxJuBnCo/uVUVCOp0JOWEnw3
         fpn/IitK8VLeIrMfR/WNCF4sRuf9xqZGibk1xdzmDjl6X6/Nzp/m9GYv5ocHES1YT9cM
         8jX7ZPtCUIg4kAocab0gZTzzbVghHoApiZU6YzVtvvDUrnqV4CjJrnuf1Q6gBGHlKEp8
         v2pI43Vtkp2slOxzSVSRCwd94hwjb22RBp8pJHGbvN5pHST/X8YUNxvpEIAlNjWh1hND
         a2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxedKsOlRoMuH0YAi3w5n8XgUhrmrip/11U2C/L62+s=;
        b=lKPsr/N6f0zLpwdGBmKNOuasKLWgcJXYCuPb3l45YYEiuUeSWvtYlOkGUQDgtdG1Mx
         x/NIUaPYDo9Cc8tfigmesDLzVHgUtuu0VGH+SH3xBrKS26tR/Vu5RtZj90WzEOzyzkT/
         pHMYoh2WW+LN0fBTTqKL4mDeqaSPxvOP3OjcMveTRxQuqpd7DlwByTLfwHlGLbkOTHHT
         8JL16zzeiIc8wauOx8fSVRTrRAhpQSo5xNXihe6JtJ3X2z2irrhUrhMql54gLRmePfBE
         rCBW61mkM2tjk2MA8QXHV2VghjFwCmNVRBPHwfPdTp1C+SyP/GGKrt5z2tD0s18fraNG
         McHQ==
X-Gm-Message-State: APjAAAX9moFS0fqdUDdyMkNBCo4myby787/fCjiQz6nL/WRTbgCtAdiK
        UY6kiWZukYLrThJZp4tIU9Q=
X-Google-Smtp-Source: APXvYqweQYeGtHEfqywtbTQqGntIQfKXECduapNMxbzT+2waGPhyg1ck1l+5eDii4IS1zlf522DXDw==
X-Received: by 2002:a17:90a:37ac:: with SMTP id v41mr35699482pjb.6.1563290836876;
        Tue, 16 Jul 2019 08:27:16 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:bf0:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id h9sm27453651pgk.10.2019.07.16.08.27.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 08:27:16 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     urezki@gmail.com, rpenyaev@suse.de, peterz@infradead.org,
        guro@fb.com, rick.p.edgecombe@intel.com, rppt@linux.ibm.com,
        aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v6 0/2] mm/vmalloc.c: improve readability and rewrite vmap_area
Date:   Tue, 16 Jul 2019 23:26:54 +0800
Message-Id: <20190716152656.12255-1-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5 -> v6
* patch 2: keep the comment in s_show()

v4 -> v5
* Base on next-20190716
* patch 1: From Uladzislau Rezki (Sony) <urezki@gmail.com> (author)
  - https://lkml.org/lkml/2019/7/16/276
* patch 2: Use v3

v3 -> v4:
* Base on next-20190711
* patch 1: From: Uladzislau Rezki (Sony) <urezki@gmail.com> (author)
  - https://lkml.org/lkml/2019/7/3/661
* patch 2: Modify the layout of struct vmap_area for readability

v2 -> v3:
* patch 1-4: Abandoned
* patch 5:
  - Eliminate "flags" (suggested by Uladzislau Rezki)
  - Base on https://lkml.org/lkml/2019/6/6/455
    and https://lkml.org/lkml/2019/7/3/661

v1 -> v2:
* patch 3: Rename __find_vmap_area to __search_va_in_busy_tree
           instead of __search_va_from_busy_tree.
* patch 5: Add motivation and necessary test data to the commit
           message.
* patch 5: Let va->flags use only some low bits of va_start
           instead of completely overwriting va_start.

The current implementation of struct vmap_area wasted space.

After applying this commit, sizeof(struct vmap_area) has been
reduced from 11 words to 8 words.

Pengfei Li (1):
  mm/vmalloc: modify struct vmap_area to reduce its size

Uladzislau Rezki (Sony) (1):
  mm/vmalloc: do not keep unpurged areas in the busy tree

 include/linux/vmalloc.h | 20 +++++++----
 mm/vmalloc.c            | 76 +++++++++++++++++++++++++++++------------
 2 files changed, 67 insertions(+), 29 deletions(-)

-- 
2.21.0

