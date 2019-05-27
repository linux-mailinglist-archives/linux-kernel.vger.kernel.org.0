Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 999FD2B796
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 16:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfE0OdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 10:33:08 -0400
Received: from 8bytes.org ([81.169.241.247]:40342 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfE0OdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:33:08 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2BBBC2AF; Mon, 27 May 2019 16:33:07 +0200 (CEST)
Date:   Mon, 27 May 2019 16:33:05 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     dwmw2@infradead.org, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix lock inversion between iommu->lock
 and device_domain_lock
Message-ID: <20190527143305.GB12745@8bytes.org>
References: <20190521073016.27525-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521073016.27525-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 03:30:15PM +0800, Lu Baolu wrote:
> ---
>  drivers/iommu/intel-iommu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied both, thanks.
