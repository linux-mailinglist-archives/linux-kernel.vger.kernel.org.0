Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E248DDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 21:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfHNTdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 15:33:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:36906 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfHNTdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 15:33:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 12:33:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="scan'208";a="178252246"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2019 12:33:45 -0700
Date:   Wed, 14 Aug 2019 13:31:32 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        "sjg@google.com" <sjg@google.com>,
        Charles Hyde <charles.hyde@dellteam.com>,
        Jared Dominguez <jared.dominguez@dell.com>
Subject: Re: [PATCH] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
Message-ID: <20190814193132.GD3256@localhost.localdomain>
References: <1565798749-15672-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565798749-15672-1-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 09:05:49AM -0700, Mario Limonciello wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8f3fbe5..47c7754 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2251,6 +2251,29 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
>  		.vid = 0x1179,
>  		.mn = "THNSF5256GPUK TOSHIBA",
>  		.quirks = NVME_QUIRK_NO_APST,
> +	},
> +	/*
> +	 * This LiteON CL1 firmware version has a race condition associated with
> +	 * actions related to suspend to idle.  LiteON has resolved the problem
> +	 * in future firmware.
> +	 */
> +	{
> +		.vid = 0x14a4,
> +		.mn = "CL1-3D128-Q11 NVMe LITEON 128GB",
> +		.fr = "22301111",
> +		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
> +	},
> +	{
> +		.vid = 0x14a4,
> +		.mn = "CL1-3D256-Q11 NVMe LITEON 256GB",
> +		.fr = "22301111",
> +		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
> +	},
> +	{
> +		.vid = 0x14a4,
> +		.mn = "CL1-3D512-Q11 NVMe LITEON 512GB",
> +		.fr = "22301111",
> +		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
>  	}
>  };

Are there models from this vendor with this same 'fr' that don't need
this quirk? If not, you can leave .mn blank and just use a single entry.
