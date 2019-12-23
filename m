Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F09A7129113
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 04:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfLWDFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 22:05:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:43745 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfLWDFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 22:05:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Dec 2019 19:05:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,346,1571727600"; 
   d="scan'208";a="249340513"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 22 Dec 2019 19:05:38 -0800
Date:   Mon, 23 Dec 2019 11:05:38 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND [PATCH] 0/2] mm/mmap.c: reduce subtree gap propagation a
 little
Message-ID: <20191223030538.GA31929@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190828060614.19535-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828060614.19535-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any other comments for these two?

On Wed, Aug 28, 2019 at 02:06:12PM +0800, Wei Yang wrote:
>When insert and delete a vma, it will compute and propagate related subtree
>gap. After some investigation, we can reduce subtree gap propagation a little.
>
>[1]: This one reduce the propagation by update *next* gap after itself, since
>     *next* must be a parent in this case.
>[2]: This one achieve this by unlinking vma from list.
>
>After applying these two patches, test shows it reduce 0.3% function call for
>vma_compute_subtree_gap.
>
>BTW, this series is based on some un-merged cleanup patched.
>
>---
>This version is rebased on current linus tree, whose last commit is
>commit 9e8312f5e160 ("Merge tag 'nfs-for-5.3-3' of
>git://git.linux-nfs.org/projects/trondmy/linux-nfs").
>
>Wei Yang (2):
>  mm/mmap.c: update *next* gap after itself
>  mm/mmap.c: unlink vma before rb_erase
>
> mm/mmap.c | 15 ++++++++-------
> 1 file changed, 8 insertions(+), 7 deletions(-)
>
>-- 
>2.17.1

-- 
Wei Yang
Help you, Help me
