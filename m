Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11AB51288B6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 11:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfLUKtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 05:49:22 -0500
Received: from mail.monom.org ([188.138.9.77]:40584 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfLUKtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 05:49:22 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 66EE75005A3;
        Sat, 21 Dec 2019 11:49:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from [192.168.154.174] (b9168f78.cgn.dg-w.de [185.22.143.120])
        by mail.monom.org (Postfix) with ESMTPSA id C057B500518;
        Sat, 21 Dec 2019 11:49:15 +0100 (CET)
Subject: Re: [ANNOUNCE] 4.4.206-rt190
To:     Pavel Machek <pavel@denx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
References: <20191206104701.CC686500518@mail.monom.org>
 <20191216132724.GA22097@amd>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <e2256c5e-826b-3046-de15-7c2599b1444c@monom.org>
Date:   Sat, 21 Dec 2019 11:49:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191216132724.GA22097@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Sorry for the delay.

On 16.12.19 14:27, Pavel Machek wrote:
> Hi!
> 
>> I'm pleased to announce the 4.4.206-rt190 stable release.
>>
>> This release is just an update to the new stable 4.4.206 version
>> and no RT specific changes have been made.
> 
> Thanks!
> 
> I'm getting failures with one of our configs:
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/380509098
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/103388506
> 
> This failure is not new, we have been working around it for a
> while. It can be fixed using:
> 
> git cherry-pick 8409299
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/103395886
> 
> (If you prefer, I can submit patch via email).

We should route this patch via stable. I'll send out the request to 
Greg. Just a sec.

Thanks,
Daniel
