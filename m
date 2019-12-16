Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E779311FB03
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 21:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfLOUSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 15:18:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfLOUSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:18:24 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF42520700;
        Sun, 15 Dec 2019 20:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576441104;
        bh=zFE4EGcQh8WBJGzFWrKMN5N00t3tOMf+3/Nlkl2VYYg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FgbLMTMralCkb9e+jUwjYafHt0Kxfn+LF2Td3S9ChHA4OSQsjgBbT+Fss06C6j2ci
         lhxN91WP/P6/FLvLbTCWLDOD2YZIPHAYjY9c1M7gKMI4ir2Jfo6F4MtjVoJpTuNiqp
         NZ1FNDO2phPsqcj9idSw6Fz3ofjSVJXs0Mils9HI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CCF1F352274B; Sun, 15 Dec 2019 12:18:23 -0800 (PST)
Date:   Sun, 15 Dec 2019 12:18:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Tejun Heo <tj@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lili Deng <Lili.Deng@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Baihua Lu <Baihua.Lu@microsoft.com>
Subject: Re: "rcu: React to callback overload by aggressively seeking
 quiescent states" hangs on boot
Message-ID: <20191215201823.GL2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <BCD69C9E-4E61-405F-A514-36096E0F34F4@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BCD69C9E-4E61-405F-A514-36096E0F34F4@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 02:53:37PM -0500, Qian Cai wrote:
> > On Dec 15, 2019, at 2:18 PM, Dexuan-Linux Cui <dexuan.linux@gmail.com> wrote:
> > We're seeing the same hang issue with a recent Linux next-20191213
> > kernel.  If we revert the same commit 82150cb53dcb ("rcu: React to
> > callback overload by aggressively seeking quiescent states”), the
> > issue will go away.
> 
> Does this patch work for you?
> 
> https://lore.kernel.org/rcu/20191215065242.7155-1-cai@lca.pw

Same question for this one:

https://lore.kernel.org/lkml/20191215201646.GK2889@paulmck-ThinkPad-P72/

							Thanx, Paul
