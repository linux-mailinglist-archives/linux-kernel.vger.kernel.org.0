Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 783C497FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 18:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfHUQRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 12:17:15 -0400
Received: from ns.iliad.fr ([212.27.33.1]:51102 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbfHUQRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:17:15 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 1204220467;
        Wed, 21 Aug 2019 18:17:13 +0200 (CEST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id EC69C203E6;
        Wed, 21 Aug 2019 18:17:12 +0200 (CEST)
Subject: Re: [PATCH] mm: consolidate pgtable_cache_init() and pgd_cache_init()
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1566400018-15607-1-git-send-email-rppt@linux.ibm.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <1655e1c9-ad2c-fc31-c517-e3f55995c6b1@free.fr>
Date:   Wed, 21 Aug 2019 18:17:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566400018-15607-1-git-send-email-rppt@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Aug 21 18:17:13 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2019 17:06, Mike Rapoport wrote:

> Both pgtable_cache_init() and pgd_cache_init() are used to initialize kmem
> cache for page table allocations on several architectures that do not use
> PAGE_SIZE tables for one or more levels of the page table hierarchy.
> 
> Most architectures do not implement these functions and use __week default

s/week/weak  ?
