Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7150AF6C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 03:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfKKCUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 21:20:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:48162 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfKKCUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:20:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2019 18:20:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; 
   d="scan'208";a="228794367"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2019 18:20:19 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Add Kconfig option to enable/disable
 scalable mode
To:     Qian Cai <cai@lca.pw>
References: <519c1126-ab91-1308-bdd0-c8d1be7a1c63@linux.intel.com>
 <2BBFF955-5533-43CD-849A-2BA6B2CC1AF2@lca.pw>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8663cb77-6ec3-fc2a-87bb-3d6629ec1a7f@linux.intel.com>
Date:   Mon, 11 Nov 2019 10:17:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2BBFF955-5533-43CD-849A-2BA6B2CC1AF2@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/11/19 10:00 AM, Qian Cai wrote:
> 
> 
>> On Nov 10, 2019, at 8:30 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> How about "pasid based multiple stages DMA translation"?
> 
> It is better but I am still not sure how developers should select it or not when asking. Ideally, should it mention pros and cons of this? At minimal, there should be a line said “if not sure what this is, select N”?
> 

Actually, I'd recommend "if not sure, use the default value". :-)

Best regards,
baolu
