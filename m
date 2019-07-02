Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39535D418
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 18:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGBQQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 12:16:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:43487 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfGBQQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:16:56 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x62GGb5p021977;
        Tue, 2 Jul 2019 11:16:37 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x62GGZlU021976;
        Tue, 2 Jul 2019 11:16:35 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 2 Jul 2019 11:16:35 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Replaces long number representation by BIT() macro
Message-ID: <20190702161635.GO18316@gate.crashing.org>
References: <20190613180227.29558-1-leonardo@linux.ibm.com> <87imskihvd.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imskihvd.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 01:19:34AM +1000, Michael Ellerman wrote:
> What we could do is switch to the `UL` macro from include/linux/const.h,
> rather than using our own ASM_CONST.

You need gas 2.28 or later for that though.

https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=86b80085
https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=e140100a

What is the minimum required (for powerpc) now?


Segher
