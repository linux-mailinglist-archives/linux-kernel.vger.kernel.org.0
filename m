Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB551128BE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 10:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfLDJ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 04:59:17 -0500
Received: from foss.arm.com ([217.140.110.172]:53790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbfLDJ7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:59:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CE181FB;
        Wed,  4 Dec 2019 01:59:16 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CF193F52E;
        Wed,  4 Dec 2019 01:59:15 -0800 (PST)
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <CAKfTPtAvnLY3brp9iy_aHNu0rMM8nLfgeLc3CXEkMk3bwU1weA@mail.gmail.com>
 <CAKfTPtCvckhXQ97RR5X+QW49RRa0EK8gZV-Ajy8FzVeaw3PccQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <19f58fca-9397-4cbc-9255-04ca30c6aacf@arm.com>
Date:   Wed, 4 Dec 2019 09:59:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCvckhXQ97RR5X+QW49RRa0EK8gZV-Ajy8FzVeaw3PccQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 08:22, Vincent Guittot wrote:
>>>  5.4.0-mainline-11225-g9c5add21ff63 #1252
> 
> Do you have the sha1 that you use for your test ?
> The one above doesn't seem to point on a valid commit in linus/master
> 

That would be https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/db845c-mainline-WIP

There's a db845_defconfig there too which I expect should be used to compile
this kernel.
