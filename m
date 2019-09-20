Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E85E9B918A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 16:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbfITOUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 10:20:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:59714 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbfITOUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:20:30 -0400
Received: from [172.16.24.104]
        by relay.sw.ru with esmtp (Exim 4.92.2)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1iBJlo-0006am-HJ; Fri, 20 Sep 2019 17:20:24 +0300
Subject: Re: [PATCH] mm, memcg: assign shrinker_map before kvfree
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20190920122907.GG2507@uranus.lan>
 <20190920132114.ofzphp53vqqjb3fs@box>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <55c22ce3-5e42-f7a1-3861-8e0cb73d26de@virtuozzo.com>
Date:   Fri, 20 Sep 2019 17:20:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190920132114.ofzphp53vqqjb3fs@box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.2019 16:21, Kirill A. Shutemov wrote:
> On Fri, Sep 20, 2019 at 03:29:07PM +0300, Cyrill Gorcunov wrote:
>> Currently there is a small gap between fetching pointer, calling
>> kvfree and assign its value to nil. In current callgraph it is
>> not a problem (since memcg_free_shrinker_maps is running from
>> memcg_alloc_shrinker_maps and mem_cgroup_css_free only) still
>> this looks suspicious and we can easily eliminate the gap at all.
> 
> With this logic it will still look suspicious since you don't wait a grace
> period before freeing the map.

This freeing occurs in the moment, when nobody can dereference shrinker_map
in parallel:

memcg is either not yet online or its css->refcnt is already dead.
This NULLifying is needed just to prevent double freeing of shrinker_map.

Please, see the explanation in my email to our namesake.

Kirill
