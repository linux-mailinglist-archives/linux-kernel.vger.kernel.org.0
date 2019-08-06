Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0CA832F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 15:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbfHFNkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 09:40:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33652 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfHFNkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:40:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so41541590pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ttnWYmtILeIFBSloUihyimwkxfbn41ns5PZ1secKuwU=;
        b=WONYUb6gGmZuRDgIPilqIWjEIu/72wJiK5y8He1TEtDGmtkLcU7BQkn1ZZligaKl/r
         GrfVZo2YK7W+/wvq1HCHM6tJhZoAkUfbLjUyD3gjFszXnceapNh/lDKbvsunuhrxcUQ/
         M6DaMGbqyJbKrAKpQaoaqCPVt4yNxYKpty2FLoad83jlAFp3O1zHhYtc/WfEgU5W4fUd
         /F/1yCkmQUQRk9zN/XHHUlInumsW4BjNfgPQ1E2nb+VeUDAPGgcop4DJvfgQpj4PBuuk
         C+PfmGHm3rqWGNEnEGyey69CJNUh9vIiDJSivqIqyn9v4jqUGkROal7SL414Eejpjqdd
         oLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ttnWYmtILeIFBSloUihyimwkxfbn41ns5PZ1secKuwU=;
        b=mC7efGSN/dZ0atZuPfBeQ7ztv8aJNaSptNKHpvf9Sl1o3vChdwVfXQalDwNssJOmTE
         y9woAyiM/0hiBfmJOEu4ebPUXKk7jUXUrOUD/MZU8pBFizTzPP/L2zG/SSJT3NVk/FTC
         nMmoBA92wN219ky/6huqfPpwxPY4NZrefF59cDgJ6/e6YTtGqFA1Q6plLuxW12XWeXaU
         yL8NQsQjKkAOEU3VZZbDMD+g1rbDXFnzt3XskVFKpzL/+tROWU1rvpJ+f060N+Z16RnV
         YAyRSvmVu8rMX3JE63mnGqKC1pny/+6y4ZV9ycvYNbG26m+Ig3CNQXt5LOd1hwEmMEy8
         rQHg==
X-Gm-Message-State: APjAAAWmzYbqua98LEnltJg92OOBHyLlPXlLLX9gO/LtB4S9CbLQsnEt
        saDr8gAsQD3I05tSkdezQGBN9MxKsb+gqQ==
X-Google-Smtp-Source: APXvYqxPQe0s0dZt3kvk8VxtmiiaVRUL+8RtauB3T+qIJlvvn/GjVTJ69KfiVCmvpynQ0IDLXtF+pg==
X-Received: by 2002:a17:90a:9386:: with SMTP id q6mr3256277pjo.81.1565098853970;
        Tue, 06 Aug 2019 06:40:53 -0700 (PDT)
Received: from [10.71.15.156] ([8.25.222.2])
        by smtp.gmail.com with ESMTPSA id v185sm99080537pfb.14.2019.08.06.06.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 06:40:52 -0700 (PDT)
Subject: Re: [PATCH 0/4] lnvm/pblk mapping cleanups
To:     Jens Axboe <axboe@fb.com>
Cc:     Hans Holmberg <hans@owltronix.com>, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1564566096-28756-1-git-send-email-hans@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5e99586b-c78c-2e70-efb0-aceef56fd19d@lightnvm.io>
Date:   Tue, 6 Aug 2019 06:40:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1564566096-28756-1-git-send-email-hans@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 11:41 AM, Hans Holmberg wrote:
> This series cleans up the metadata allocation/mapping in lnvm/pblk
> by moving over to kvmalloc for metadata and moving metadata mapping
> down to the lower lever driver where blk_rq_map_kern can be used.
> 
> Hans Holmberg (4):
>    lightnvm: remove nvm_submit_io_sync_fn
>    lightnvm: move metadata mapping to lower level driver
>    lightnvm: pblk: use kvmalloc for metadata
>    block: stop exporting bio_map_kern
> 
>   block/bio.c                      |   1 -
>   drivers/lightnvm/core.c          |  43 ++++++++++++---
>   drivers/lightnvm/pblk-core.c     | 116 +++++----------------------------------
>   drivers/lightnvm/pblk-gc.c       |  19 +++----
>   drivers/lightnvm/pblk-init.c     |  38 ++++---------
>   drivers/lightnvm/pblk-read.c     |  22 +-------
>   drivers/lightnvm/pblk-recovery.c |  39 ++-----------
>   drivers/lightnvm/pblk-write.c    |  20 +------
>   drivers/lightnvm/pblk.h          |  31 +----------
>   drivers/nvme/host/lightnvm.c     |  45 +++++----------
>   include/linux/lightnvm.h         |   8 +--
>   11 files changed, 96 insertions(+), 286 deletions(-)
> 

Hi Jens,

Would you like me to pick up this serie, and send it through the 
lightnvm pull request, or would you like to pick it up?

Thank you!
Matias
