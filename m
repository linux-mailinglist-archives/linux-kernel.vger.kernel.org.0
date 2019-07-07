Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4904860D07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 23:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfGEVOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 17:14:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38402 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfGEVOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 17:14:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id z75so4786089pgz.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/7sZUFxUANgrKwZaqSwAspZ8SITW9fKQroiR42hBGA4=;
        b=AVLZNY7HvgtTqG8qSJ8rrlHa6oPWCJbGkOo2mbSBAGR2f037N3nHVrdjVzuX1S3EjU
         ZQ0sZZzZiuI0eTwfKkwAu/jq5b9Dkt8JOEY7zZO4mw56goXGRJuw326D4ul2HF9s5lV8
         dMGcw+enhA0P7CfZo4PmKHtSDbz2gwMH3eiuKQMh55jEFwBAHg58IfM2LqDIx/w4F17T
         wrXqlFBgLUc41rP45OXQDJ/RvQe2NsZD4qI32c2Z8j9bdJxpp3noP2NhIdCPARd9XZiA
         4sRaNU9lQ3TOZxB6YYQLXxGY73v25TbRHPk20KaJKGnn/4sVKjKUGctf1l1G94rdkjBv
         kBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/7sZUFxUANgrKwZaqSwAspZ8SITW9fKQroiR42hBGA4=;
        b=gNExdGjeBNWrlb5n1AUDhka9zJYtfgadXYeMmrYODzcqaE4FRlIhZ0xVPjJcrmv9rA
         lmOVy9dbaiqoFvekOw2BsDjElyF22dS1M8hUpblmiEAGGvL7v18OGif6e/SjlIOjmJhC
         n3FH3IdX1Mdr4+M2q5kQ/iQJOzRRfrxN383zI31IoJX+GbjaUxXCN6r/cUQdda1NtZq6
         t+o1gQ2YzQQo0L6ylXvE37HNVkeVAtO2gw4rwopsh5h1lGRR/c6LR3lGsWedIX8vlcLy
         Qk5u1wmqwO1A2PDhGENMBUDL/2WjL43Fx8xB8sxoSpWRTp6yHJKgp29BkZtyBzIglB40
         fQ/A==
X-Gm-Message-State: APjAAAVQz9QWZL5ulz4sdaW5Nk+WPvMhckSRqm3PsRoLMJm6Hy3F4VX/
        x3UT0GQc88471FNIfl7BnToXOetZrdBpmw==
X-Google-Smtp-Source: APXvYqz6BDQH4rK2bc0RJgE080Jy2A3c3I0cjWgbYCmxihXtOHdmNBVtvaFKJmtLBWrjVwyQzuR8gw==
X-Received: by 2002:a17:90a:c481:: with SMTP id j1mr7869857pjt.96.1562361288894;
        Fri, 05 Jul 2019 14:14:48 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 27sm8845789pgt.6.2019.07.05.14.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 14:14:48 -0700 (PDT)
Subject: Re: [PATCH v2] blk-iolatency: fix STS_AGAIN handling
To:     Dennis Zhou <dennis@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190705210909.82263-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <084ad6be-7bef-4cf4-eefc-41359a880f01@kernel.dk>
Date:   Fri, 5 Jul 2019 15:14:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705210909.82263-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/19 3:09 PM, Dennis Zhou wrote:
> The iolatency controller is based on rq_qos. It increments on
> rq_qos_throttle() and decrements on either rq_qos_cleanup() or
> rq_qos_done_bio(). a3fb01ba5af0 fixes the double accounting issue where
> blk_mq_make_request() may call both rq_qos_cleanup() and
> rq_qos_done_bio() on REQ_NO_WAIT. So checking STS_AGAIN prevents the
> double decrement.
> 
> The above works upstream as the only way we can get STS_AGAIN is from
> blk_mq_get_request() failing. The STS_AGAIN handling isn't a real
> problem as bio_endio() skipping only happens on reserved tag allocation
> failures which can only be caused by driver bugs and already triggers
> WARN.
> 
> However, the fix creates a not so great dependency on how STS_AGAIN can
> be propagated. Internally, we (Facebook) carry a patch that kills read
> ahead if a cgroup is io congested or a fatal signal is pending. This
> combined with chained bios progagate their bi_status to the parent is
> not already set can can cause the parent bio to not clean up properly
> even though it was successful. This consequently leaks the inflight
> counter and can hang all IOs under that blkg.
> 
> To nip the adverse interaction early, this removes the rq_qos_cleanup()
> callback in iolatency in favor of cleaning up always on the
> rq_qos_done_bio() path.

Looks good, applied for 5.3. Thanks Dennis.

-- 
Jens Axboe

