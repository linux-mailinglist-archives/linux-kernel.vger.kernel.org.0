Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD8B2CE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 20:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfE1SVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 14:21:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:52568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727752AbfE1SVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:21:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33F7CAEA0;
        Tue, 28 May 2019 18:21:33 +0000 (UTC)
Date:   Tue, 28 May 2019 20:21:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@elte.hu>,
        Oscar Salvador <osalvador@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA
 boot
Message-ID: <20190528182132.GH1658@dhcp22.suse.cz>
References: <20190512054829.11899-1-cai@lca.pw>
 <20190513124112.GH24036@dhcp22.suse.cz>
 <1557755039.6132.23.camel@lca.pw>
 <20190513140448.GJ24036@dhcp22.suse.cz>
 <1557760846.6132.25.camel@lca.pw>
 <20190513153143.GK24036@dhcp22.suse.cz>
 <CAFgQCTt9XA9_Y6q8wVHkE9_i+b0ZXCAj__zYU0DU9XUkM3F4Ew@mail.gmail.com>
 <20190522111655.GA4374@dhcp22.suse.cz>
 <CAFgQCTuKVif9gPTsbNdAqLGQyQpQ+gC2D1BQT99d0yDYHj4_mA@mail.gmail.com>
 <CAFgQCTvKZU1B0e4Bg3hQedMJ4Oq2uiOshnsBQCjKinmrGdKcYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTvKZU1B0e4Bg3hQedMJ4Oq2uiOshnsBQCjKinmrGdKcYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-05-19 12:00:46, Pingfan Liu wrote:
[...]
> > Yes, but maybe it will pay great effort on it.
> >
> And as a first step, we can find a way to fix the bug reported by me
> and the one reported by Barret

Can we try http://lkml.kernel.org/r/20190513140448.GJ24036@dhcp22.suse.cz
for starter?
-- 
Michal Hocko
SUSE Labs
