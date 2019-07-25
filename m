Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7FD742F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 03:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbfGYBli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 21:41:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:63498 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388173AbfGYBli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 21:41:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 18:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,305,1559545200"; 
   d="scan'208";a="181303696"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 24 Jul 2019 18:41:35 -0700
Cc:     baolu.lu@linux.intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, cai@lca.pw,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH v2 7/7] iommu/vt-d: Consolidate domain_init() to avoid
 duplication
To:     Joerg Roedel <joro@8bytes.org>
References: <20190612002851.17103-1-baolu.lu@linux.intel.com>
 <20190612002851.17103-8-baolu.lu@linux.intel.com>
 <20190718171615.2ed56280@x1.home>
 <f56599a6-77ac-e1ef-4843-51167b1284b3@linux.intel.com>
 <20190719091952.58255c47@x1.home>
 <13294960-c040-c501-c279-aa61d780d25e@linux.intel.com>
 <20190722142238.GA12009@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <db69a425-2ab7-c4e6-80fe-a48069ceef0e@linux.intel.com>
Date:   Thu, 25 Jul 2019 09:41:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190722142238.GA12009@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/22/19 10:22 PM, Joerg Roedel wrote:
> On Sat, Jul 20, 2019 at 09:15:58AM +0800, Lu Baolu wrote:
>> Okay. I agree wit you. Let's revert this commit first.
> 
> Reverted the patch and queued it to my iommu/fixes branch.

Thank you! Joerg.

Best regards,
Baolu
