Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3CE9A3D9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 01:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfHVXdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 19:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfHVXdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:33:07 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16D2E2339F;
        Thu, 22 Aug 2019 23:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566516430;
        bh=fxxrOYIlqSS2AAabfmgkps2lg0LsrpP95HyS47QwquQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WR4Xr/LiXmwcMbud2bhg3CPCNpY/3utY6/8/OtrA5OtzL7AHSPXFqYjD1rYojkqBu
         5BhalLzEkV6nMuDSsK5mRGw/KloE5O4yijuLnwXBS//FhamXeoeW/z6buCBgFyQ4fD
         qpYFV/L0+saum1HWybd/MaUqQrjJniXXhnBQjl0Y=
Date:   Thu, 22 Aug 2019 16:27:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v3 0/3] vmstats/vmevents flushing
Message-Id: <20190822162709.fa100ba6c58e15ea35670616@linux-foundation.org>
In-Reply-To: <20190819230054.779745-1-guro@fb.com>
References: <20190819230054.779745-1-guro@fb.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 16:00:51 -0700 Roman Gushchin <guro@fb.com> wrote:

> v3:
>   1) rearranged patches [2/3] and [3/3] to make [1/2] and [2/2] suitable
>   for stable backporting
> 
> v2:
>   1) fixed !CONFIG_MEMCG_KMEM build by moving memcg_flush_percpu_vmstats()
>   and memcg_flush_percpu_vmevents() out of CONFIG_MEMCG_KMEM
>   2) merged add-comments-to-slab-enums-definition patch in
> 
> Thanks!
> 
> Roman Gushchin (3):
>   mm: memcontrol: flush percpu vmstats before releasing memcg
>   mm: memcontrol: flush percpu vmevents before releasing memcg
>   mm: memcontrol: flush percpu slab vmstats on kmem offlining
> 

Can you please explain why the first two patches were cc:stable but not
the third?

