Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A72D1D142
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfENVZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 17:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfENVZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 17:25:29 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5477C20850;
        Tue, 14 May 2019 21:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557869128;
        bh=UZ4GiHlaes+DK9pTRaINLCCHnDA+gTfRjxFFWYfxM7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=in6s4kavbJOqz1htYNcOrmRgNhqbR7debNloGeI2j6UOlezuFCKfAmXN7F5c9pKYh
         uskx6J3YJLPlJeih8oVt5Lw4Q3e7lrzehsr6+Wwm0nz95Kyyi6g1d5+nS7LASkZZ7Q
         xvOsJhAsaMVwkubJO9XAemKPjMf8QHfxQN/hX+ws=
Date:   Tue, 14 May 2019 14:25:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: don't expose page to fast gup before it's ready
Message-Id: <20190514142527.356cb071155cd1077536f3da@linux-foundation.org>
In-Reply-To: <20180109101050.GA83229@google.com>
References: <20180108225632.16332-1-yuzhao@google.com>
        <20180109084622.GF1732@dhcp22.suse.cz>
        <20180109101050.GA83229@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2018 02:10:50 -0800 Yu Zhao <yuzhao@google.com> wrote:

> > Also what prevents reordering here? There do not seem to be any barriers
> > to prevent __SetPageSwapBacked leak after set_pte_at with your patch.
> 
> I assumed mem_cgroup_commit_charge() acted as full barrier. Since you
> explicitly asked the question, I realized my assumption doesn't hold
> when memcg is disabled. So we do need something to prevent reordering
> in my patch. And it brings up the question whether we want to add more
> barrier to other places that call page_add_new_anon_rmap() and
> set_pte_at().

Is a new version of this patch planned?
