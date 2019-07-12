Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC1767224
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 17:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfGLPPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 11:15:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44485 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfGLPPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:15:32 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so20997610iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2opEnBuVBF2b4E5QanZT3B1PxQTl1jpFqVeaeD4Jvac=;
        b=BMS+LBZ1HOJ+oPmT+jj9cCB2CMuhLD9hOgL1EGxhXgjcCFU+uRhdlTEHJctcvcAfAC
         93xCyhVww0XoYzbRJRJbpZBsYO3Bm1q/MlPGVvrNSmWS6qfkXQz8BXXUjRJsSG2wkg1B
         oUhykgoEyU+U5WMY8pngtLd8pQv2pIfwtfSV3MVO+kJRkbbD+jxi3cwlmNKFU6maqscI
         iIz0r5umTAoC5x9daY2n1PVhdWCYjSYP5JjtzczVfPEaIuMScEe303uYSFPRxEjPxbTY
         wo2uvzLdn+ynMMpp8KKHkC8MInm7bHAk0Gz2dmFjF6xGUKzzWIe57apPN0x9lMRWIqqQ
         wFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2opEnBuVBF2b4E5QanZT3B1PxQTl1jpFqVeaeD4Jvac=;
        b=QueSMYtIT7wCOI7Bqb9SlDPjQi8pkSz0Z4zNjV6nOnNSga+f1Rlmi7uY9gSXGS0nY4
         CySGexSpFdgOy6G/jleSx/1GIf5liLPwI/hktYPyDp1oOa9YlmP6Ny2Gc/LejMIT4++1
         e3FyXx75GhbtL3SPu6OqM3kc9XVcOMJmaakuZOuDsd8axoIuskvSKGfeLAufN/9//6BI
         2LCgG3wvh++wKz+Qvocden2dm7d9P+8jTZdmhdlFVarQUMlH6gDDUrcY+rwfXTphsBsR
         bkf70PE1eHPje4cDFDutxciO4afFHVjNm4up9UAzUHHrVVVL/jb9UTkzQnAzqjV410V7
         Jj4w==
X-Gm-Message-State: APjAAAWbsviybZr2YKfIAnZ6wnad1wUnvh6ohOHQgh3kIMdQ9UR9QOit
        EvzD1VCCHIWTfiSYgZeTaN70uGs0u/o=
X-Google-Smtp-Source: APXvYqxNzK45erpGagcbIG8GrfCOqm46U/1e0qdgZFVftYMWqnRGnTZfkMPl7UYDH4Wj4yMq6IdAPw==
X-Received: by 2002:a02:b812:: with SMTP id o18mr1716469jam.64.1562944530468;
        Fri, 12 Jul 2019 08:15:30 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e22sm6692139iob.66.2019.07.12.08.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 08:15:29 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: add entry for block io cgroup
To:     Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <156284038698.3851.6531328622774377848.stgit@buzz>
 <20190712142502.GA680549@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <82bc7337-c48f-7559-bd9b-6a21ccbfceb0@kernel.dk>
Date:   Fri, 12 Jul 2019 09:15:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712142502.GA680549@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/19 8:25 AM, Tejun Heo wrote:
> Hello, Konstantin.
> 
> On Thu, Jul 11, 2019 at 01:19:47PM +0300, Konstantin Khlebnikov wrote:
>> +CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)
>> +L:	cgroups@vger.kernel.org
>> +F:	Documentation/cgroup-v1/blkio-controller.rst
>> +F:	block/blk-cgroup.c
>> +F:	include/linux/blk-cgroup.h
>> +F:	block/blk-throttle.c
>> +F:	block/blk-iolatency.c
>> +F:	block/bfq-cgroup.c
> 
> Given that blkcg changes are often entangled with generic block
> changes and best routed through block tree, I think it'd be useful to
> add the followings.
> 
> M:      Tejun Heo <tj@kernel.org>
> M:      Jens Axboe <axboe@kernel.dk>
> L:      linux-block@vger.kernel.org
> T:      git git://git.kernel.dk/linux-block

I applied the patch with these additions.

-- 
Jens Axboe

