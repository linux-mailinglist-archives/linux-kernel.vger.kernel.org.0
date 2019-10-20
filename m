Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D192FDE0ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 00:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfJTWvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 18:51:11 -0400
Received: from gentwo.org ([3.19.106.255]:45014 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfJTWvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 18:51:11 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id E10FB3EEDB; Sun, 20 Oct 2019 22:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id DE8FA3EB25;
        Sun, 20 Oct 2019 22:51:10 +0000 (UTC)
Date:   Sun, 20 Oct 2019 22:51:10 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Roman Gushchin <guro@fb.com>
cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 02/16] mm: vmstat: use s32 for vm_node_stat_diff in struct
 per_cpu_nodestat
In-Reply-To: <20191018002820.307763-3-guro@fb.com>
Message-ID: <alpine.DEB.2.21.1910202250010.593@www.lameter.com>
References: <20191018002820.307763-1-guro@fb.com> <20191018002820.307763-3-guro@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019, Roman Gushchin wrote:

> Currently s8 type is used for per-cpu caching of per-node statistics.
> It works fine because the overfill threshold can't exceed 125.
>
> But if some counters are in bytes (and the next commit in the series
> will convert slab counters to bytes), it's not gonna work:
> value in bytes can easily exceed s8 without exceeding the threshold
> converted to bytes. So to avoid overfilling per-cpu caches and breaking
> vmstats correctness, let's use s32 instead.

Actually this is inconsistenct since the other counters are all used to
account for pages. Some of the functions in use for the page counters will
no longer make sense. inc/dec_node_state() etc.
