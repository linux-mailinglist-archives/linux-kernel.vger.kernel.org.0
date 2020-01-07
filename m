Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587FD1327F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 14:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgAGNlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 08:41:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:55816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgAGNlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:41:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 98B1BB1D6;
        Tue,  7 Jan 2020 13:41:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DE4351E0B47; Tue,  7 Jan 2020 14:41:06 +0100 (CET)
Date:   Tue, 7 Jan 2020 14:41:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [ext4] b1b4705d54: filebench.sum_bytes_mb/s -20.2% regression
Message-ID: <20200107134106.GD25547@quack2.suse.cz>
References: <20191224005915.GW2760@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224005915.GW2760@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue 24-12-19 08:59:15, kernel test robot wrote:
> FYI, we noticed a -20.2% regression of filebench.sum_bytes_mb/s due to commit:
> 
> 
> commit: b1b4705d54abedfd69dcdf42779c521aa1e0fbd3 ("ext4: introduce direct I/O read using iomap infrastructure")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: filebench
> on test machine: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: ext4
> 	test: fivestreamreaddirect.f
> 	cpufreq_governor: performance
> 	ucode: 0x27

I was trying to reproduce this but I failed with my test VM. I had SATA SSD
as a backing store though so maybe that's what makes a difference. Maybe
the new code results in somewhat more seeks because the five threads which
compete in submitting sequential IO end up being more interleaved?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
