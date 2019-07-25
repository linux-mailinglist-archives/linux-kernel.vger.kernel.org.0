Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A395B74F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 15:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfGYN0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 09:26:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:59182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfGYN0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:26:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE695ACD1;
        Thu, 25 Jul 2019 13:26:28 +0000 (UTC)
Date:   Thu, 25 Jul 2019 15:26:27 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, lkp@01.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, ltp@lists.linux.it
Subject: Re: [LTP] 56cbb429d9: ltp.fs_fill.fail
Message-ID: <20190725132617.GA23135@rei.lan>
References: <20190725110944.GA22106@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725110944.GA22106@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> tst_test.c:1161: INFO: Testing on vfat
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> mkfs.vfat: unable to open /dev/loop0: Device or resource busy
> tst_mkfs.c:101: BROK: mkfs.vfat:1: tst_test.c failed with 741

This looks like mkfs.vfat got EBUSY after the loop device was
succesfully umounted.

We do run the test in a loop for several filesystems and the loop
generally does:

next:
	mkfs
	mount
	test
	umount
	goto next;

-- 
Cyril Hrubis
chrubis@suse.cz
