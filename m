Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0023861E55
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfGHMXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 08:23:35 -0400
Received: from swift.blarg.de ([138.201.185.127]:46195 "EHLO swift.blarg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbfGHMXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:23:35 -0400
Received: by swift.blarg.de (Postfix, from userid 1000)
        id B855D402B5; Mon,  8 Jul 2019 14:23:33 +0200 (CEST)
Date:   Mon, 8 Jul 2019 14:23:33 +0200
From:   Max Kellermann <max@blarg.de>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Kernel 5.1.15 stuck in compaction
Message-ID: <20190708122333.GA11407@swift.blarg.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20190708103543.GA10364@swift.blarg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708103543.GA10364@swift.blarg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/07/08 12:35, Max Kellermann <max@blarg.de> wrote:
> one of our web servers got repeatedly stuck in the memory compaction
> code; two PHP processes have been busy at 100% inside memory
> compaction after a page fault:

This trace maybe helpful as well; the first PHP process:

   275.846 compaction:mm_compaction_isolate_migratepages:range=(0x8a48e0 ~ 0x8a48e0) nr_scanned=0 nr_taken=0
LOST 8 events!
   275.894 compaction:mm_compaction_isolate_migratepages:range=(0x8a48e0 ~ 0x8a48e0) nr_scanned=0 nr_taken=0
LOST 8 events!
   275.942 compaction:mm_compaction_isolate_migratepages:range=(0x8a48e0 ~ 0x8a48e0) nr_scanned=0 nr_taken=0
LOST 8 events!
   275.989 compaction:mm_compaction_isolate_migratepages:range=(0x8a48e0 ~ 0x8a48e0) nr_scanned=0 nr_taken=0

This is the other PHP process:

   188.501 compaction:mm_compaction_isolate_migratepages:range=(0x169f40 ~ 0x169f40) nr_scanned=0 nr_taken=0
LOST 16 events!
   188.600 compaction:mm_compaction_isolate_migratepages:range=(0x169f40 ~ 0x169f40) nr_scanned=0 nr_taken=0
LOST 5 events!
   188.643 compaction:mm_compaction_isolate_migratepages:range=(0x169f40 ~ 0x169f40) nr_scanned=0 nr_taken=0
LOST 17 events!
   188.742 compaction:mm_compaction_isolate_migratepages:range=(0x169f40 ~ 0x169f40) nr_scanned=0 nr_taken=0

No pages are being scanned at all, start and end are the same.

However, since my perf report contains calls to
compact_unlock_should_abort(), this means that the loop in
isolate_migratepages_block() is not getting skipped completely,
therefore the loop is just exiting too early.
