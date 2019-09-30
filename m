Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B9BC293E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 00:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbfI3WBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 18:01:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41834 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfI3WBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:01:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so8114226pgv.8;
        Mon, 30 Sep 2019 15:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8wmWulXHTTXGpvjqxSSMHsxFiZ7egaQe8/QmdwDC9vM=;
        b=hmp3YlmLhI9gG8y+piu24MkbwSkk8jC40fnzCL93lGNC3fF6tHmO2PetbdKrVTlbdn
         Z+p7dzf5jRl1PWYNMgHFwIDXsztjVgM2zyYf4bB2F2/8ShdmgM3IgHG3LPRoQq0LyX2G
         p7U4Lh1NmdzdboptPs9M0NwaNl2r5mbmgbuvYqtil1GadnsBWftZVDO9VSa+8Vd3c+dn
         LqiwiAZOrofM27yVfLjyXxp3tuF+AynGsMCxKDNZEQwYVim2n8A+y17namvSrc0w/5GO
         eRGCO1qm/k+FP+zEI2xeeHD9Vs9d/ppUI0EDdVyayldW2hL31pomFkaUnqLCG+vJ5ooB
         6dwg==
X-Gm-Message-State: APjAAAVhDq5YSL4Awz8aLcLo87urmNPROQaGVw7JrLCWjWbMAw6maxIS
        TLaNtkT6Vxz92z3AM+ibD1NVXgW2
X-Google-Smtp-Source: APXvYqyCuk73P3mt/OHee3iw3iV7IUvfxeq5SUfPmdsq/aiN+8BuW2g+6lHWCfT3VYb2RS3x0mqMDA==
X-Received: by 2002:a63:5745:: with SMTP id h5mr27349062pgm.268.1569880884260;
        Mon, 30 Sep 2019 15:01:24 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a6sm13705306pgb.34.2019.09.30.15.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 15:01:15 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq: fill header with kernel-doc
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, kernel@collabora.com, krisman@collabora.com
References: <20190930194846.23141-1-andrealmeid@collabora.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <845be3ae-f7f4-4e80-ee26-30a03a8af8b4@acm.org>
Date:   Mon, 30 Sep 2019 15:01:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930194846.23141-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/19 12:48 PM, André Almeida wrote:
> Insert documentation for structs, enums and functions at header file.
> Format existing and new comments at struct blk_mq_ops as
> kernel-doc comments.

Hi André,

Seeing the documentation being improved is great. However, this patch 
conflicts with a patch series in my tree and that I plan to post soon. 
So I would appreciate it if this patch would be withheld until after my 
patch series has been accepted.

Thanks,

Bart.
