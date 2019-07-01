Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A14B22B65D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfE0NZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 09:25:57 -0400
Received: from foss.arm.com ([217.140.101.70]:36434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfE0NZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:25:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67F76374;
        Mon, 27 May 2019 06:25:56 -0700 (PDT)
Received: from [10.0.2.15] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 523903F59C;
        Mon, 27 May 2019 06:25:55 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: fix variable "done" set but not used
To:     Qian Cai <cai@lca.pw>
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org
References: <20190525161821.1025-1-cai@lca.pw>
 <0dd5f59e-bd7e-69d8-e3e8-dbc73820b110@arm.com>
 <090C3AE4-55E4-45F3-AEAB-3E7F26FB7D6D@lca.pw>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <daf5e5ef-80de-5eba-01b7-22e5163678b8@arm.com>
Date:   Mon, 27 May 2019 14:25:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <090C3AE4-55E4-45F3-AEAB-3E7F26FB7D6D@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2019 01:53, Qian Cai wrote:
[...]
>> For some reason I can't get this warning to fire on my end (arm64 defconfig
>> + all the NO_HZ stuff set to nope + GCC 8.1). However I do think there are
>> things we could improve here.
> 
> I like your approach more if it works. The warning can be reproduced by compiling with W=1.
> 

Oh, duh, I thought this one would show up in the regular warnings. I gave it
a spin and the warning does disappear.

[...]
