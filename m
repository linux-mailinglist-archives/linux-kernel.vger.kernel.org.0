Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF76788E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 23:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfHJVHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 17:07:52 -0400
Received: from 68.66.241.172.static.a2webhosting.com ([68.66.241.172]:48738
        "EHLO vps.redhazel.co.uk" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbfHJVHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 17:07:52 -0400
Received: from [192.168.1.66] (unknown [212.159.68.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vps.redhazel.co.uk (Postfix) with ESMTPSA id 1E5011C02B32;
        Sat, 10 Aug 2019 22:07:50 +0100 (BST)
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <CAJuCfpFmOzj-gU1NwoQFmS_pbDKKd2XN=CS1vUV4gKhYCJOUtw@mail.gmail.com>
 <20190806220150.GA22516@cmpxchg.org> <20190807075927.GO11812@dhcp22.suse.cz>
 <20190807205138.GA24222@cmpxchg.org> <20190808114826.GC18351@dhcp22.suse.cz>
 <806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk>
 <20190808163228.GE18351@dhcp22.suse.cz>
 <5FBB0A26-0CFE-4B88-A4F2-6A42E3377EDB@redhazel.co.uk>
 <20190808185925.GH18351@dhcp22.suse.cz>
 <08e5d007-a41a-e322-5631-b89978b9cc20@redhazel.co.uk>
 <20190809085748.GN18351@dhcp22.suse.cz>
From:   ndrw <ndrw.xf@redhazel.co.uk>
Message-ID: <5fcf237c-d270-26e5-e995-02755695b459@redhazel.co.uk>
Date:   Sat, 10 Aug 2019 22:07:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809085748.GN18351@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2019 09:57, Michal Hocko wrote:
> This is a useful feedback! What was your workload? Which kernel version? 

With 16GB zram swap and swappiness=60 I get the avg10 memory PSI numbers 
of about 10 when swap is half filled and ~30 immediately before the 
freeze. Swapping with zram has less effect on system responsiveness 
comparing to swapping to an ssd, so, if combined with the proposed PSI 
triggered OOM killer, this could be a viable solution.

Still, using swap only to make PSI sensing work when triggering OOM 
killer at non-zero available memory would do the job just as well is a 
bit of an overkill. I don't really need these extra few GB or memory, 
just want to get rid of system freezes. Perhaps we could have both 
heuristics.

Best regards,

ndrw


