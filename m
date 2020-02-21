Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7C2166C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 02:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgBUBfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 20:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbgBUBfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:35:02 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFBB0222C4;
        Fri, 21 Feb 2020 01:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582248901;
        bh=6+kua7juze61hnWFLaQDyc1e9v2NQTjrUfu9hvGFRyk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ai5nYwXadTcx45tmQqfDPNdBmHRKuYTs4LnnfYNiboalPV3Jca6/WcxKoJj2JYuxI
         g4fotCxzuvHLMU98eFfkibrEOkkdSdWmbbIc+L6X/bNyT+IFdh8xVWW/lundiaqE/C
         BsHvKxZvm/2YdG3EsD3JzNxKbYmAKfEbzrzH2iiw=
Date:   Thu, 20 Feb 2020 17:35:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] mm: kmemleak: Use address-of operator on section
 symbols
Message-Id: <20200220173501.0de88326911e41b15e27b62f@linux-foundation.org>
In-Reply-To: <20200220051551.44000-1-natechancellor@gmail.com>
References: <20200220051551.44000-1-natechancellor@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 22:15:51 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:

> Clang warns:
> 
> These are not true arrays, they are linker defined symbols, which are
> just addresses. Using the address of operator silences the warning and
> does not change the resulting assembly with either clang/ld.lld or
> gcc/ld (tested with diff + objdump -Dr).

I guess you forgot to quote the clang output?
