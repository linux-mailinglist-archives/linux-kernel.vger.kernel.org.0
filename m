Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A485148562
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 13:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbgAXMsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 07:48:01 -0500
Received: from foss.arm.com ([217.140.110.172]:51330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387709AbgAXMsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 07:48:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A43A1007;
        Fri, 24 Jan 2020 04:48:01 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE5F93F68E;
        Fri, 24 Jan 2020 04:47:59 -0800 (PST)
Subject: Re: [PATCH 1/3] sched/fair: Add asymmetric CPU capacity wakeup scan
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
References: <20200124124255.1095-1-valentin.schneider@arm.com>
 <20200124124255.1095-2-valentin.schneider@arm.com>
Message-ID: <be0bf60c-c1dd-f5ed-54cf-e7f89e04c0a8@arm.com>
Date:   Fri, 24 Jan 2020 12:47:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200124124255.1095-2-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2020 12:42, Valentin Schneider wrote:
> @@ -5772,7 +5772,7 @@ void __update_idle_core(struct rq *rq)
>   */
>  static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
>  {
> -	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +	struct cpumask *cpus;

ARGH, this is rebase damage and wants to be in select_idle_capacity().
Apologies, let me resend.
