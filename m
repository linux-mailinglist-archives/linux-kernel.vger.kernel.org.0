Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2D12E659
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 14:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgABNIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 08:08:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:51188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbgABNIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 08:08:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EBDE7AD49;
        Thu,  2 Jan 2020 13:08:52 +0000 (UTC)
Date:   Thu, 2 Jan 2020 14:08:46 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, ltp@lists.linux.it,
        lkp@lists.01.org
Subject: Re: [LTP] [iomap] 3af5053534:
 WARNING:at_fs/iomap/buffered-io.c:#iomap_readpages
Message-ID: <20200102130846.GF32710@rei.lan>
References: <20191219134725.GE2760@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219134725.GE2760@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Looks like FALLOC_FL_ZERO_RANGE fails, at least that's where the test
reports wrong bytes in the file.

The source code of the test:

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fallocate/fallocate04.c#L157


-- 
Cyril Hrubis
chrubis@suse.cz
