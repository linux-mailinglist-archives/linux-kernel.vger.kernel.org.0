Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08286D752C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 13:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfJOLhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 07:37:14 -0400
Received: from foss.arm.com ([217.140.110.172]:36598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfJOLhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:37:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97968337;
        Tue, 15 Oct 2019 04:37:13 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76BB93F68E;
        Tue, 15 Oct 2019 04:37:12 -0700 (PDT)
Subject: Re: [PATCH] sched/topology: Don't set SD_BALANCE_WAKE on cpuset
 domain relax
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        seto.hidetoshi@jp.fujitsu.com, qperret@google.com
References: <20191014164408.32596-1-valentin.schneider@arm.com>
 <20191015113410.GG2311@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <86fd060d-fc2f-b9e8-ec14-b4f4627f7c0c@arm.com>
Date:   Tue, 15 Oct 2019 12:37:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015113410.GG2311@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2019 12:34, Peter Zijlstra wrote:
> This 'relax' thing is on my list of regrets. It is a terrible thing that
> should never have existed.
> 
> Are you actually using it or did you just stumble upon it while looking
> around there?
> 

Just staring around, I don't use cpuset stuff unless I really need to...
