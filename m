Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEBFE04F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 15:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbfJVN2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 09:28:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:39868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387746AbfJVN2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:28:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6EB55ACA0;
        Tue, 22 Oct 2019 13:28:02 +0000 (UTC)
Date:   Tue, 22 Oct 2019 15:28:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 00/16] The new slab memory controller
Message-ID: <20191022132800.GO9379@dhcp22.suse.cz>
References: <20191018002820.307763-1-guro@fb.com>
 <20191022132206.GN9379@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022132206.GN9379@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 15:22:06, Michal Hocko wrote:
> On Thu 17-10-19 17:28:04, Roman Gushchin wrote:
> [...]
> > Using a drgn* script I've got an estimation of slab utilization on
> > a number of machines running different production workloads. In most
> > cases it was between 45% and 65%, and the best number I've seen was
> > around 85%. Turning kmem accounting off brings it to high 90s. Also
> > it brings back 30-50% of slab memory. It means that the real price
> > of the existing slab memory controller is way bigger than a pointer
> > per page.
> 
> How much of the memory are we talking about here?

Just to be more specific. Your cover mentions several hundreds of MBs
but there is no scale to the overal charged memory. How much of that is
the actual kmem accounted memory.

> Also is there any pattern for specific caches that tend to utilize
> much worse than others?

-- 
Michal Hocko
SUSE Labs
