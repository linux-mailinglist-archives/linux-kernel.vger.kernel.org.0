Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 079EEE5027
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 17:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393570AbfJYPaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 11:30:03 -0400
Received: from foss.arm.com ([217.140.110.172]:42216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730267AbfJYPaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:30:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91FF2328;
        Fri, 25 Oct 2019 08:30:02 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EFF63F71A;
        Fri, 25 Oct 2019 08:30:01 -0700 (PDT)
Subject: Re: [QUESTION] Hung task warning while running syzkaller test
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        patrick.bellasi@arm.com, tglx@linutronix.de
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <0d7aa66d-d2b9-775c-56b3-543d132fdb84@huawei.com>
 <1693d19e-56c7-9d6f-8e80-10fe82101cff@arm.com>
 <aa5d0f35-e707-f5e3-251e-f940c0b0232b@huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4ca01869-7997-cfce-edce-e75337d3a6fa@arm.com>
Date:   Fri, 25 Oct 2019 16:29:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <aa5d0f35-e707-f5e3-251e-f940c0b0232b@huawei.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Picked the wrong outgoing smtp setting, sorry about that lovely disclaimer...

On 25/10/2019 13:50, Zhihao Cheng wrote:
> I added config in attachment.
> 
> It will take 5-10 minutes to reproduce on the kernel of the lower version(for example, v4.4). And ftrace may need to be enabled for the latest mainline to reproduce hung_task, it will take several hours.
> 

That sounds fun. I'll try to get that running overnight someday I'm not
running other stuff, though TBH seeing as the freezer is involved I wonder if
it isn't just syzkaller keeping stuff frozen for too long.
