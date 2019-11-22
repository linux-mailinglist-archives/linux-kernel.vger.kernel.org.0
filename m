Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F174F10773F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 19:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfKVSYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 13:24:08 -0500
Received: from gentwo.org ([3.19.106.255]:39248 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfKVSYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:24:07 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 5E5623F3D6; Fri, 22 Nov 2019 18:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 5D7C63EA1E;
        Fri, 22 Nov 2019 18:24:06 +0000 (UTC)
Date:   Fri, 22 Nov 2019 18:24:06 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Pengfei Li <fly@kernel.page>
cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, guro@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
In-Reply-To: <20191123013613.566bb40a.fly@kernel.page>
Message-ID: <alpine.DEB.2.21.1911221823001.10945@www.lameter.com>
References: <20191121151811.49742-1-fly@kernel.page> <1bb37491-72a7-feaa-722d-a5825813a409@redhat.com> <20191122234907.4da3bc81.fly@kernel.page> <alpine.DEB.2.21.1911221551570.10063@www.lameter.com> <20191123013613.566bb40a.fly@kernel.page>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2019, Pengfei Li wrote:

> I'm not sure if I understand what you mean, but since commit
> c9bff3eebc09 ("mm, page_alloc: rip out ZONELIST_ORDER_ZONE"), the
> zonelist is always in "Node" order, so building the nodelist is fine.

Sounds good. Just wonder how the allocations that are constrained to
certain physical addresses (16M via DMA and 4G via DMA32) will work in
that case.

