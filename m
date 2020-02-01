Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CFE14F676
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 05:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgBAEsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 23:48:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41060 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgBAEsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 23:48:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id l3so583218pgi.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 20:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SDiRJgIexvsCRZyBGBkTLxhYXwLjtWjl6c8nsRIE3KI=;
        b=HBZz1k+Wprky9UL45iCfSEdfdTFJ3ZF6QhbNruPR0fUAbcYvUerrtVj7qkTM047lft
         8BElWoGLtA/lNBXCt2J+ks/ph1k2Hza6tplCjFwGcM7mZUho5XfOjlqFoS2o1H8gXket
         Yw8F9ap1aqe7PZ3c6pAyyrawdUZe/SMbgOy3gKMW+uAtVh5qnnljKK2L7Qf0IOqCcMHT
         xyUHKX3uyc6rGLHboDxnhFAR8iwpzBDOlLjeO3fq5lokQqHMloU+yqA1Wcy3+8M+1Fz4
         tadcu2Ak1t5pgBFPxY/E75URx36YERI4lJeXY+UMEsXL+zuU3VLOvBk9sjipG5/yh7D9
         hAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDiRJgIexvsCRZyBGBkTLxhYXwLjtWjl6c8nsRIE3KI=;
        b=IlfEmuMuOIUtQIq0RuxxujEuRXA/UgSN9JNt6cGFFYw0lNDFmloftCwzHEcMZreyWY
         iAVVdpVhNLI9kWmIZMbVMMK1FssWy32wByKb3Y1fbE7Th/9QuUC7Yr/Gs9TSZRvVGCW2
         n8kS5zv+Bmo8QJiZtshGLLoD1wugrldv2gLmxV6JSvROLAY93ih37NrOD9Q1rUq5fPK1
         fiRRipIy1wK0BB6q5JUJe1SH+eyr3t6OZdM3V7kNHLjfuXNPeuWr8shoCDC7UR6WmPoJ
         eBiYDf2SdeR7XcS3BloDEh1HjlD94xw1wUkryRe/PjE2wX8JpmLUasy0qntKjoDGgbuX
         6kwQ==
X-Gm-Message-State: APjAAAXIIpeC0swLOPHwTX19aOzSc8uC2iQzE7hpjtmnLOO7ZnVlTiK6
        J3dDdXBwSTVEYou0b5Qf5rOO/w==
X-Google-Smtp-Source: APXvYqxF2uIMQQW0jF0M5Zly1z9uI1Fu8uIiVzlx8pi0NCLvu3s+9xUFEpIh3UMBmTJssLHk0XfxsA==
X-Received: by 2002:a63:f148:: with SMTP id o8mr14545058pgk.314.1580532530019;
        Fri, 31 Jan 2020 20:48:50 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id d24sm13108879pfq.75.2020.01.31.20.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 20:48:49 -0800 (PST)
Subject: Re: [PATCH BUGFIX 0/6] block, bfq: series of fixes, and not only, for
 some recently reported issues
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com
References: <20200131092409.10867-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f0480d87-41a3-c056-854e-e480461bbd96@kernel.dk>
Date:   Fri, 31 Jan 2020 21:48:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131092409.10867-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/20 2:24 AM, Paolo Valente wrote:
> Hi Jens,
> these patches are mostly fixes for the issues reported in [1, 2]. All
> patches have been publicly tested in the dev version of BFQ.
> 
> Thanks,
> Paolo
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1767539
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=205447
> 
> Paolo Valente (6):
>   block, bfq: do not plug I/O for bfq_queues with no proc refs
>   block, bfq: do not insert oom queue into position tree
>   block, bfq: get extra ref to prevent a queue from being freed during a
>     group move
>   block, bfq: extend incomplete name of field on_st
>   block, bfq: get a ref to a group when adding it to a service tree
>   block, bfq: clarify the goal of bfq_split_bfqq()
> 
>  block/bfq-cgroup.c  | 12 ++++++++++--
>  block/bfq-iosched.c | 20 +++++++++++++++++++-
>  block/bfq-iosched.h |  3 ++-
>  block/bfq-wf2q.c    | 27 ++++++++++++++++++++++-----
>  4 files changed, 53 insertions(+), 9 deletions(-)

I wish some of these had been sent sooner, they really should have been
sent in a few weeks ago. Just took a quick look at the bug reports, and
at least one of the bugs mentions looks like it had a fix available 2
months ago. Have they been in -next? They are all marked as bug fixes,
should they have stable tags? All of them, some of them?

-- 
Jens Axboe

