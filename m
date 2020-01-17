Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 972D11405BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 10:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgAQI6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 03:58:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47304 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgAQI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OABgM1a6oPKPMeWxNxW0wMfzlTQfl0VNtqA25ogfx+g=; b=Ysh+s53aOoIRYLNNUILcKaDl+
        Aoguy2FKXBZj5HHrsD49Dn5UW9PB1JNUuSz3DrbWgS2PInCSz1mnj2zI2ZN7bfuRzSfGlfYCeIHAZ
        SlhjlmsnwZ6a7KwD61/5w5I/xP9muq2knVVaniBrNWUtmZGmSB4JjMcf06eVTqGs1us/qgf6bwDYA
        R2mNeUlZTHBVSUfObvAx0lzS9skI6oeTLZX2FchK4Dud+6ZvZ8tDWseqlZz7xZ4VznSlcRpNWBLkI
        d7zX0KjA5wIZM8BQy+VqFF0B30JoW5otA3XYEmS1/YlCvesoh2kHG4mG86H/hmVDwjzqR+yzEO2bq
        at5skV4oQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isNSl-0004Nb-35; Fri, 17 Jan 2020 08:58:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B23933058B4;
        Fri, 17 Jan 2020 09:57:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDCB020AFB27D; Fri, 17 Jan 2020 09:58:41 +0100 (CET)
Date:   Fri, 17 Jan 2020 09:58:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V3] perf/x86: Consider pinned events for group
 validation
Message-ID: <20200117085841.GW2827@hirez.programming.kicks-ass.net>
References: <1579201225-178031-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579201225-178031-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:00:25AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> perf stat -M metrics relies on weak groups to reject unschedulable
> groups and run them as non-groups.
> This uses the group validation code in the kernel. Unfortunately
> that code doesn't take pinned events, such as the NMI watchdog, into
> account. So some groups can pass validation, but then later still
> never schedule.
> 
> For example,
> 
>  $echo 1 > /proc/sys/kernel/nmi_watchdog
>  $perf stat -M Page_Walks_Utilization
> 
>  Performance counter stats for 'system wide':
> 
>      <not counted>      itlb_misses.walk_pending
> (0.00%)
>      <not counted>      dtlb_load_misses.walk_pending
> (0.00%)
>      <not counted>      dtlb_store_misses.walk_pending
> (0.00%)
>      <not counted>      ept.walk_pending
> (0.00%)
>      <not counted>      cycles
> (0.00%)
> 
>        1.176613558 seconds time elapsed

More unreadable mess.
