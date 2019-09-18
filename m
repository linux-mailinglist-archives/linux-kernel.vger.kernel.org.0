Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D17B63F3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 15:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfIRM7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 08:59:43 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:47316 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbfIRM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:59:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id CAF1E3F869;
        Wed, 18 Sep 2019 14:59:28 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=XVUzl5dD;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tHoB48kMniVl; Wed, 18 Sep 2019 14:59:25 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 8C7A03F85E;
        Wed, 18 Sep 2019 14:59:24 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id E06C236020A;
        Wed, 18 Sep 2019 14:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568811564; bh=nHZ5nrGPkMFImxWZGWHwng2aQcVr1Cjrduddths8zV8=;
        h=From:To:Cc:Subject:Date:From;
        b=XVUzl5dDcqXwgp/9N8S33Dj/Zw+iZxamTyBGTvfwNYoDtCBZxacLKdPszdMZ82MTr
         Zm5DSQSrR7Ma9rJip6E08bAy/6dQdW3WWRnNWh+mxC6yJUp0Eda44lBzFHJz9uED7k
         TUVSxGL6qZs601VCYABY16qidqUwAvUhH/PRoGNA=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 0/7] Emulated coherent graphics memory take 2
Date:   Wed, 18 Sep 2019 14:59:07 +0200
Message-Id: <20190918125914.38497-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellström <thellstrom@vmware.com>

Graphics APIs like OpenGL 4.4 and Vulkan require the graphics driver
to provide coherent graphics memory, meaning that the GPU sees any
content written to the coherent memory on the next GPU operation that
touches that memory, and the CPU sees any content written by the GPU
to that memory immediately after any fence object trailing the GPU
operation has signaled.

Paravirtual drivers that otherwise require explicit synchronization
needs to do this by hooking up dirty tracking to pagefault handlers
and buffer object validation.

The mm patch page walk interface has been reworked to be similar to the
reworked page-walk code (mm/pagewalk.c). There have been two other solutions
to consider:
1) Using the page-walk code. That is currently not possible since it requires
the mmap-sem to be held for the struct vm_area_struct vm_flags and for huge
page splitting. The pagewalk code in this patchset can't hold the mmap sems
since it will lead to locking inversion. We have an established locking order
mmap_sem -> dma_reservation -> i_mmap_lock, whereas holding the mmap_sem in
this case would require dma_reservation -> i_mmap_lock -> mmap_sem.
Instead it uses an operation mode similar to unmap_mapping_range() where the
i_mmap_lock is held.
2) Using apply_to_page_range(). The primary use of this code is to fill
page tables. The operation modes are IMO sufficiently different to motivate
re-implementing the page-walk.

For the TTM changes they are hopefully in line with the long-term
strategy of making helpers out of what's left of TTM.

The code has been tested and exercised by a tailored version of mesa
where we disable all explicit synchronization and assume graphics memory
is coherent. The performance loss varies of course; a typical number is
around 5%.

I would like to merge this code through the DRM tree, so an ack to include
the new mm helpers in that merge would be greatly appreciated.

Changes since RFC:
- Merge conflict changes moved to the correct patch. Fixes intra-patchset
  compile errors.
- Be more aggressive when turning ttm vm code into helpers. This makes sure
  we can use a const qualifier on the vmwgfx vm_ops.
- Reinstate a lost comment an fix an error path that was broken when turning
  the ttm vm code into helpers.
- Remove explicit type-casts of struct vm_area_struct::vm_private_data
- Clarify the locking inversion that makes us not being able to use the mm
  pagewalk code.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Christoph Hellwig <hch@infradead.org>
