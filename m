Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5678BECA0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 09:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfIZHiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 03:38:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:37074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728263AbfIZHiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:38:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C65DEAFE8;
        Thu, 26 Sep 2019 07:38:16 +0000 (UTC)
Date:   Thu, 26 Sep 2019 09:38:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
Message-ID: <20190926073816.GC20255@dhcp22.suse.cz>
References: <1569337401.5576.217.camel@lca.pw>
 <20190924151147.GB23050@dhcp22.suse.cz>
 <1569351244.5576.219.camel@lca.pw>
 <2f8c8099-8de0-eccc-2056-a79d2f97fbf7@redhat.com>
 <1569427262.5576.225.camel@lca.pw>
 <20190925174809.GM23050@dhcp22.suse.cz>
 <1569435659.5576.227.camel@lca.pw>
 <92bce3d4-0a3e-e157-529d-35aafbc30f3b@redhat.com>
 <1569443568.5576.231.camel@lca.pw>
 <17ba6fc6-72ce-992b-7cc4-812acbdedbeb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ba6fc6-72ce-992b-7cc4-812acbdedbeb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-09-19 09:26:13, David Hildenbrand wrote:
[...]
> I'd like to hear what Michal thinks. If we do want the cpu hotplug lock,
> we can at least restrict it to the call paths (e.g., online_pages())
> where the lock is really needed and document that.

Completely agreed. Conflating cpu and memory hotplug locks was a bad
decision. If there are places which need both they should better use
both lock explicitly.

Now, the reality might turn out more complicated due to locks nesting
but hiding the cpu lock into the mem hotplug is just not fixing that.
-- 
Michal Hocko
SUSE Labs
