Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC72D8EAA5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 13:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfHOLtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 07:49:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:9829 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfHOLtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:49:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 04:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="184600893"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2019 04:49:29 -0700
Subject: Re: [PATCH v2] mmc: tegra: Implement enable_dma() to set dma_mask
To:     Nicolin Chen <nicoleotsuka@gmail.com>, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, vdumpa@nvidia.com
References: <20190814005741.13331-1-nicoleotsuka@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <09d9ba41-f4cd-e515-cd2d-0b4134648059@intel.com>
Date:   Thu, 15 Aug 2019 14:48:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814005741.13331-1-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/19 3:57 AM, Nicolin Chen wrote:
> [ Integrated the change and commit message made by Thierry Reding ]
> 
> The SDHCI controller found in early Tegra SoCs (from Tegra20 through
> Tegra114) used an AHB interface to the memory controller, which allowed
> only 32 bits of memory to be addressed.
> 
> Starting with Tegra124, this limitation was removed by making the SDHCI
> controllers native MCCIF clients, which means that they got increased
> bandwidth and better arbitration to the memory controller as well as an
> address range extended to 40 bits, out of which only 34 were actually
> used (bits 34-39 are tied to 0 in the controller).
> 
> For Tegra186, all of the 40 bits can be used; For Tegra194, 39-bit can
> be used.
> 
> So far, sdhci-tegra driver has been relying on sdhci core to configure
> the DMA_BIT_MASK between 32-bit or 64-bit, using one of quirks2 flags:
> SDHCI_QUIRK2_BROKEN_64_BIT_DMA. However, there is a common way, being
> mentioned in sdhci.c file, to set dma_mask via enable_dma() callback in
> the device driver directly.
> 
> So this patch implements an enable_dma() callback in the sdhci-tegra,
> in order to set an accurate DMA_BIT_MASK, other than just 32/64 bits.

Is there a reason this cannot be done at probe time?
