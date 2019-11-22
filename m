Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D00A510753E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 16:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKVPx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 10:53:58 -0500
Received: from gentwo.org ([3.19.106.255]:39220 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfKVPx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:53:58 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 5EDB93F3D6; Fri, 22 Nov 2019 15:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 5DE683EBFD;
        Fri, 22 Nov 2019 15:53:57 +0000 (UTC)
Date:   Fri, 22 Nov 2019 15:53:57 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Pengfei Li <fly@kernel.page>
cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, guro@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
In-Reply-To: <20191122234907.4da3bc81.fly@kernel.page>
Message-ID: <alpine.DEB.2.21.1911221551570.10063@www.lameter.com>
References: <20191121151811.49742-1-fly@kernel.page> <1bb37491-72a7-feaa-722d-a5825813a409@redhat.com> <20191122234907.4da3bc81.fly@kernel.page>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019, Pengfei Li wrote:

> I am sorry that I did not make it clear. I want to express this series
> of patches will benefit NUMA systems with multiple nodes.

Ok but that benefit needs to be quantified somehow.

> The main benefit is that it will be more efficient when traversing all
> nodes (for example when performing page reclamation).

And you loose the prioritization of allocations through these different
zones. We create zonelists with a certain sequence of the zones in
order to prefer allocations from certain zones. This is in particular
important for the smaller DMA zones which may be easily exhausted.

