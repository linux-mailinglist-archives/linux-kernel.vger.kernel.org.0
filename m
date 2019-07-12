Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0088266A12
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfGLJiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 05:38:16 -0400
Received: from ozlabs.ru ([107.173.13.209]:58430 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfGLJiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:38:16 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jul 2019 05:38:15 EDT
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 90D15AE80571;
        Fri, 12 Jul 2019 05:29:58 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linux-kernel@vger.kernel.org
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Alistair Popple <alistair@popple.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH kernel v4 0/4] powerpc/ioda2: Yet another attempt to allow DMA masks between 32 and 59
Date:   Fri, 12 Jul 2019 19:29:51 +1000
Message-Id: <20190712092955.56218-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to allow DMA masks between 32..59 which are not large
enough to use either a PHB3 bypass mode or a sketchy bypass. Depending
on the max order, up to 40 is usually available.


This is based on sha1
a2b6f26c264e Christophe Leroy "powerpc/module64: Use symbolic instructions names.".

Please comment. Thanks.



Alexey Kardashevskiy (4):
  powerpc/powernv/ioda: Fix race in TCE level allocation
  powerpc/iommu: Allow bypass-only for DMA
  powerpc/powernv/ioda2: Allocate TCE table levels on demand for default
    DMA window
  powerpc/powernv/ioda2: Create bigger default window with 64k IOMMU
    pages

 arch/powerpc/include/asm/iommu.h              |  8 +-
 arch/powerpc/platforms/powernv/pci.h          |  2 +-
 arch/powerpc/kernel/dma-iommu.c               | 11 ++-
 arch/powerpc/kernel/iommu.c                   | 74 +++++++++++++------
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 38 ++++++----
 arch/powerpc/platforms/powernv/pci-ioda.c     | 40 ++++++++--
 6 files changed, 121 insertions(+), 52 deletions(-)

-- 
2.17.1

