Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBEA12BC4E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 03:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfL1CtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Dec 2019 21:49:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:42700 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfL1CtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 21:49:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 18:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,365,1571727600"; 
   d="scan'208";a="243382416"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2019 18:48:58 -0800
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Loose requirement for flush queue
 initializaton
To:     Joerg Roedel <joro@8bytes.org>
References: <20191219051851.25159-1-baolu.lu@linux.intel.com>
 <20191219051851.25159-2-baolu.lu@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5d798620-ef1a-7e89-96c5-ed902d90a9a2@linux.intel.com>
Date:   Sat, 28 Dec 2019 10:47:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219051851.25159-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/19 1:18 PM, Lu Baolu wrote:
> Currently if flush queue initialization fails, we return error
> or enforce the system-wide strict mode. These are unnecessary
> because we always check the existence of a flush queue before
> queuing any iova's for lazy flushing. Printing a informational
> message is enough.
> 
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

Queued for v5.6.

Thanks,
-baolu
