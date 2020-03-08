Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9542B17D0DB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 03:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgCHCI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 21:08:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:38144 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgCHCI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 21:08:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2020 18:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,528,1574150400"; 
   d="scan'208";a="414402899"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.93]) ([10.254.211.93])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2020 18:08:23 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: Re: [PATCH 1/6] iommu: Add dev_def_domain_type() callback in
 iommu_ops
To:     Christoph Hellwig <hch@lst.de>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com>
 <20200307062014.3288-2-baolu.lu@linux.intel.com>
 <20200307141836.GA26190@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4a4a04aa-7fb5-88c9-2b4d-ee4f3568944b@linux.intel.com>
Date:   Sun, 8 Mar 2020 10:08:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307141836.GA26190@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Thanks for your review.

On 2020/3/7 22:18, Christoph Hellwig wrote:
> Do we really need the dev_ prefix in the method name?  Shouldn't the
> struct device parameter be hint enough?

Fair enough. Will use def_domain_type().

Best regards,
baolu

