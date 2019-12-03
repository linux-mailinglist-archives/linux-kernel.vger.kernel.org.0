Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94EA010FB61
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 11:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfLCKHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 05:07:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCKHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XdmrDQOuHXuIfgte9QNr112aIGouu8jBb0/v7TDUy3c=; b=qdwlRf7dDrrc8x2bv9FKsVWbU
        nuKsl3xeiJt44iVM4jknsTxXDavKW+EpuzQzwua3EHI3/wwYjus78ebrmLKWO5b5yTD1faJ1jrdlq
        GeCX1nv51AqbemZOr+8WmopZKh4zKEVwdESEZTTvOnaXIYW47wb+LX8bcE20kfoI6rjpjIqoMaKqA
        Yb1Dfpw5nemL0IvYuNcZeUoEVjm75CMZv/Bc1jB+QHjwWl1Wbcl5OjDTkHH9AQiivO9JDKhDnuHKT
        iiHoDVpnj3/2YDihOWdvtEgkFWlkpYODDbxDLjd+vipusDDuAkqmKzl1G/+UPKFfleKnSO+VK3Lk9
        qnekcf5ZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic55B-0005EO-Sg; Tue, 03 Dec 2019 10:07:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 696103006E3;
        Tue,  3 Dec 2019 11:05:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A16232061BAF9; Tue,  3 Dec 2019 11:06:59 +0100 (CET)
Date:   Tue, 3 Dec 2019 11:06:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191203100659.GA2871@hirez.programming.kicks-ass.net>
References: <20191125230312.GP2889@paulmck-ThinkPad-P72>
 <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191203095521.GH2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203095521.GH2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:55:21AM +0100, Peter Zijlstra wrote:
> @@ -1100,6 +1099,12 @@ void cpuhp_online_idle(enum cpuhp_state state)
>  	if (state != CPUHP_AP_ONLINE_IDLE)
>  		return;
>  
> +	/*
> +	 * Unpark the stopper thread before we start the idle thread; this

s/thread/loop/, _this_ is the idle thread :-)

> +	 * ensures the stopper is always available.
> +	 */
> +	stop_machine_unpark(smp_processor_id());
> +
>  	st->state = CPUHP_AP_ONLINE_IDLE;
>  	complete_ap_thread(st, true);
>  }
