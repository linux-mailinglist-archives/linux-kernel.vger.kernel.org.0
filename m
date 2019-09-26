Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BD8BF5B8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 17:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfIZPSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 11:18:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41061 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfIZPSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:18:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so2017698pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 08:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HFotGe95HLJfwkokoN/khRbJ8JvtfvSFbv98TWWG2uY=;
        b=fTT13j+HZvBMImjLuc8VyhRvbAejkrXM+LtKu1zULuIWrp4ZvboJz7/kpifHKCVdr1
         FR6Iw1UkngxCfBFaVrtnTst769ZrXW6zRBwyw+h/vsGuMFx9plbG5tcn/ygLKCCBz+Nm
         9WevNHrZPZxMDYK5wsM1/wI6cW6uLjVK9SNTXlGVS1Tqjoe7PsvIEFk8gVfIT9ZQwux8
         bop51JxEoQ2FC5NxjH2F9lMxFFBZCxHBtc3delZnHTqoPaFiroR9/RQTA/ibVTxTH9Lo
         nEfctaIH9PVf2qS+7xudLdOTDML2dO8jP1HX26QBbp8de3tjOYIHQL82cPCQjjImdN6v
         t2GQ==
X-Gm-Message-State: APjAAAW8K0b3fRk9G+/mxR8fkZCemDIaJeTzDYEnLo+twyyPcJ81X9Ay
        KjULYSS/xKvFDWzqBu8Vl+RQuRdWCG8=
X-Google-Smtp-Source: APXvYqxjYxJUGAyF37dN0py+JrHVSkXKfpIzTS4hWU3diBfwqA4kD8YUZnpC0FRTGRNgIPEI7FTfQQ==
X-Received: by 2002:a63:590:: with SMTP id 138mr3882761pgf.78.1569511120829;
        Thu, 26 Sep 2019 08:18:40 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a11sm3501075pfo.165.2019.09.26.08.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:18:39 -0700 (PDT)
Subject: Re: [PATCH] async: Let kfree() out of the critical area of the lock
To:     dsterba@suse.cz, Yunfeng Ye <yeyunfeng@huawei.com>,
        bhelgaas@google.com, "tglx@linutronix.de" <tglx@linutronix.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        sakari.ailus@linux.intel.com,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <216356b1-38c1-8477-c4e8-03f497dd6ac8@huawei.com>
 <f49df2d42d7e97b61a5e26ff4d89ede5fbe37a35.camel@linux.intel.com>
 <e59af8ae-bacb-2e7e-dd53-ea283960d40e@huawei.com>
 <20190926110648.GM2751@suse.cz>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e339db78-413c-446a-8e07-40e6e1ad4a31@acm.org>
Date:   Thu, 26 Sep 2019 08:18:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926110648.GM2751@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 4:06 AM, David Sterba wrote:
> On Thu, Sep 26, 2019 at 03:58:36PM +0800, Yunfeng Ye wrote:
>> The async_lock is big global lock, I think it's good to put kfree() outside
>> to keep the critical area as short as possible.
> 
> Agreed, kfree is not always cheap. We had patches in btrfs moving kfree
> out of critical section(s) after causing softlockups due to increased lock
> contention.

The above would be a great addition for the commit description. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
