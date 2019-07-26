Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B924F763A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 12:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfGZKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 06:38:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:53121 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfGZKiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:38:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 03:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,310,1559545200"; 
   d="scan'208";a="175557788"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.251.89.116]) ([10.251.89.116])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2019 03:38:11 -0700
Subject: Re: [RFC PATCH 31/40] soundwire: intel: move shutdown() callback and
 don't export symbol
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-32-pierre-louis.bossart@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <39318aab-b1b4-2cce-c408-792a5cc343dd@intel.com>
Date:   Fri, 26 Jul 2019 12:38:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725234032.21152-32-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
> +void intel_shutdown(struct snd_pcm_substream *substream,
> +		    struct snd_soc_dai *dai)
> +{
> +	struct sdw_cdns_dma_data *dma;
> +
> +	dma = snd_soc_dai_get_dma_data(dai, substream);
> +	if (!dma)
> +		return;
> +
> +	snd_soc_dai_set_dma_data(dai, substream, NULL);
> +	kfree(dma);
> +}

Correct me if I'm wrong, but do we really need to _get_dma_ here?
_set_dma_ seems bulletproof, same for kfree.
