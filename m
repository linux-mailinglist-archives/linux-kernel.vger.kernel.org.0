Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C1BE643E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 17:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfJ0Q1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 12:27:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44948 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfJ0Q1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:27:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id e10so4819590pgd.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3BjnWwp3iraWHcYw6tvnTp+ugdgCwV5CI+A2YLDChKo=;
        b=zMPR/EskDyZVAsb7wAVSGiopjG8fnvhNrnzTxGaU4HWKAkdyUfeBomabEO3xgOT/kZ
         OAS0ddQp2qDe15yY0WZc/W+hyAZSLDqsVU6OuBFHmJqiQf15R0zOkXhWBHwzg+6sv9Yl
         rxAkbOaQj8SyLvYwaPuSgdpT0yVy+i0HPNKuYFjEwtysAC2dQN9KFOFPKcr7GNduXoNa
         sagFUgHm1a8fZJSOF/WtrPG3DLQkhJ9JzgnpOiG7iN6hOdpN65dVcfj4qF7j/JFvL8QL
         Sp7hwpBX7HC75zrLG/iSJEHQzT2mYO4MsWfqod8+PmkfAnP4lHQWkhY/K2yjD3Z5TZoK
         voGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3BjnWwp3iraWHcYw6tvnTp+ugdgCwV5CI+A2YLDChKo=;
        b=Lt0f9LrvFHM6UazzxYqpv8JVamkLTveZPboNvAzE2nHiUSqJDWzoOq/qKviXTARikY
         72iibhZ4rU9b/P5dXILpzi+8CTawvS4vlLw6pkqhh/zTreoknevp8GJtwts9/oPq/Y4c
         JvUFqkdXQSm/hUA5U5vnKdh6MPuT+qY8gzHGr8I2z9oSn1bgn6rJfpLnOChlpyiXT1Ok
         6PM75QUltwlk9feC97PIQeEvm7Uz8ORDmjWH+cNsvOSRWdZjzFdRZvKvhytGSEN/gG7c
         AaoDLlk3ukfdUF57xR2uz8qQUtAJgXJfXqNPSRLuvkVjpKZUHs/SdDOGdlDnvqSYF9Is
         rAvA==
X-Gm-Message-State: APjAAAWSRyyCrEFa+3k8tbGPMjQNO5KBRhTEnz5DFjpft3u0onUBptA2
        W2lNXMTKQLX1QqHQTcf+5rgoZsj1zjHv1Q==
X-Google-Smtp-Source: APXvYqxTR9u+jBM/zcy5fuYp6nWnvicznxJE6nWXvvc5TA990pdckOsX3ZnfcsC832zl7p6HAXlTvw==
X-Received: by 2002:a63:3281:: with SMTP id y123mr6310407pgy.252.1572193670691;
        Sun, 27 Oct 2019 09:27:50 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x26sm8446634pfr.110.2019.10.27.09.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 09:27:49 -0700 (PDT)
Subject: Re: [PATCH 1/1] io_uring: remove index from sqe_submit
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b92e51e7ee180f1e31bfef808d8e20535c921f46.1572191466.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f7b3f055-94da-946e-6a8a-588b24ad9123@kernel.dk>
Date:   Sun, 27 Oct 2019 10:27:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b92e51e7ee180f1e31bfef808d8e20535c921f46.1572191466.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/19 9:52 AM, Pavel Begunkov wrote:
> submit->index is used only for inbound check in submission path (i.e.
> head < ctx->sq_entries). However, it always will be true, as
> 1. it's already validated by io_get_sqring()
> 2. ctx->sq_entries can't be changedd inbetween, because of held
> ctx->uring_lock and ctx->refs.

Applied, thanks.

-- 
Jens Axboe

