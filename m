Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B819CF45A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 12:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfKHLYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 06:24:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:55770 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfKHLYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:24:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 03:24:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,281,1569308400"; 
   d="scan'208";a="213227330"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2019 03:24:42 -0800
Subject: Re: [PATCH v5 4/4] mmc: host: sdhci: Add a variable to defer to
 complete data requests if needed
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        baolin.wang7@gmail.com, linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1572326519.git.baolin.wang@linaro.org>
 <19910a2f34b9be81f64637a5a5fc8d07bd5f4885.1572326519.git.baolin.wang@linaro.org>
 <a9f42792-3432-48f2-c5c4-8b03c32995dd@intel.com>
 <CAMz4kuK=wV1qtO4tOCcqibzKAFD-_p8+OzGOjdkvajVymJ5EgA@mail.gmail.com>
 <2ed0bcd1-fa74-d095-97ee-7d0c46a4fdbb@intel.com>
 <CAMz4kuJe64hdVGBTCvZW3t4_JGnTBRF=NhYDookrzNPiXacq_w@mail.gmail.com>
 <CAMz4ku+KVWw-M4AaPJ=Yn8xeLNaD2W4+gVqEN_P0QRwne3wwzA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0c70b5cf-4453-b21b-5622-f97ff069cf1b@intel.com>
Date:   Fri, 8 Nov 2019 13:23:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMz4ku+KVWw-M4AaPJ=Yn8xeLNaD2W4+gVqEN_P0QRwne3wwzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/19 1:08 PM, Baolin Wang wrote:
> On 06/11/2019, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On Wed, 6 Nov 2019 at 20:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> To move ahead in the meantime without a new host API, just defer always
> 
> Before new version, I want to make things clear in case I
> misunderstood your points, so you mean I should set always_defer_done
> = true for our Spreadtrum host driver in this patch? Or just like
> below patch? Thanks.
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 850241f..4bef066 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct
> sdhci_host *host,
>  {
>         struct mmc_data *data = mrq->data;
> 
> -       return host->pending_reset ||
> +       return host->pending_reset || host->always_defer_done ||
>                ((host->flags & SDHCI_REQ_USE_DMA) && data &&
>                 data->host_cookie == COOKIE_MAPPED);
>  }
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d89cdb9..a73ce89 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -533,6 +533,7 @@ struct sdhci_host {
>         bool pending_reset;     /* Cmd/data reset is pending */
>         bool irq_wake_enabled;  /* IRQ wakeup is enabled */
>         bool v4_mode;           /* Host Version 4 Enable */
> +       bool always_defer_done; /* Always defer to complete requests */
> 
>         struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
>         struct mmc_command *cmd;        /* Current command */
> 

Yes

