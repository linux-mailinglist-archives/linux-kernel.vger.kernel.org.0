Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25EF0739
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 21:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfKEUt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 15:49:58 -0500
Received: from foss.arm.com ([217.140.110.172]:32810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729778AbfKEUt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:49:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFB7E1396;
        Tue,  5 Nov 2019 12:49:56 -0800 (PST)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF3653FB69;
        Tue,  5 Nov 2019 01:02:33 -0800 (PST)
Date:   Tue, 5 Nov 2019 09:02:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Theodore Tso <tytso@mit.edu>, fstests <fstests@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 5.4-rc1 boot regression with kmemleak enabled
Message-ID: <20191105090231.GA1750@mbp>
References: <CAOQ4uxgy6THDG2NsNSQ+=FP+iSZKeCkNEM9PbxQSB5p5nHvoCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgy6THDG2NsNSQ+=FP+iSZKeCkNEM9PbxQSB5p5nHvoCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 09:14:06AM +0200, Amir Goldstein wrote:
> My kvm-xfstests [1] VM doesn't boot with kmemleak enabled since commit
> c5665868183f ("mm: kmemleak: use the memory pool for early allocations").
> 
> There is no console output when running:
> 
> $ kvm -boot order=c -net none -machine type=pc,accel=kvm:tcg -cpu host \
>     -drive file=$ROOTFS,if=virtio,snapshot=on -vga none -nographic \
>     -smp 2 -m 2048 -serial mon:stdio --kernel $KERNEL \
>     --append 'root=/dev/vda console=ttyS0,115200'

This was fixed in 5.4-rc4, see commit 2abd839aa7e6 ("kmemleak: Do not
corrupt the object_list during clean-up").

-- 
Catalin
