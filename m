Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEDCA8C3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 23:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfHMVbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 17:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfHMVbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:31:18 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C9720665;
        Tue, 13 Aug 2019 21:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565731877;
        bh=tjFvWLPSSfcPrnSoEvYPNR+1ax/3i9N/XRtulBqxupU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=elLSkOtT891o1HflqX+iByvvwV+ByIjKKmOU9b3NfLMnPa+9erUcWokJI6XD7ymEU
         7ttmBIX9VYtOUp1ZHrefdIAH/Fihhm2AVf11jHkHeMmAS4U4DpyTMpsY4VCoLMZmW9
         alzjY58nI17Dwzg+5PuPNEm4GPMQO6UQnyFpzSPs=
Date:   Tue, 13 Aug 2019 14:31:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: flush percpu vmevents before releasing
 memcg
Message-Id: <20190813143117.885bef5929813445ef39fa61@linux-foundation.org>
In-Reply-To: <20190812233754.2570543-1-guro@fb.com>
References: <20190812233754.2570543-1-guro@fb.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 16:37:54 -0700 Roman Gushchin <guro@fb.com> wrote:

> Similar to vmstats, percpu caching of local vmevents leads to an
> accumulation of errors on non-leaf levels. This happens because
> some leftovers may remain in percpu caches, so that they are
> never propagated up by the cgroup tree and just disappear into
> nonexistence with on releasing of the memory cgroup.
> 
> To fix this issue let's accumulate and propagate percpu vmevents
> values before releasing the memory cgroup similar to what we're
> doing with vmstats.
> 
> Since on cpu hotplug we do flush percpu vmstats anyway, we can
> iterate only over online cpus.
> 
> Fixes: 42a300353577 ("mm: memcontrol: fix recursive statistics correctness & scalabilty")

No cc:stable?
