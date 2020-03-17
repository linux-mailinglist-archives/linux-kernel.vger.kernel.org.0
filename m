Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A261188215
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 12:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgCQLVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 07:21:47 -0400
Received: from foss.arm.com ([217.140.110.172]:35960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgCQLVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:21:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE7D71FB;
        Tue, 17 Mar 2020 04:21:45 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF9CC3F534;
        Tue, 17 Mar 2020 04:21:43 -0700 (PDT)
Date:   Tue, 17 Mar 2020 11:21:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Richard Fontana <rfontana@redhat.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/15] arm64: hibernate.c: Create a new function to
 handle cpu_up(sleep_cpu)
Message-ID: <20200317112141.GB632169@arrakis.emea.arm.com>
References: <20200223192942.18420-1-qais.yousef@arm.com>
 <20200223192942.18420-7-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223192942.18420-7-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 07:29:33PM +0000, Qais Yousef wrote:
> In preparation to make cpu_up/down private - move the user in arm64
> hibernate.c to use a new generic function that provides what arm64
> needs.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will@kernel.org>
> CC: Steve Capper <steve.capper@arm.com>
> CC: Richard Fontana <rfontana@redhat.com>
> CC: James Morse <james.morse@arm.com>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Josh Poimboeuf <jpoimboe@redhat.com>
> CC: Ingo Molnar <mingo@kernel.org>
> CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> CC: Nicholas Piggin <npiggin@gmail.com>
> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> CC: Jiri Kosina <jkosina@suse.cz>
> CC: Pavankumar Kondeti <pkondeti@codeaurora.org>
> CC: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
