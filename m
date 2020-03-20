Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5918CFDC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 15:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgCTOTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 10:19:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56638 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTOTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fP76rVZ78wXp8cMUTCCjVQv5iPeDciWQiuxMnftZdbU=; b=B6/zKn9hIGXiUR1+IFAOol+kv1
        XjmHCPdWqbtmD9fPyqucY8V+g+o9OLOvI3t+vrDdb/DQOqyScEnQli0GsUE5QpHE3YjdPBKaRCK68
        rQSN6kmN+N0Smxlwq+SoFYRFj3SxRcSTi1Yh+KaTdPyhzA+m1CzeAqONaNmB+4ZAaLWxYwgTBl+jb
        ILStHKt07ubvKmWQ63yuEZKU86Ihy8RxKbgZoXwxkIDn8QKjcBqMVb/ZK6RXAsYaxHRY42JJ2qj0L
        6LlhF9zgzO3uCzN93uOom5TnQF6sMVJq6DscqerEEnHaIo7nFdfFl+Nips+DMKRf9Hob7GPC7Kewo
        JcfqGpuA==;
Received: from 089144202225.atnat0011.highway.a1.net ([89.144.202.225] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFIUF-0007Ej-D6; Fri, 20 Mar 2020 14:18:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: generic DMA bypass flag v2
Date:   Fri, 20 Mar 2020 15:16:38 +0100
Message-Id: <20200320141640.366360-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've recently beeing chatting with Lu about using dma-iommu and
per-device DMA ops in the intel IOMMU driver, and one missing feature
in dma-iommu is a bypass mode where the direct mapping is used even
when an iommu is attached to improve performance.  The powerpc
code already has a similar mode, so I'd like to move it to the core
DMA mapping code.  As part of that I noticed that the current
powerpc code has a little bug in that it used the wrong check in the
dma_sync_* routines to see if the direct mapping code is used.

These two patches just add the generic code and move powerpc over,
the intel IOMMU bits will require a separate discussion.

The x86 AMD Gart code also has a bypass mode, but it is a lot
strange, so I'm not going to touch it for now.

Changes since v1:
 - rebased to the current dma-mapping-for-next tree
