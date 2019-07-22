Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B007702B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 16:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfGVOzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 10:55:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfGVOzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:55:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C8DD5C057F2C;
        Mon, 22 Jul 2019 14:55:18 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-45.ams2.redhat.com [10.36.116.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6CAA60A9F;
        Mon, 22 Jul 2019 14:55:11 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix NULL pointer dereference with virtio-blk-pci and virtual IOMMU
Date:   Mon, 22 Jul 2019 16:55:07 +0200
Message-Id: <20190722145509.1284-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 22 Jul 2019 14:55:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running a guest featuring a virtio-blk-pci protected with a virtual
IOMMU we hit a NULL pointer dereference.

This series removes the dma_max_mapping_size() call in
virtio_max_dma_size when the device does not have any dma_mask set.
A check is also added to early return in dma_addressing_limited()
if the dma_mask is NULL.

Eric Auger (2):
  dma-mapping: Protect dma_addressing_limited against NULL dma_mask
  virtio/virtio_ring: Fix the dma_max_mapping_size call

 drivers/virtio/virtio_ring.c | 2 +-
 include/linux/dma-mapping.h  | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.20.1

