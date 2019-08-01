Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C7D7D546
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 08:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfHAGKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 02:10:25 -0400
Received: from verein.lst.de ([213.95.11.211]:40477 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHAGKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:10:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B272368B05; Thu,  1 Aug 2019 08:10:21 +0200 (CEST)
Date:   Thu, 1 Aug 2019 08:10:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/3] iommu/vt-d: Refactor find_domain() helper
Message-ID: <20190801061021.GA14955@lst.de>
References: <20190801060156.8564-1-baolu.lu@linux.intel.com> <20190801060156.8564-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801060156.8564-2-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 02:01:54PM +0800, Lu Baolu wrote:
> +	/* No lock here, assumes no domain exit in normal case */

s/exit/exists/ ?

> +	info = dev->archdata.iommu;
> +	if (likely(info))
> +		return info->domain;

But then again the likely would be odd.
