Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8CFD728F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 11:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfJOJwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 05:52:46 -0400
Received: from 8bytes.org ([81.169.241.247]:47374 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfJOJwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:52:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 48096398; Tue, 15 Oct 2019 11:52:44 +0200 (CEST)
Date:   Tue, 15 Oct 2019 11:52:42 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Refactor find_domain() helper
Message-ID: <20191015095242.GB14518@8bytes.org>
References: <20190921070644.10630-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190921070644.10630-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2019 at 03:06:44PM +0800, Lu Baolu wrote:
> Current find_domain() helper checks and does the deferred domain
> attachment and return the domain in use. This isn't always the
> use case for the callers. Some callers only want to retrieve the
> current domain in use.
> 
> This refactors find_domain() into two helpers: 1) find_domain()
> only returns the domain in use; 2) deferred_attach_domain() does
> the deferred domain attachment if required and return the domain
> in use.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)

Applied, thanks.
