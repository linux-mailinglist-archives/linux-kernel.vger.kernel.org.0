Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40AECE8E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 18:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfJ2RfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 13:35:18 -0400
Received: from relay.sw.ru ([185.231.240.75]:57874 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728024AbfJ2RfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:35:18 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92.2)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iPVOe-0006jr-U1; Tue, 29 Oct 2019 20:35:09 +0300
Subject: Re: [PATCH v10 5/5] kasan debug: track pages allocated for vmalloc
 shadow
To:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, x86@kernel.org, glider@google.com,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191029042059.28541-1-dja@axtens.net>
 <20191029042059.28541-6-dja@axtens.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <79d1efdc-5f11-1c20-9906-0f3cdcd60c20@virtuozzo.com>
Date:   Tue, 29 Oct 2019 20:34:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029042059.28541-6-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/19 7:20 AM, Daniel Axtens wrote:
> Provide the current number of vmalloc shadow pages in
> /sys/kernel/debug/kasan/vmalloc_shadow_pages.
> 

I wouldn't merge this. I don't see use-case for this, besides
testing this patch set. And I think that number should be possible to
extract via page_owner mechanism.
