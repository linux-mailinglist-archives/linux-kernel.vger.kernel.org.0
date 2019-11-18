Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09710091F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 17:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKRQXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 11:23:04 -0500
Received: from relay.sw.ru ([185.231.240.75]:57562 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfKRQXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:23:03 -0500
Received: from dhcp-172-16-25-5.sw.ru ([172.16.25.5])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iWjnP-0006u4-8v; Mon, 18 Nov 2019 19:22:35 +0300
Subject: Re: [PATCH v4 1/3] kasan: No KASAN's memmove check if archs don't
 have it.
To:     Nick Hu <nickhu@andestech.com>, glider@google.com,
        dvyukov@google.com, corbet@lwn.net, paul.walmsley@sifive.com,
        palmer@sifive.com, aou@eecs.berkeley.edu, tglx@linutronix.de,
        gregkh@linuxfoundation.org, alankao@andestech.com,
        Anup.Patel@wdc.com, atish.patra@wdc.com,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mm@kvack.org, green.hu@gmail.com
References: <20191028024101.26655-1-nickhu@andestech.com>
 <20191028024101.26655-2-nickhu@andestech.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <73f11f1e-6df7-c217-e05d-049d04717600@virtuozzo.com>
Date:   Mon, 18 Nov 2019 19:22:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191028024101.26655-2-nickhu@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/19 5:40 AM, Nick Hu wrote:
> If archs don't have memmove then the C implementation from lib/string.c is used,
> and then it's instrumented by compiler. So there is no need to add KASAN's
> memmove to manual checks.
> 
> Signed-off-by: Nick Hu <nickhu@andestech.com>
> ---

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
