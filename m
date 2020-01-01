Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAB812E105
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 00:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgAAXhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 18:37:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:58396 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbgAAXhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 18:37:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2020 15:37:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,384,1571727600"; 
   d="scan'208";a="244468568"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jan 2020 15:37:29 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Roland Dreier <roland@purestorage.com>,
        Jim Yan <jimyan@baidu.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Add a quirk flag for scope mismatched
 devices
To:     Joerg Roedel <joro@8bytes.org>
References: <20191224062240.4796-1-baolu.lu@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dec66878-9bd7-70cb-9b53-d8f4a6230916@linux.intel.com>
Date:   Thu, 2 Jan 2020 07:36:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191224062240.4796-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/19 2:22 PM, Lu Baolu wrote:
> We expect devices with endpoint scope to have normal PCI headers,
> and devices with bridge scope to have bridge PCI headers.  However
> Some PCI devices may be listed in the DMAR table with bridge scope,
> even though they have a normal PCI header. Add a quirk flag for
> those special devices.
> 
> Cc: Roland Dreier<roland@purestorage.com>
> Cc: Jim Yan<jimyan@baidu.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

Queued for v5.6.

Thanks,
-baolu
