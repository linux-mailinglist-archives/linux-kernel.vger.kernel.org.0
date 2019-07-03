Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5752B5EDF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 22:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfGCU40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 16:56:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:43888 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfGCU4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:56:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:56:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="166087884"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.1.56]) ([10.252.1.56])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2019 13:56:20 -0700
Subject: Re: [PATCH V2 2/2] ASoC: fsl_esai: recover the channel swap after
 xrun
To:     shengjiu.wang@nxp.com
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <cover.1562136119.git.shengjiu.wang@nxp.com>
 <c29639336b6b32fa781bdddad30287f8b76d5e0b.1562136119.git.shengjiu.wang@nxp.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <3238f813-ac71-69e2-45bf-badb461dac82@intel.com>
Date:   Wed, 3 Jul 2019 22:56:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c29639336b6b32fa781bdddad30287f8b76d5e0b.1562136119.git.shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-03 08:42, shengjiu.wang@nxp.com wrote:
> +static void fsl_esai_reset(unsigned long arg)
> +{
> +	struct fsl_esai *esai_priv = (struct fsl_esai *)arg;
> +	u32 saisr, tfcr, rfcr;
> +
> +	/* save the registers */
> +	regmap_read(esai_priv->regmap, REG_ESAI_TFCR, &tfcr);
> +	regmap_read(esai_priv->regmap, REG_ESAI_RFCR, &rfcr);
> +
> +	/* stop the tx & rx */
> +	fsl_esai_trigger_stop(esai_priv, 1);
> +	fsl_esai_trigger_stop(esai_priv, 0);
> +
> +	/* reset the esai, and restore the registers */
> +	fsl_esai_init(esai_priv);

<comment below applies>

> +
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> +			   ESAI_xCR_xPR_MASK,
> +			   ESAI_xCR_xPR);
> +	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> +			   ESAI_xCR_xPR_MASK,
> +			   ESAI_xCR_xPR);
> +
> +	/* restore registers by regcache_sync */
> +	fsl_esai_register_restore(esai_priv);
> +

Both _init and _restore may fail given their declaration in 1/2 "ASoC: 
fsl_esai: Wrap some operations to be functions" yet here you simply 
ignore the return values.

If failure of said functions is permissive, it might be a good place for 
a comment.

Czarek
