Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 396E32B1A1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 11:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfE0Jzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 05:55:40 -0400
Received: from 8bytes.org ([81.169.241.247]:40216 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfE0Jzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:55:40 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 311DE272; Mon, 27 May 2019 11:55:38 +0200 (CEST)
Date:   Mon, 27 May 2019 11:55:36 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: Fix bind svm with multiple devices
Message-ID: <20190527095536.GA8420@8bytes.org>
References: <1557343366-18686-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557343366-18686-1-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 12:22:46PM -0700, Jacob Pan wrote:
> If multiple devices try to bind to the same mm/PASID, we need to
> set up first level PASID entries for all the devices. The current
> code does not consider this case which results in failed DMA for
> devices after the first bind.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reported-by: Mike Campin <mike.campin@intel.com>
> ---
>  drivers/iommu/intel-svm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Applied for v5.3, thanks.

