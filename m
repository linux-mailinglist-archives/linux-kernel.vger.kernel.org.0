Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBA7B0B78
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 11:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbfILJcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 05:32:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:34122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730218AbfILJcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:32:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82A3EAD4B;
        Thu, 12 Sep 2019 09:32:51 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] mm, slab_common: Make the loop for initializing
 KMALLOC_DMA start from 1
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
References: <20190910012652.3723-1-lpf.vector@gmail.com>
 <20190910012652.3723-5-lpf.vector@gmail.com>
 <23cb75f5-4a05-5901-2085-8aeabc78c100@suse.cz>
 <CAD7_sbHZuy4VZJ1KrF6TXmihfxi91Fo0OJMjuET4dpk-F7g6jA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1f1923e7-20a5-71b1-910c-5357a9143317@suse.cz>
Date:   Thu, 12 Sep 2019 11:32:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD7_sbHZuy4VZJ1KrF6TXmihfxi91Fo0OJMjuET4dpk-F7g6jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 4:33 PM, Pengfei Li wrote:
> In the past two days, I am working on what you suggested.

Great!

> So far, I have completed the coding work, but I need some time to make
> sure there are no bugs and verify the impact on performance.

It would probably be hard to measure with sufficient confidence in terms 
of runtime performance, but you could use e.g. ./scripts/bloat-o-meter 
to look for unexpected code increase due to compile-time optimizations 
becoming runtime.
