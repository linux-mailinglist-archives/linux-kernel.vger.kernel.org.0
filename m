Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3516AD5BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 09:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfJNHDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 03:03:22 -0400
Received: from foss.arm.com ([217.140.110.172]:35490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfJNHDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:03:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53405142F;
        Mon, 14 Oct 2019 00:03:21 -0700 (PDT)
Received: from iMac-3.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A589C3F718;
        Mon, 14 Oct 2019 00:06:04 -0700 (PDT)
Date:   Mon, 14 Oct 2019 08:03:14 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [REGRESSION] kmemleak: commit c566586818 causes failure to boot
Message-ID: <20191014070312.GA3327@iMac-3.local>
References: <20191014022633.GA6430@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014022633.GA6430@mit.edu>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Sun, Oct 13, 2019 at 10:26:33PM -0400, Theodore Y. Ts'o wrote:
> Commit c566586818 ("mm: kmemleak: use the memory pool for early
> allocations") causes my test kernels to fail to boot on using both kvm
> and using Google Compute Engine.  A git bisect localized it to
> c566586818, and I confirmed by test building v5.4-rc3, which failed as
> above using KVM.  When I reverted c566586818 the kernel booted
> successfully.

Thanks for the report. I have a fix already:

http://lkml.kernel.org/r/20191004134624.46216-1-catalin.marinas@arm.com

I was hoping Andrew had sent it to Linus before -rc3 but it doesn't seem
to be in mainline yet.

Linus, could you please merge the patch above? I can send it again if
it's easier.

Thanks.

-- 
Catalin
