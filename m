Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE7A185D85
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 15:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgCOOUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 10:20:06 -0400
Received: from gentwo.org ([3.19.106.255]:43654 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgCOOUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:20:05 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 1BDDF3F7A9; Sun, 15 Mar 2020 14:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 19C4C3F6EC;
        Sun, 15 Mar 2020 14:20:05 +0000 (UTC)
Date:   Sun, 15 Mar 2020 14:20:05 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
In-Reply-To: <20200311110237.5731-4-srikar@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.21.2003151416230.14449@www.lameter.com>
References: <20200311110237.5731-1-srikar@linux.vnet.ibm.com> <20200311110237.5731-4-srikar@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020, Srikar Dronamraju wrote:

> Currently Linux kernel with CONFIG_NUMA on a system with multiple
> possible nodes, marks node 0 as online at boot.  However in practice,
> there are systems which have node 0 as memoryless and cpuless.

Would it not be better and simpler to require that node 0 always has
memory (and processors)? A  mininum operational set?

We can dynamically number the nodes right? So just make sure that the
firmware properly creates memory on node 0?
