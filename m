Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A036A2DC86
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 14:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfE2MPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 08:15:15 -0400
Received: from verein.lst.de ([213.95.11.211]:54383 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfE2MPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:15:14 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A963A68B05; Wed, 29 May 2019 14:14:48 +0200 (CEST)
Date:   Wed, 29 May 2019 14:14:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] iommu/dma: Fix condition check in iommu_dma_unmap_sg
Message-ID: <20190529121447.GA9839@lst.de>
References: <20190529081532.73585-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529081532.73585-1-natechancellor@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ooops, thanks for catching this:

Reviewed-by: Christoph Hellwig <hch@lst.de>
