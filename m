Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C126D8BB20
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 16:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfHMOF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 10:05:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:37122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729331AbfHMOFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:05:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06D4CADF1;
        Tue, 13 Aug 2019 14:05:53 +0000 (UTC)
Date:   Tue, 13 Aug 2019 16:05:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        mgorman@techsingularity.net, dan.j.williams@intel.com,
        osalvador@suse.de, richard.weiyang@gmail.com, hannes@cmpxchg.org,
        arunks@codeaurora.org, rppt@linux.vnet.ibm.com, jgg@ziepe.ca,
        amir73il@gmail.com, alexander.h.duyck@linux.intel.com,
        linux-mm@kvack.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Add predictive memory reclamation and compaction
Message-ID: <20190813140553.GK17933@dhcp22.suse.cz>
References: <20190813014012.30232-1-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813014012.30232-1-khalid.aziz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-08-19 19:40:10, Khalid Aziz wrote:
[...]
> Patch 1 adds code to maintain a sliding lookback window of (time, number
> of free pages) points which can be updated continuously and adds code to
> compute best fit line across these points. It also adds code to use the
> best fit lines to determine if kernel must start reclamation or
> compaction.
> 
> Patch 2 adds code to collect data points on free pages of various orders
> at different points in time, uses code in patch 1 to update sliding
> lookback window with these points and kicks off reclamation or
> compaction based upon the results it gets.

An important piece of information missing in your description is why
do we need to keep that logic in the kernel. In other words, we have
the background reclaim that acts on a wmark range and those are tunable
from the userspace. The primary point of this background reclaim is to
keep balance and prevent from direct reclaim. Why cannot you implement
this or any other dynamic trend watching watchdog and tune watermarks
accordingly? Something similar applies to kcompactd although we might be
lacking a good interface.
-- 
Michal Hocko
SUSE Labs
