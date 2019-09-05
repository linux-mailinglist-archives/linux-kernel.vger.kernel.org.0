Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663ECA99EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 07:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbfIEFDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 01:03:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:39092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbfIEFDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:03:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 124C3AEC4;
        Thu,  5 Sep 2019 05:03:16 +0000 (UTC)
Date:   Wed, 4 Sep 2019 22:03:08 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/3] x86,mm/pat: Use generic interval trees
Message-ID: <20190905050308.mfgiha2y2wydxwtx@linux-r8p5>
References: <20190813224620.31005-1-dave@stgolabs.net>
 <20190813224620.31005-2-dave@stgolabs.net>
 <20190821215707.GA99147@google.com>
 <20190822044936.qusm5zgjdf6n5fds@linux-r8p5>
 <20190822181701.zhfdkjbwjh56i3ax@linux-r8p5>
 <CANN689E+xsZWOKFBuv1pkpXO-i4i=Yhg3ebnD++ujz7yfDqwuQ@mail.gmail.com>
 <20190905005234.vse4pm4mw7bogcbp@linux-r8p5>
 <CANN689HnDABO6kyy_+FDJu0tQzVihcdNP9WhEyA1GJJxD_HOrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANN689HnDABO6kyy_+FDJu0tQzVihcdNP9WhEyA1GJJxD_HOrQ@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Sep 2019, Michel Lespinasse wrote:

>Hi Davidlohr,
>
>On Wed, Sep 4, 2019 at 5:52 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>> Ok, so for that I've added the following helper which will make the
>> conversion a bit more straightforward:
>>
>> #define vma_interval_tree_foreach_stab(vma, root, start)
>>        vma_interval_tree_foreach(vma, root, start, start)
>
>Yes, that should help with the conversion :)
>
>> I think this also makes sense as it documents the nature of the lookup.

Because this is a nice helper regardless of the interval tree stuff, I went
ahead and sent a patch as well as the conversion, which is quite trivial,
and hopefully akpm can pick it up for -next; which makes one less patch
to carry when doing the interval tree conversion series.

Thanks,
Davidlohr
