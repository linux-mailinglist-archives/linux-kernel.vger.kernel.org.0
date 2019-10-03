Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 261C1C9A88
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 11:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfJCJNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 05:13:31 -0400
Received: from foss.arm.com ([217.140.110.172]:39098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbfJCJNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:13:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1753028;
        Thu,  3 Oct 2019 02:13:31 -0700 (PDT)
Received: from arrakis.emea.arm.com (unknown [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 501613F739;
        Thu,  3 Oct 2019 02:13:30 -0700 (PDT)
Date:   Thu, 3 Oct 2019 10:13:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Dionne <marc.c.dionne@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: Boot hang with 5.4-rc1, bisected to c5665868183f
Message-ID: <20191003091327.GC21629@arrakis.emea.arm.com>
References: <CAB9dFdtVzo2C_8h+Qe144mrhBRZp5TkdiudwXsfZo5fCAWWj_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB9dFdtVzo2C_8h+Qe144mrhBRZp5TkdiudwXsfZo5fCAWWj_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 07:26:51PM -0300, Marc Dionne wrote:
> 5.4-rc1 hangs early on boot for me; the stack trace that I could
> manage to see on screen suggested something kmemleak related, and it
> was fairly quick to bisect it down to commit c5665868183f ("mm:
> kmemleak: use the memory pool for early allocations").
> 
> Several call stacks periodically go by on screen, an interesting one
> is (manually transcribed):
> 
> RIP: 0010:_raw_write_unlock_irqrestore+0x15/0x20
>   find_and_remove_object+0x84/0x90
>   delete_object_full+0x10/0x20
>   __kmemleak_do_cleanup+0x2d/0x50
>   kmemleak_do_cleanup+0x59/0x60
>   process_one_work+0x1a4/0x3c0
>   worker_thread+0x50/0x3c0
> ...
> 
> Config is attached.

Thanks for the report. This was also mentioned here:

http://lkml.kernel.org/r/2ac37341-097e-17a2-fb6b-7912da9fa38e@ozlabs.ru

I'll have a look. It seems to only happen on the kmemleak disabling
path (I managed to reproduce it as well).

-- 
Catalin
