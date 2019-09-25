Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAF3BD63D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 04:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633714AbfIYCAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 22:00:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:16413 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394649AbfIYCAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 22:00:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 19:00:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,546,1559545200"; 
   d="scan'208";a="193620694"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 24 Sep 2019 19:00:16 -0700
Date:   Wed, 25 Sep 2019 09:59:57 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: fix function name typo in pmd_read_atomic()
 comment
Message-ID: <20190925015956.GA20295@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190925014453.20236-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925014453.20236-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be honest, I have a question on how this works.

As the comment says, we need to call pmd_read_atomic before using
pte_offset_map_lock to avoid data corruption.

For example, in function swapin_walk_pmd_entry:

    pmd_none_or_trans_huge_or_clear_bad(pmd)
        pmd_read_atomic(pmd)                      ---   1
    pte_offset_map_lock(mm, pmd, ...)             ---   2

At point 1, we are assured the content is intact. While in point 2, we would
read pmd again to calculate the pte address. How we ensure this time the
content is intact? Because pmd_none_or_trans_huge_or_clear_bad() ensures the
pte is stable, so that the content won't be changed?

Thanks for your time in advance.

-- 
Wei Yang
Help you, Help me
