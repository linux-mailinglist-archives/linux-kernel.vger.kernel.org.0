Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41EC7D1DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 03:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbfJJB0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 21:26:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:11087 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731134AbfJJB0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 21:26:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 18:26:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="218862439"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2019 18:26:30 -0700
Cc:     baolu.lu@linux.intel.com, Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Return the correct dma mask when we are
 bypassing the IOMMU
To:     Christoph Hellwig <hch@lst.de>
References: <20191008143357.GA599223@rani.riverdale.lan>
 <76d680ab-a454-4a69-597a-c0edbfc5014b@linux.intel.com>
 <20191009065115.GB30157@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dacd9024-9f62-bba8-9ca5-9edcf2150e30@linux.intel.com>
Date:   Thu, 10 Oct 2019 09:24:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009065115.GB30157@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 10/9/19 2:51 PM, Christoph Hellwig wrote:
> On Wed, Oct 09, 2019 at 10:45:15AM +0800, Lu Baolu wrote:
>> Do you mind explaining why we always return 32 bit here?
> 
> See the comment in dma_get_required_mask().
> 

Got it. Thank you.

Best regards,
Baolu
