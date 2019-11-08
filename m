Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F736F3EA0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 04:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfKHD6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 22:58:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfKHD6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:58:47 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 553C920679;
        Fri,  8 Nov 2019 03:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573185526;
        bh=/4FwpTjEiM19GdBWykbZ0R2dKe1l5qiWiqL0ug6a+vw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M/b0o7NC4sH1dPlab3zzKCy1u+ul8uhobI/pKFit+sNsWpJ8JyaP0iQI7MO/qKbfy
         94h0sRD2SAIdhdawso330wFvSx0FWS7qJhTX30FOkJkY9OmWpgiZrKpyF40tLLXcD3
         kBFRgQvl1bizzsJjfMl1DlW3ReCHgY2DDWjmg8PA=
Date:   Thu, 7 Nov 2019 19:58:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Tang Chen <tangchen@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v3] mm/memory_hotplug: Fix try_offline_node()
Message-Id: <20191107195845.b0b3921ea146a60d042a8f64@linux-foundation.org>
In-Reply-To: <51bdb854-a60e-d076-5dde-38481bf4a4b1@redhat.com>
References: <20191102120221.7553-1-david@redhat.com>
        <51bdb854-a60e-d076-5dde-38481bf4a4b1@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019 00:14:13 +0100 David Hildenbrand <david@redhat.com> wrote:

> > +	/*
> > +	 * Especially offline memory blocks might not be spanned by the
> > +	 * node. They will get spanned by the node once they get onlined.
> > +	 * However, they link to the node in sysfs and can get onlined later.
> > +	 */
> > +	rc = for_each_memory_block(&nid, check_no_memblock_for_node_cb);
> > +	if (rc)
> >   		return;
> > -	}
> >   
> >   	if (check_cpu_on_node(pgdat))
> >   		return;
> > 
> 
> @Andrew, can you queued this one instead of v1 so we can give this some 
> more testing? Thanks!

Sure.

We have a tested-by but no reviewed-by or acked-by :(

Null pointer derefs are unpopular.  Should we cc:stable?
