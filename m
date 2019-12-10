Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C1118338
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 10:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfLJJO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 04:14:27 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:39412
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726975AbfLJJO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575969266;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=Bihs2AdybKBdG67SkWd4/UgPjHmA0LwZujATTnRCC90=;
        b=HWsxJwLuJM8IKdoAWfFY0jfguXpbg7AswJFxtVbTQoBL7gXx0LOfMDmAv94atnJE
        ya2VooQq8HAqrIbioXr7js7Nok6qR+p2bgqUzsNteH5BVw0oWjT1fVHG3Jpe7EfEJyF
        Ynl4y2mox4f9XbFU6zD6HkaZe71yRpnmDN9dA4YE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575969266;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=Bihs2AdybKBdG67SkWd4/UgPjHmA0LwZujATTnRCC90=;
        b=IlPGUuq832ugehgZwjF8dEBCxXwwFF0sb82NU1Kcwb4u7Fo2scqQrInev8axVT0t
        DbJgaUVgXAbRPT+xIFsVlpLPiO6SamDCPIZuAehG4yj9dQX1UpebmwpBGPu1d+3XDMf
        nsTYJz0CI+WPTqHIKoJLO0LptVSRDcjrpjsB5ieo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABD93C447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 3/3] cpuidle: Trivial fixes
To:     trivial@kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
References: <1571124912-10019-1-git-send-email-mojha@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <0101016eef169bf4-78af1298-f989-42bd-9df4-cfa1aa368467-000000@us-west-2.amazonses.com>
Date:   Tue, 10 Dec 2019 09:14:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571124912-10019-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-SES-Outgoing: 2019.12.10-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle reminder.

On 10/15/2019 1:05 PM, Mukesh Ojha wrote:
> iterrupts => interrupts
> stratight => straight
>
> Minor comment correction.
>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
>   kernel/sched/idle.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 8dad5aa..2df8ae1 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -158,8 +158,8 @@ static void cpuidle_idle_call(void)
>   	/*
>   	 * Suspend-to-idle ("s2idle") is a system state in which all user space
>   	 * has been frozen, all I/O devices have been suspended and the only
> -	 * activity happens here and in iterrupts (if any).  In that case bypass
> -	 * the cpuidle governor and go stratight for the deepest idle state
> +	 * activity happens here is in interrupts (if any).  In that case bypass
> +	 * the cpuidle governor and go straight for the deepest idle state
>   	 * available.  Possibly also suspend the local tick and the entire
>   	 * timekeeping to prevent timer interrupts from kicking us out of idle
>   	 * until a proper wakeup interrupt happens.
