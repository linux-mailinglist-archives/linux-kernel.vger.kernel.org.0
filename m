Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1720D109050
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 15:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfKYOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 09:46:38 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:54605 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfKYOqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:46:38 -0500
Received: from localhost (unknown [153.3.124.115])
        (Authenticated sender: fly@kernel.page)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DB06A24000E;
        Mon, 25 Nov 2019 14:46:22 +0000 (UTC)
Date:   Mon, 25 Nov 2019 22:46:03 +0800
From:   Pengfei Li <fly@kernel.page>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, fly@kernel.page
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
Message-ID: <20191125224603.688cb69c.fly@kernel.page>
In-Reply-To: <20191125084058.GD31714@dhcp22.suse.cz>
References: <20191121151811.49742-1-fly@kernel.page>
        <20191121180401.GL23213@dhcp22.suse.cz>
        <20191122230543.2f106c80.fly@kernel.page>
        <20191125084058.GD31714@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019 09:40:58 +0100
Michal Hocko <mhocko@kernel.org> wrote:

> On Fri 22-11-19 23:05:43, Pengfei Li wrote:
> > On Thu, 21 Nov 2019 19:04:01 +0100
> > Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > > On Thu 21-11-19 23:17:52, Pengfei Li wrote:
> > > [...]
> > > > Since I don't currently have multiple node NUMA systems, I
> > > > would be grateful if anyone would like to test this series of
> > > > patches.
> > > 
> > > I didn't really get to think about the actual patchset. From a
> > > very quick glance I am wondering whether we need to optimize as
> > > there are usually only small amount of numa nodes. But I am quite
> > > busy so I cannot really do any claims.
> > 
> > Thanks for your comments.
> > 
> > I think it's time to modify the zonelist to nodelist because the
> > zonelist is always in node order and the page reclamation is based
> > on node.
> > 
> > I will do more performance testing to show that multi-node systems
> > will benefit from this series of patches.
> 
> Sensible performance numbers on multiple workloads (ideally some real
> world ones rather than artificial microbenchmarks) is essential for a
> performance optimization that is this large.


Thank you for your suggestion.

But this is probably a bit difficult because I don't have a NUMA server
to do real-world workload testing.

I will do as many performance benchmarks as possible, just like Mel
Gorman's "Move LRU page reclaim from zones to nodes v9"
(https://lwn.net/Articles/694121/).


-- 
Pengfei
