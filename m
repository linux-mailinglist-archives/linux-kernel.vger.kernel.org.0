Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9D010309A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 01:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfKTAPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 19:15:25 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:50208 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTAPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 19:15:24 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1iXDeU-0006sP-00; Wed, 20 Nov 2019 00:15:22 +0000
Date:   Tue, 19 Nov 2019 19:15:22 -0500
From:   Rich Felker <dalias@libc.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     musl@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: getdents64 lost direntries with SMB/NFS and buffer size < unknown
 threshold
Message-ID: <20191120001522.GA25139@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An issue was reported today on the Alpine Linux tracker at
https://gitlab.alpinelinux.org/alpine/aports/issues/10960 regarding
readdir results from SMB/NFS shares with musl libc.

After a good deal of analysis, we determined the root cause to be that
the second and subsequent calls to getdents64 are dropping/skipping
direntries (that have not yet been deleted) when some entries were
deleted following the previous call. The issue appears to happen only
when the buffer size passed to getdents64 is below some threshold
greater than 2k (the size musl uses) but less than 32k (the size glibc
uses, with which we were unable to reproduce the issue).

My guess at the mechanism of failure is that the kernel has cached
some entries which it obtained from the FS server based on whatever
its preferred transfer size is, but didn't yet pass them to userspace
due to limited buffer space, and then purged the buffer when resuming
getdents64 after some entries were deleted for reasons related to the
changes made way back in 0c0308066ca5 (NFS: Fix spurious readdir
cookie loop messages). If so, any such purge likely needs to be
delayed until already-buffered results are read, and there may be
related buggy interactions with seeking that need to be examined.

The to/cc for this message are just my best guesses. Please cc anyone
I missed who should be included when replying, and keep me on cc since
I'm not subscribed to any of these lists but the musl one.

Rich
