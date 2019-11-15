Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9A9FDA01
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 10:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKOJzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 04:55:20 -0500
Received: from foss.arm.com ([217.140.110.172]:56030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOJzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:55:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87A93328;
        Fri, 15 Nov 2019 01:55:19 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CF503F534;
        Fri, 15 Nov 2019 01:55:18 -0800 (PST)
Subject: Re: [PATCH] sched/uclamp: Fix overzealous type replacement
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Tejun Heo <tj@kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>
References: <20191113165334.14291-1-valentin.schneider@arm.com>
 <CAKfTPtCeGPS57wdyVjA7mnQTW4EeTrd0LX-_1f_+MWp--1FRNQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <b4fd586f-506f-dada-da02-bd5b918b074c@arm.com>
Date:   Fri, 15 Nov 2019 09:55:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCeGPS57wdyVjA7mnQTW4EeTrd0LX-_1f_+MWp--1FRNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2019 08:12, Vincent Guittot wrote:
> 
> And static inline enum uclamp_id uclamp_none(enum uclamp_id clamp_id) ?
> 
> Should it be fixed as well as it can return SCHED_CAPACITY_SCALE ?
> 

Right, thanks for staring at this. I'll go double check the diff and fix up
any strays.
