Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADFD412BC47
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 03:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfL1CnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Dec 2019 21:43:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:34830 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfL1CnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 21:43:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 18:43:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,365,1571727600"; 
   d="scan'208";a="243381779"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2019 18:43:09 -0800
Cc:     baolu.lu@linux.intel.com, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Add Kconfig option to enable/disable
 scalable mode
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20191112063954.19371-1-baolu.lu@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e8d35743-4f86-5626-e0e3-a107264bc9ba@linux.intel.com>
Date:   Sat, 28 Dec 2019 10:42:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191112063954.19371-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 2:39 PM, Lu Baolu wrote:
> This adds Kconfig option INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> to make it easier for distributions to enable or disable the
> Intel IOMMU scalable mode by default during kernel build.
> 
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

Queued for v5.6.

Thanks,
-baolu
