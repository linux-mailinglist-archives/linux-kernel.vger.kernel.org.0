Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEFA1312F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 17:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfECPb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 11:31:58 -0400
Received: from 8bytes.org ([81.169.241.247]:39288 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbfECPb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:31:58 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 22CCB580; Fri,  3 May 2019 17:31:57 +0200 (CEST)
Date:   Fri, 3 May 2019 17:31:55 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/vt-d: Small fixes for 5.2-rc1
Message-ID: <20190503153155.GC11605@8bytes.org>
References: <20190502013426.16989-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502013426.16989-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 09:34:24AM +0800, Lu Baolu wrote:
> Lu Baolu (2):
>   iommu/vt-d: Set intel_iommu_gfx_mapped correctly
>   iommu/vt-d: Make kernel parameter igfx_off work with vIOMMU

Applied both, thanks.
