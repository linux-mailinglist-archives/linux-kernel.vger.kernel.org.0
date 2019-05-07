Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B45F16D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 00:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEGWOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 18:14:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:22538 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfEGWOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:14:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 15:14:38 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 07 May 2019 15:14:38 -0700
Received: from khbyers-mobl2.amr.corp.intel.com (unknown [10.251.29.37])
        by linux.intel.com (Postfix) with ESMTP id 58075580238;
        Tue,  7 May 2019 15:14:37 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] ASoC: SOF: Add Comet Lake PCI IDs
To:     Evan Green <evgreen@chromium.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20190507215359.113378-1-evgreen@chromium.org>
 <20190507215359.113378-2-evgreen@chromium.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cb0accd5-6b0d-065a-9b54-321252862d88@linux.intel.com>
Date:   Tue, 7 May 2019 17:14:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507215359.113378-2-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor nit-picks below. The Kconfig would work but select CANNONLAKE even 
if you don't want it.

>   
> +config SND_SOC_SOF_COMETLAKE_LP
> +	tristate
> +	select SND_SOC_SOF_CANNONLAKE

This should be
select SND_SOF_SOF_HDA_COMMON

> +	help
> +	  This option is not user-selectable but automagically handled by
> +	  'select' statements at a higher level
> +
> +config SND_SOC_SOF_COMETLAKE_LP_SUPPORT
> +	bool "SOF support for CometLake-LP"
> +	help
> +	  This adds support for Sound Open Firmware for Intel(R) platforms
> +	  using the Cometlake-LP processors.
> +	  Say Y if you have such a device.
> +	  If unsure select "N".
> +
> +config SND_SOC_SOF_COMETLAKE_H
> +	tristate
> +	select SND_SOC_SOF_CANNONLAKE

This should be
select SND_SOF_SOF_HDA_COMMON

> +	help
> +	  This option is not user-selectable but automagically handled by
> +	  'select' statements at a higher level
> +
> +config SND_SOC_SOF_COMETLAKE_H_SUPPORT
> +	bool "SOF support for CometLake-H"
> +	help
> +	  This adds support for Sound Open Firmware for Intel(R) platforms
> +	  using the Cometlake-H processors.
> +	  Say Y if you have such a device.
> +	  If unsure select "N".

