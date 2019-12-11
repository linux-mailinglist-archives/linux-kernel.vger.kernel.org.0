Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3AC611A0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 02:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfLKB4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 20:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:32858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfLKB4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:56:13 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A8952073B;
        Wed, 11 Dec 2019 01:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576029373;
        bh=Sk4uVwuwCozaP6GWjot/AfsuSZwy7kGd1tNOFl3HdEE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=viHJWrw6dnBTLNJAlnTTTCXUBPY/AAezOr5ANnkCY1ILOt9belasqE9waKAStsfj2
         lAqdcgsPegyJEOm8LhehFb922rQtjDPpOJO5a1r/t0Pf5NocUn4MSJO4LBSBQPcKLy
         aWwzkSdpOHeZOvFf9ec0D9ACpeedFNUEawVBk5co=
Date:   Tue, 10 Dec 2019 17:56:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ELF: don't copy ELF header around
Message-Id: <20191210175611.d615f21e177d5a550a8926f0@linux-foundation.org>
In-Reply-To: <20191208171242.GA19716@avx2>
References: <20191208171242.GA19716@avx2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Dec 2019 20:12:42 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> ELF header is read into bprm->buf[] by generic execve code.
> 
> Save a memcpy and allocate just one header for the interpreter instead
> of two headers (64 bytes instead of 128 on 64-bit).

Hard to review.  Why were there two copies in the first place?  Because
of the need to modify the caller's version when we do
`loc->elf_ex.e_entry += load_bias', yes?  Any other place?

Local variable `loc' can go away now, yes?
