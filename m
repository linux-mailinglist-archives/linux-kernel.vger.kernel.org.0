Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A9F201F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 21:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfKFUyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 15:54:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:11844 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfKFUyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:54:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 12:54:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="228688826"
Received: from cjense2x-mobl1.amr.corp.intel.com (HELO [10.251.130.63]) ([10.251.130.63])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Nov 2019 12:54:01 -0800
Subject: Re: [PATCH 0/5] ASoC: SOF: Intel: Soundwire integration
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <20191023211504.32675-1-pierre-louis.bossart@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <633d2d68-dabe-be97-260f-2914c7f386b3@linux.intel.com>
Date:   Wed, 6 Nov 2019 14:54:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191023211504.32675-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/19 4:14 PM, Pierre-Louis Bossart wrote:
> This patchset applies on top of the series "[PATCH 0/4] soundwire:
> update ASoC interfaces". The SOF/Intel code makes use of the
> interfaces defined for initialization.
> 
> Build support for SoundWire is not provided for now, all
> Soundwire-related code will be handled with a dummy fallback. We will
> enable SoundWire interfaces in the Kconfigs when the functionality is
> enabled in the soundwire tree.
> 
> In short, if the interfaces are agreed on, there is no risk with the
> integration of these patches on the ASoC side.

Mark, Vinod, any comments/objections on the suggested interfaces? I 
tried to make your life simpler with a clean separation between 
SoundWire and ASoC/SOF.

> 
> Pierre-Louis Bossart (5):
>    ASoC: SOF: Intel: add SoundWire configuration interface
>    ASoC: SOF: IPC: dai-intel: move ALH declarations in header file
>    ASoC: SOF: Intel: hda: add SoundWire stream config/free callbacks
>    ASoC: SOF: Intel: hda: initial SoundWire machine driver autodetect
>    ASoC: SOF: Intel: hda: disable SoundWire interrupts on suspend
> 
>   include/sound/sof/dai-intel.h    |  18 +--
>   sound/soc/sof/intel/hda-dsp.c    |   2 +
>   sound/soc/sof/intel/hda-loader.c |  13 ++
>   sound/soc/sof/intel/hda.c        | 230 ++++++++++++++++++++++++++++++-
>   sound/soc/sof/intel/hda.h        |  44 ++++++
>   5 files changed, 295 insertions(+), 12 deletions(-)
> 
