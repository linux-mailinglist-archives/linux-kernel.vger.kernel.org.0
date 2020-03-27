Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19ACC195026
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 05:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgC0Esb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 00:48:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:47186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgC0Esb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 00:48:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 033EFAE87;
        Fri, 27 Mar 2020 04:48:29 +0000 (UTC)
Date:   Thu, 26 Mar 2020 21:46:47 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v2 07/10] mmap locking API: add mmap_read_release() and
 mmap_read_unlock_non_owner()
Message-ID: <20200327044647.wgfsmjy37n72dixe@linux-p48b>
Mail-Followup-To: Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Markus Elfring <Markus.Elfring@web.de>
References: <20200327021058.221911-1-walken@google.com>
 <20200327021058.221911-8-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200327021058.221911-8-walken@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020, Michel Lespinasse wrote:

>Add a couple APIs to allow splitting mmap_read_unlock() into two calls:
>- mmap_read_release(), called by the task that had taken the mmap lock;
>- mmap_read_unlock_non_owner(), called from a work queue.
>
>These apis are used by kernel/bpf/stackmap.c only.

I'm not crazy about the idea generalizing such calls into an mm api.
We try to stay away from non-owner semantics in locking - granted
the IS_ENABLED(CONFIG_PREEMPT_RT) warning, but still.

Could this give future users the wrong impression? What about just
using rwsem calls directly in bpf?

Thanks,
Davidlohr
