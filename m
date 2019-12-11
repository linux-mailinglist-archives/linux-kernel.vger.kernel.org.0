Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B4911BF3D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 22:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfLKVcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 16:32:21 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41544 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLKVcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:32:20 -0500
Received: by mail-pg1-f202.google.com with SMTP id r30so110662pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 13:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yOD0iLUDW76bcZvomrsQRH0nGqn37n8IrqSYFpzYwxo=;
        b=SkYtkuEt3uhSk0GqlAk4oucYFWLKir9gozR06v9/suCWs/JVSDqytCQWQ9LgaAQ2na
         PmOF+bMFyZX6yDg3n+Y3lq9ka6vzus1Yx1drthis6lI3K3+dNDjwq8TzRTCIy1BhVIIE
         8YyFCJU6quwTTAiMFY22MftPutzvhLyK65b5i18KFpIC0t8RK3OHJqcX/1Q1U0dLdMk+
         b/qD97l+2JOZReqFN252Il/j1KHxrLlQRWYJ7YefFfcWqCeAnQlW2oxdi/bAsI+HS93n
         o7eHSkSdR5VZMpEmI6I80LN1+CMxsTLZDVS0IUoIUejO9uJ/AKOE54dkjVuXyEUIAhas
         tn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yOD0iLUDW76bcZvomrsQRH0nGqn37n8IrqSYFpzYwxo=;
        b=SW+Eah/xPCT/U+0bBogUa/+JZDM+IJNVhULmmE9g/UxjwC7iKEZ7dZpXjZ6ZrMN0JP
         Y81oOKxqK48pSkdonlowCZVnrewrtvLoYFpuMVcx9SObvMBTZ9l6V5FGa0BEj6bn8Cob
         y9SdNVETCvSeAHqrcGDqTeFODLdQMuCR2S/DbeOCY5fXOWU+Sf9Ya+hm93AkS5bEvOk8
         NTqCyFdb70GJfH3d+hpTbcCvhnIp4FOrW1TFO939OrYuw1Fje97HhJOtJCQ38PvjVuo1
         Ph5nPfxGPraukiIfLcCiEUH7XNOh1RI6NlvWmrIeqU+H5Zj8ct/Nk7RTmAX/kOl18UMm
         xM3w==
X-Gm-Message-State: APjAAAUG/mg0moLu9ivzOWVDZ9V/i/xH1MV+vM4SaefI4to6DYnKxNGo
        xyGNJtyxHiwpBK4o5SJuGVMC0NMs
X-Google-Smtp-Source: APXvYqwxN+9vk9zS22b7QST6+pxb5MgdnMTh4p7n/rktgqkeQdSuCaW1zb//I1NE9J50Us45XT1y4SFl
X-Received: by 2002:a63:ec0a:: with SMTP id j10mr6589163pgh.178.1576099940106;
 Wed, 11 Dec 2019 13:32:20 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:32:05 -0500
Message-Id: <20191211213207.215936-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v4 0/2] kvm: Use huge pages for DAX-backed files
From:   Barret Rhoden <brho@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jason.zeng@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset allows KVM to map huge pages for DAX-backed files.

I held previous versions in limbo while people were sorting out whether
or not DAX pages were going to remain PageReserved and how that relates
to KVM.

Now that that is sorted out (DAX pages are PageReserved, but they are
not kvm_is_reserved_pfn(), and DAX pages are considered on a
case-by-case basis for KVM), I can repost this.

v3 -> v4:
v3: https://lore.kernel.org/lkml/20190404202345.133553-1-brho@google.com/
- Rebased onto linus/master

v2 -> v3:
v2: https://lore.kernel.org/lkml/20181114215155.259978-1-brho@google.com/
- Updated Acks/Reviewed-by
- Rebased onto linux-next

v1 -> v2:
https://lore.kernel.org/lkml/20181109203921.178363-1-brho@google.com/
- Updated Acks/Reviewed-by
- Minor touchups
- Added patch to remove redundant PageReserved() check
- Rebased onto linux-next

RFC/discussion thread:
https://lore.kernel.org/lkml/20181029210716.212159-1-brho@google.com/

Barret Rhoden (2):
  mm: make dev_pagemap_mapping_shift() externally visible
  kvm: Use huge pages for DAX-backed files

 arch/x86/kvm/mmu/mmu.c | 36 ++++++++++++++++++++++++++++++++----
 include/linux/mm.h     |  3 +++
 mm/memory-failure.c    | 38 +++-----------------------------------
 mm/util.c              | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 39 deletions(-)

-- 
2.24.0.525.g8f36a354ae-goog

