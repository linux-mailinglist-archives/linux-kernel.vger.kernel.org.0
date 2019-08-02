Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E549F7FFA3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 19:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405283AbfHBRaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 13:30:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:48752 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405145AbfHBRap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:30:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 10:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; 
   d="scan'208";a="372423063"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2019 10:30:44 -0700
Received: from cwhanson-mobl.amr.corp.intel.com (unknown [10.252.133.191])
        by linux.intel.com (Postfix) with ESMTP id 9E72258046F;
        Fri,  2 Aug 2019 10:30:43 -0700 (PDT)
Subject: Re: [RFC PATCH 26/40] soundwire: cadence_master: fix divider setting
 in clock register
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Rander Wang <rander.wang@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-27-pierre-louis.bossart@linux.intel.com>
 <20190802171906.GB12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e237a872-6371-23a3-a607-99436be11d10@linux.intel.com>
Date:   Fri, 2 Aug 2019 12:30:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802171906.GB12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/19 12:19 PM, Vinod Koul wrote:
> On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
>> From: Rander Wang <rander.wang@linux.intel.com>
>>
>> The existing code uses an OR operation which would mix the original
>> divider setting with the new one, resulting in an invalid
>> configuration that can make codecs hang.
> 
> This looked fine but fails to apply, feel free to send as a fix

likely because it's on top of patch 25



