Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC8DE58C3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 07:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfJZFa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 01:30:29 -0400
Received: from verein.lst.de ([213.95.11.211]:54239 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfJZFa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 01:30:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CC4B68B05; Sat, 26 Oct 2019 07:30:26 +0200 (CEST)
Date:   Sat, 26 Oct 2019 07:30:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        joro@8bytes.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, will@kernel.org, pratikp@codeaurora.org,
        lmark@codeaurora.org
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
Message-ID: <20191026053026.GA14545@lst.de>
References: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition makes very little sense.  Any without a user in the
same series it is a complete no-go anyway.
