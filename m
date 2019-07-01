Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53E6842177
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 11:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437747AbfFLJxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 05:53:43 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:43724 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437415AbfFLJxn (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 12 Jun 2019 05:53:43 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 12 Jun 2019 11:53:41 +0200
Received: from suselix (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 12 Jun 2019 07:50:13 +0100
Date:   Wed, 12 Jun 2019 08:50:09 +0200
From:   Andreas Herrmann <aherrmann@suse.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH] block/switching-sched.txt: Update to blk-mq schedulers
Message-ID: <20190612065009.GA11361@suselix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Remove references to CFQ and legacy block layer which are gone.
Update example with what's available under blk-mq.

Signed-off-by: Andreas Herrmann <aherrmann@suse.com>
---
 Documentation/block/switching-sched.txt | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/block/switching-sched.txt b/Documentation/block/switching-sched.txt
index 3b2612e342f1..7977f6fb8b20 100644
--- a/Documentation/block/switching-sched.txt
+++ b/Documentation/block/switching-sched.txt
@@ -13,11 +13,9 @@ you can do so by typing:
 
 # mount none /sys -t sysfs
 
-As of the Linux 2.6.10 kernel, it is now possible to change the
-IO scheduler for a given block device on the fly (thus making it possible,
-for instance, to set the CFQ scheduler for the system default, but
-set a specific device to use the deadline or noop schedulers - which
-can improve that device's throughput).
+It is possible to change the IO scheduler for a given block device on
+the fly to select one of mq-deadline, none, bfq, or kyber schedulers -
+which can improve that device's throughput.
 
 To set a specific scheduler, simply do this:
 
@@ -30,8 +28,8 @@ The list of defined schedulers can be found by simply doing
 a "cat /sys/block/DEV/queue/scheduler" - the list of valid names
 will be displayed, with the currently selected scheduler in brackets:
 
-# cat /sys/block/hda/queue/scheduler
-noop deadline [cfq]
-# echo deadline > /sys/block/hda/queue/scheduler
-# cat /sys/block/hda/queue/scheduler
-noop [deadline] cfq
+# cat /sys/block/sda/queue/scheduler
+[mq-deadline] kyber bfq none
+# echo none >/sys/block/sda/queue/scheduler
+# cat /sys/block/sda/queue/scheduler
+[none] mq-deadline kyber bfq
-- 
2.13.7
