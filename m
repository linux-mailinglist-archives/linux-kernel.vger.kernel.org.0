Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C44B364C18
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 20:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfGJSaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 14:30:06 -0400
Received: from relay.sw.ru ([185.231.240.75]:47678 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfGJSaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:30:04 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hlHLb-0006Lj-N7; Wed, 10 Jul 2019 21:29:43 +0300
Subject: Re: [PATCH v5 0/5] Add object validation in ksize()
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Qian Cai <cai@lca.pw>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        kbuild test robot <lkp@intel.com>
References: <20190708170706.174189-1-elver@google.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <75963ba0-7ed2-9e4a-171b-d2cb5d16af2b@virtuozzo.com>
Date:   Wed, 10 Jul 2019 21:29:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708170706.174189-1-elver@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/19 8:07 PM, Marco Elver wrote:
> This version fixes several build issues --
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Previous version here:
> http://lkml.kernel.org/r/20190627094445.216365-1-elver@google.com
> 
> Marco Elver (5):
>   mm/kasan: Introduce __kasan_check_{read,write}
>   mm/kasan: Change kasan_check_{read,write} to return boolean
>   lib/test_kasan: Add test for double-kzfree detection
>   mm/slab: Refactor common ksize KASAN logic into slab_common.c
>   mm/kasan: Add object validation in ksize()
> 

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
