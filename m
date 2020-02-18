Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D30162C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 18:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBRRPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 12:15:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgBRRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7a7BeuJeRNU5QeUULzHih8KoXjfLOlATiPV+cUmscGw=; b=QIjdz8QSjjIzAMdVllBXV1Ditl
        VdQfMjoATPnUCECUsv27WHAJ189BzjMml0/WCJWrgl36BxxoeO80uWMODrvi1iZBmsS+hh7dIiy44
        b+Zgrd143+f6dmQmLhZQ+FuH9ePMXl2ELA3qXgOzTDtEUEbb60nIa36OV97pUwOYLaeU/LzPg4UzL
        AJtwyIqOXYgNzO6uGl+GlSImIP5h2zicGElavdnAACUdimW5ZnFJN7jRzb/7V/eo9FMyiywWCQVem
        YDW+lqCuAVv+D7I4cdz6hEyYPzvN50Daw+JTBPbfKlKtHLSO7rU09izm9Se5yBKKdo+rL7lADysxb
        DeAvxGgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j46SU-00038d-O4; Tue, 18 Feb 2020 17:14:54 +0000
Date:   Tue, 18 Feb 2020 09:14:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iommu/vt-d: Add attach_deferred() helper
Message-ID: <20200218171454.GA7067@infradead.org>
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217193858.26990-2-joro@8bytes.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static bool attach_deferred(struct device *dev)
> +{
> +	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
> +}

This is not a very useful helper.

> +
>  /**
>   * is_downstream_to_pci_bridge - test if a device belongs to the PCI
>   *				 sub-hierarchy of a candidate PCI-PCI bridge
> @@ -2510,8 +2515,7 @@ struct dmar_domain *find_domain(struct device *dev)
>  {
>  	struct device_domain_info *info;
>  
> -	if (unlikely(dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO ||
> -		     dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO))
> +	if (unlikely(attach_deferred(dev) || iommu_dummy(dev)))
>  		return NULL;

I'd rather kill the iommu_dummy helper as well.  And IIRC I have an
outstanding series somewhere that does just that..
