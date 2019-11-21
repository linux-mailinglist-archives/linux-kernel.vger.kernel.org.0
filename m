Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F238F105C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 23:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKUWXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 17:23:11 -0500
Received: from relay.sw.ru ([185.231.240.75]:56126 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfKUWXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 17:23:10 -0500
Received: from [192.168.15.154]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iXuqu-0007wC-R0; Fri, 22 Nov 2019 01:23:04 +0300
Subject: Re: [PATCH v4 2/2] kasan: add test for invalid size in memmove
To:     Walter Wu <walter-zh.wu@mediatek.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191112065313.7060-1-walter-zh.wu@mediatek.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <619b898f-f9c2-1185-5ea7-b9bf21924942@virtuozzo.com>
Date:   Fri, 22 Nov 2019 01:21:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191112065313.7060-1-walter-zh.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/19 9:53 AM, Walter Wu wrote:
> Test negative size in memmove in order to verify whether it correctly
> get KASAN report.
> 
> Casting negative numbers to size_t would indeed turn up as a large
> size_t, so it will have out-of-bounds bug and be detected by KASAN.
> 
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
