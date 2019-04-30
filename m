Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA90F28C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 11:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfD3JLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 05:11:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:39018 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfD3JLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:11:44 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hLOnZ-0007Uk-Vy; Tue, 30 Apr 2019 12:11:38 +0300
Subject: Re: [PATCH 3/3] prctl_set_mm: downgrade mmap_sem to read lock
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, rppt@linux.ibm.com,
        vbabka@suse.cz
References: <20190418182321.GJ3040@uranus.lan>
 <20190430081844.22597-1-mkoutny@suse.com>
 <20190430081844.22597-4-mkoutny@suse.com>
 <af8f7958-06aa-7134-c750-b7a994368e89@virtuozzo.com>
 <20190430090808.GC2673@uranus.lan>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <0a48e0a2-a282-159e-a56e-201fbc0faa91@virtuozzo.com>
Date:   Tue, 30 Apr 2019 12:11:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430090808.GC2673@uranus.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.2019 12:08, Cyrill Gorcunov wrote:
> On Tue, Apr 30, 2019 at 11:55:45AM +0300, Kirill Tkhai wrote:
>>> -	up_write(&mm->mmap_sem);
>>> +	spin_unlock(&mm->arg_lock);
>>> +	up_read(&mm->mmap_sem);
>>>  	return error;
>>
>> Hm, shouldn't spin_lock()/spin_unlock() pair go as a fixup to existing code
>> in a separate patch? 
>>
>> Without them, the existing code has a problem at least in get_mm_cmdline().
> 
> Seems reasonable to merge it into patch 1.

Sounds sensibly.

