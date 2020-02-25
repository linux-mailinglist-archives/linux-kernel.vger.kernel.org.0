Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A67E16EEAF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 20:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbgBYTKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 14:10:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgBYTKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/QPdaZH+DsUudIW2GdY/uk6YzgGjD4GCaet27A7iu4Q=; b=a2+ao7c9edC3GjXQUaEmUb/HTT
        hGvinhlKAZkBaIiM4qb96MUs2X0Q4fRunGkB/CeQARPEpMClpLIQKcKBb5rTezSOsV64m559qLGiR
        3saeYmoNvg4raBqUeMGE7xiqMAcXlVqS/pW4goL2Lyd+V3kM0jEELT9iBfsdNnaVd+1qif0otTydH
        TkgO1N1uYu5RFWYaIQ1w+Viu7/I9ta3Dwr1Gt8B6TbdhPWWFwPqtTdIUdhP8zDFwA8BUJUyQOZyAn
        rcb8SQa10L2M87oDjwKIWAZOas6e5R4DhX3dgJfAupdWwyey767howjeF3tzZ/SHDR/eZXWl593m5
        voledIJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6fbG-0000xA-RV; Tue, 25 Feb 2020 19:10:34 +0000
Date:   Tue, 25 Feb 2020 11:10:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: Replace intel SVM APIs with generic SVA
 APIs
Message-ID: <20200225191034.GA29045@infradead.org>
References: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1582586797-61697-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582586797-61697-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 03:26:37PM -0800, Jacob Pan wrote:
> This patch is an initial step to replace Intel SVM code with the
> following IOMMU SVA ops:
> intel_svm_bind_mm() => iommu_sva_bind_device()
> intel_svm_unbind_mm() => iommu_sva_unbind_device()
> intel_svm_is_pasid_valid() => iommu_sva_get_pasid()

How did either set APIs end up being added to the kernel without users
to start with?

Please remove both the old intel and the iommu ones given that neither
has any users.
