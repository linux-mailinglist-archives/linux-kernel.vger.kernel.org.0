Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0D9179120
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 14:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbgCDNRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 08:17:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:46286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388094AbgCDNRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:17:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D2757AFF0;
        Wed,  4 Mar 2020 13:17:06 +0000 (UTC)
Subject: Re: SLUB: sysfs lets root force slab order below required minimum,
 causing memory corruption
To:     Jann Horn <jannh@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>
References: <CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <fa479222-5b7a-6f9a-aab0-4e3a8873e3c3@suse.cz>
Date:   Wed, 4 Mar 2020 14:17:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 1:23 AM, Jann Horn wrote:
> Hi!
> 
> FYI, I noticed that if you do something like the following as root,
> the system blows up pretty quickly with error messages about stuff
> like corrupt freelist pointers because SLUB actually allows root to
> force a page order that is smaller than what is required to store a
> single object:
> 
>     echo 0 > /sys/kernel/slab/task_struct/order
> 
> The other SLUB debugging options, like red_zone, also look kind of
> suspicious with regards to races (either racing with other writes to
> the SLUB debugging options, or with object allocations).

Yeah I also wondered last week that there seems to be no sychronization with
alloc/free activity. Increasing order is AFAICS also dangerous with freelist
randomization:

https://lore.kernel.org/linux-mm/d3acc069-a5c6-f40a-f95c-b546664bc4ee@suse.cz/
