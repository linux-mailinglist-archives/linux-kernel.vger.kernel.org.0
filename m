Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC7E110641
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 22:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfLCVDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 16:03:50 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39177 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbfLCVDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:03:49 -0500
Received: by mail-il1-f194.google.com with SMTP id a7so4524922ild.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 13:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sFn+q5M4OQGy2hAfzIasEpnp/G/IQ19ZE4PBt4z+hKs=;
        b=bjMRZrmxdnENLVxHQwgxiuGhs/pIOOCI7RPVi2IMk3lwgTI7aNB9AryFTQFJ6N34Zz
         znaAPt4pAIhJrr9eVmUHVToYCNxheTmgPByX99LYCSyVMAjJEY/6aWBIurQG20+1KE2p
         B7Xx7tBoXqf5elHivpFxXrpx4F+ZdXzRwgJntZCgFBhUIp+3zU9jA7Kkfwf5ndxxUYIF
         vegXLjcgvhs/y083uQx2obugP2D9bv+dEvcAIvjPPJkew84MoNsU4x0d1yfbOK0T00eX
         t7g3EDZUcj29+n0c7bK3y+ZSqCCnnlF8cPzoVC2tHqeAUYF8OaAC3w0H9ET1FuwRzPg/
         /qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sFn+q5M4OQGy2hAfzIasEpnp/G/IQ19ZE4PBt4z+hKs=;
        b=qOLMH2S8GdYdxegxL9YvRlpE9G7Eb6vpmWUv0skKqzkdeDeK7mzyFGX9RjHJLGqvOO
         xDaPysW9vi8AbvnYJf0cazTcreWmmHEURMbgyndq5mf0u+6uMu0wMyMQYnqo7LDx92Vg
         V1mf0zMrcz42ccT7FN96M1eokrNUE6bKNe75SKTa0K6SH2uHU1oW5Yl3bT6asQd6F/Su
         +F3Afu3DPDnIL26zW+7sEAlY0a8i0+4b4JxGbj0YEDS3EfgSosV/BJuOWk+FCm6hmSCG
         1bKUAQK02gAPM9dflt1Vp85RDKyXAPycHtPLqjtdqkNPMC8XFdrmPIbs2SAYNOyZ9uzR
         DSKA==
X-Gm-Message-State: APjAAAX8xgI2dbGXt4FRFfeGh9HpG6JaauLMtc/TUgoz4tTwOupuEMto
        PgQPXPu8rAIaRL6F4APPkDi4CA==
X-Google-Smtp-Source: APXvYqynb9y1GtIc2v9Jt2I8gQfLy2oB0u+TVZ+0gIHqiiCdzgQ3Kw9UoB/KAiRWf5JLsPyTkN/pBA==
X-Received: by 2002:a92:d282:: with SMTP id p2mr134806ilp.73.1575407028959;
        Tue, 03 Dec 2019 13:03:48 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a81sm1136094ill.31.2019.12.03.13.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 13:03:48 -0800 (PST)
Subject: Re: [PATCH] xen/blkback: Avoid unmapping unmapped grant pages
To:     SeongJae Park <sjpark@amazon.com>, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
References: <20191126153605.27564-1-sjpark@amazon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <43f9881b-4a88-47e9-c321-19033a2bc872@kernel.dk>
Date:   Tue, 3 Dec 2019 14:03:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191126153605.27564-1-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/19 8:36 AM, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> For each I/O request, blkback first maps the foreign pages for the
> request to its local pages.  If an allocation of a local page for the
> mapping fails, it should unmap every mapping already made for the
> request.
> 
> However, blkback's handling mechanism for the allocation failure does
> not mark the remaining foreign pages as unmapped.  Therefore, the unmap
> function merely tries to unmap every valid grant page for the request,
> including the pages not mapped due to the allocation failure.  On a
> system that fails the allocation frequently, this problem leads to
> following kernel crash.
> 
>    [  372.012538] BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
>    [  372.012546] IP: [<ffffffff814071ac>] gnttab_unmap_refs.part.7+0x1c/0x40
>    [  372.012557] PGD 16f3e9067 PUD 16426e067 PMD 0
>    [  372.012562] Oops: 0002 [#1] SMP
>    [  372.012566] Modules linked in: act_police sch_ingress cls_u32
>    ...
>    [  372.012746] Call Trace:
>    [  372.012752]  [<ffffffff81407204>] gnttab_unmap_refs+0x34/0x40
>    [  372.012759]  [<ffffffffa0335ae3>] xen_blkbk_unmap+0x83/0x150 [xen_blkback]
>    ...
>    [  372.012802]  [<ffffffffa0336c50>] dispatch_rw_block_io+0x970/0x980 [xen_blkback]
>    ...
>    Decompressing Linux... Parsing ELF... done.
>    Booting the kernel.
>    [    0.000000] Initializing cgroup subsys cpuset
> 
> This commit fixes this problem by marking the grant pages of the given
> request that didn't mapped due to the allocation failure as invalid.
> 
> Fixes: c6cc142dac52 ("xen-blkback: use balloon pages for all mappings")

Queued up with Roger's reviewed-by.

-- 
Jens Axboe

