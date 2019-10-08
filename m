Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3576ED011D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 21:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfJHTV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 15:21:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:34880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbfJHTV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:21:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9689BB147;
        Tue,  8 Oct 2019 19:21:25 +0000 (UTC)
Date:   Tue, 8 Oct 2019 21:21:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Kaitao Cheng <pilgrimtao@gmail.com>, akpm@linux-foundation.org,
        sashal@kernel.org, osalvador@suse.de, mgorman@techsingularity.net,
        rppt@linux.ibm.com, dan.j.williams@intel.com,
        alexander.h.duyck@linux.intel.com, pavel.tatashin@microsoft.com,
        glider@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <smuchun@gmail.com>
Subject: Re: [PATCH] mm, page_alloc: drop pointless static qualifier in
 build_zonelists()
Message-ID: <20191008192124.GT6681@dhcp22.suse.cz>
References: <20190927161416.62293-1-pilgrimtao@gmail.com>
 <alpine.DEB.2.21.1910081906120.4398@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910081906120.4398@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-10-19 19:06:57, Cristopher Lameter wrote:
> On Sat, 28 Sep 2019, Kaitao Cheng wrote:
> 
> > There is no need to make the 'node_order' variable static
> > since new value always be assigned before use it.
> 
> In the past MAX_NUMMNODES could become quite large like 512 or 1k. Large
> array allocations on the stack are problematic.
> 
> Maybe that is no longer the case?

CONFIG_NODES_SHIFT=10 is nothing really unusual in distribution kernels.
Likely wasteful for most HW available but a proper way to address it in
this particular case is to use a different data structure than drop the
static modifier which seems to be more of an misunderstanding than an
intention.
-- 
Michal Hocko
SUSE Labs
