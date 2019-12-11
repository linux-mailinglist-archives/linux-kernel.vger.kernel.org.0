Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1557211A195
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 03:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfLKCoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 21:44:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:38038 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLKCoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:44:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 18:44:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="363456285"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 10 Dec 2019 18:44:38 -0800
Received: from [10.226.38.24] (unknown [10.226.38.24])
        by linux.intel.com (Postfix) with ESMTP id D04125808CC;
        Tue, 10 Dec 2019 18:44:36 -0800 (PST)
Subject: Re: [PATCH v7 2/2] phy: intel-lgm-emmc: Add support for eMMC PHY
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com, Ramuthevar@smile.fi.intel.com
References: <20191210025301.29551-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191210025301.29551-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191210135450.GX32742@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <6dac436f-956f-534e-7e15-7aa2f0881217@linux.intel.com>
Date:   Wed, 11 Dec 2019 10:44:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210135450.GX32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/12/2019 9:54 PM, Andy Shevchenko wrote:
> On Tue, Dec 10, 2019 at 10:53:01AM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add support for eMMC PHY on Intel's Lightning Mountain SoC.
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> Signed-off-by: Ramuthevar,Vadivel MuruganX <vadivel.muruganx.ramuthevar@linux.intel.com>
> Something wrong with the second SoB. And why you have two to begin with?

Thanks Andy,  Good catch, I will correct it and send patch again.

Best Regards
vadivel
