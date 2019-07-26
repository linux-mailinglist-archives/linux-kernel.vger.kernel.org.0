Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1636475F81
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 09:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfGZHMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 03:12:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:43508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbfGZHMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:12:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40D9DB11C;
        Fri, 26 Jul 2019 07:12:20 +0000 (UTC)
Date:   Fri, 26 Jul 2019 09:12:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, vbabka@suse.cz,
        aryabinin@virtuozzo.com, osalvador@suse.de, rostedt@goodmis.org,
        mingo@redhat.com, pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/10] make "order" unsigned int
Message-ID: <20190726071219.GC6142@dhcp22.suse.cz>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
 <1564080768.11067.22.camel@lca.pw>
 <CAD7_sbEXQt0oHuD01BXdW2_=G4h8U8ogHVt0N1Yez2ajFJkShw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD7_sbEXQt0oHuD01BXdW2_=G4h8U8ogHVt0N1Yez2ajFJkShw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-07-19 07:48:36, Pengfei Li wrote:
[...]
> For the benefit, "order" may be negative, which is confusing and weird.

order = -1 has a special meaning.

> There is no good reason not to do this since it can be avoided.

"This is good because we can do it" doesn't really sound like a
convincing argument to me. I would understand if this reduced a
generated code, made an overall code readability much better or
something along those lines. Also we only use MAX_ORDER range of values
so I could argue that a smaller data type (e.g. short) should be
sufficient for this data type.

Please note that _any_ change, alebit seemingly small, can introduce a
subtle bug. Also each patch requires a man power to review so you have
to understand that "just because we can" is not a strong motivation for
people to spend their time on such a patch.
-- 
Michal Hocko
SUSE Labs
