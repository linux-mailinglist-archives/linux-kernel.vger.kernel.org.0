Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E26411C06D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 00:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfLKXL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 18:11:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:60021 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfLKXL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:11:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 15:05:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; 
   d="scan'208";a="238734369"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga004.fm.intel.com with ESMTP; 11 Dec 2019 15:05:48 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 608573002C5; Wed, 11 Dec 2019 15:05:48 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] hugetlbfs: Disable softIRQ when taking hugetlb_lock
References: <20191211194615.18502-1-longman@redhat.com>
Date:   Wed, 11 Dec 2019 15:05:48 -0800
In-Reply-To: <20191211194615.18502-1-longman@redhat.com> (Waiman Long's
        message of "Wed, 11 Dec 2019 14:46:15 -0500")
Message-ID: <87a77yv4xf.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:
>
> Currently, only free_huge_page() is known to be called from softIRQ
> context.

Called from a timer?

Perhaps just move that to a work queue instead.

That seems preferable than to increase softirq latency.

-Andi
