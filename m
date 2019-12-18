Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3EA8123BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 01:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLRAuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 19:50:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:28939 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfLRAup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:50:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 16:50:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; 
   d="scan'208";a="212750409"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 17 Dec 2019 16:50:43 -0800
Date:   Wed, 18 Dec 2019 08:50:42 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove dead code totalram_pages_set()
Message-ID: <20191218005042.GB23703@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191217064401.18047-1-richardw.yang@linux.intel.com>
 <8456A27B-5F32-4BED-B826-27B17E87AA81@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8456A27B-5F32-4BED-B826-27B17E87AA81@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 07:48:09AM -0500, Qian Cai wrote:
>
>
>> On Dec 17, 2019, at 1:44 AM, Wei Yang <richardw.yang@linux.intel.com> wrote:
>> 
>> No one use totalram_pages_set(), just remote it.
>
>It is unlikely that this is unintentional, but can you figure out which commit removed the last caller just in case?

Took a look into the history. This function is introduced in 

commit 'ca79b0c211af' (mm: convert totalram_pages and totalhigh_pages
variables to atomic)

Even in this commit, no one use this function.

Will include this in next version.

-- 
Wei Yang
Help you, Help me
