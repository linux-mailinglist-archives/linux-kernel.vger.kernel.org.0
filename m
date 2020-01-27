Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F207D14A83D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 17:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgA0QnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 11:43:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:40624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgA0QnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:43:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3D3DAB0BF;
        Mon, 27 Jan 2020 16:43:18 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH 0/3] parallel 'copy-from' Ops in copy_file_range
Date:   Mon, 27 Jan 2020 16:43:18 +0000
Message-Id: <20200127164321.17468-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As discussed here[1] I'm sending an RFC patchset that does the
parallelization of the requests sent to the OSDs during a copy_file_range
syscall in CephFS.

  [1] https://lore.kernel.org/lkml/20200108100353.23770-1-lhenriques@suse.com/

I've also some performance numbers that I wanted to share. Here's a
description of the very simple tests I've run:

 - create a file with 200 objects in it
   * i.e. tests with different object sizes mean different file sizes
 - drop all caches and umount the filesystem
 - Measure:
   * mount filesystem
   * full file copy (with copy_file_range)
   * umount filesystem

Tests were repeated several times and the average value was used for
comparison.

  DISCLAIMER:
  These numbers are only indicative, and different clusters and client
  configs will for sure show different performance!  More rigorous tests
  would be require to validate these results.

Having as baseline a full read+write (basically, a copy_file_range
operation within a filesystem mounted without the 'copyfrom' option),
here's some values for different object sizes:

			  8M	  4M	  1M	  65k
read+write		100%	100%	100%	 100%
sequential		 51%	 52%	 83%	>100%
parallel (throttle=1)	 51%	 52%	 83%	>100%
parallel (throttle=0)	 17%	 17%	 83%	>100%

Notes:

- 'parallel (throttle=0)' was a test where *all* the requests (i.e. 200
  requests to copy the 200 objects in the file) were sent to the OSDs and
  the wait for requests completion is done at the end only.

- 'parallel (throttle=1)' was just a control test, where the wait for
  completion is done immediately after a request is sent.  It was expected
  to be very similar to the non-optimized ('sequential') tests.

- These tests were executed on a cluster with 40 OSDs, spread across 5
  (bare-metal) nodes.

- The tests with object size of 65k show that copy_file_range definitely
  doesn't scale to files with small object sizes.  '> 100%' actually means
  more than 10x slower.

Measuring the mount+copy+umount masks the actual difference between
different throttle values due to the time spent in mount+umount.  Thus,
there was no real difference between throttle=0 (send all and wait) and
throttle=20 (send 20, wait, send 20, ...).  But here's what I observed
when measuring only the copy operation (4M object size):

read+write		100%
parallel (throttle=1)	 56%
parallel (throttle=5)	 23%
parallel (throttle=10)	 14%
parallel (throttle=20)	  9%
parallel (throttle=5)	  5%

Anyway, I'll still need to revisit patch 0003 as it doesn't follow the
suggestion done by Jeff to *not* add another knob to fine-tune the
throttle value -- this patch adds a kernel parameter for a knob that I
wanted to use in my testing to observe different values of this throttle
limit.

The goal is to probably to drop this patch and do the throttling in patch
0002.  I just need to come up with a decent heuristic.  Jeff's suggestion
was to use rsize/wsize, which are set to 64M by default IIRC.  Somehow I
feel that it should be related to the number of OSDs in the cluster
instead, but I'm not sure how.  And testing these sort of heuristics would
require different clusters, which isn't particularly easy to get.  Anyway,
comments are welcome!

Cheers,
--
Luis

Luis Henriques (3):
  libceph: add non-blocking version of ceph_osdc_copy_from()
  ceph: parallelize all copy-from requests in copy_file_range
  ceph: add module param to throttle 'copy-from2' operations

 fs/ceph/file.c                  | 48 ++++++++++++++++++++++++++--
 fs/ceph/super.c                 |  4 +++
 fs/ceph/super.h                 |  2 ++
 include/linux/ceph/osd_client.h | 14 +++++++++
 net/ceph/osd_client.c           | 55 +++++++++++++++++++++++++--------
 5 files changed, 108 insertions(+), 15 deletions(-)

