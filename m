Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD2A45CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 14:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfFNMW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 08:22:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37746 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfFNMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:22:56 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hblEL-0002pf-BB; Fri, 14 Jun 2019 14:22:53 +0200
Date:   Fri, 14 Jun 2019 14:22:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH] mm/ioremap: Probe platform for p4d huge map support
In-Reply-To: <1560406781-14253-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <alpine.DEB.2.21.1906141422370.1722@nanos.tec.linutronix.de>
References: <1560406781-14253-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019, Anshuman Khandual wrote:

> Finishing up what the commit c2febafc67734a ("mm: convert generic code to
> 5-level paging") started out while levelling up P4D huge mapping support
> at par with PUD and PMD. A new arch call back arch_ioremap_p4d_supported()
> is being added which just maintains status quo (P4D huge map not supported)
> on x86 and arm64.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: x86@kernel.org
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
