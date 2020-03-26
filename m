Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89471945E8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 18:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgCZR4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 13:56:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43186 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgCZR4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:56:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id a5so6177097qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7EsDrc+uddu8fCsgx5Mn3RBL0Ax2XMgO8dGY0tetl+Y=;
        b=dN59iMRichhjpk+p6gNGfCh3Bi5b5fdJo6VsVQp+5jIxncTt09nOeGlvC2364R1UQK
         28qDEEWtHtLMtsY7Y93uuCwhCsMFEZV8Q9u0MUU3iAo3vwGlKwfSDLcUB52qs4yRathi
         f9CO+e8/8mB5y2D2IAfLdwNEebeGksyBOiEk7Quhwoxe3UekgeHM2XCeTmCHEGDlXhB1
         1Nynj+0GmlvBMCiMrms/ZgfEFlti0bXyE8d9aW/nG1x8JYcAMKbpRQKvyAwByOSrwzmz
         vXf0fTlaPEAJt/c09cexX/WpT1IXFxdToO1zkaR1Th4f68+xwHvNkGmigYnCNClbCcjn
         7isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7EsDrc+uddu8fCsgx5Mn3RBL0Ax2XMgO8dGY0tetl+Y=;
        b=TqfSSiGsFijEALqa5jKi4EbADgtKGEjzHo5YvVzIcpxtRUDwH8d0fMz76suOePwxFa
         cfJFV67lhW0zSWI+ZIauQoblZ525CjLo0EYgRncBi42UWIaqmyr2j6UYq7DXjMuQYhsH
         oSNgOKW6mLFsPLBv5+np5sImyPy16g+YQlQMb4tYcXXhnv2YJ2T/uYWXXTxA8uk5uPVD
         gOe9aI5k5LRPT6bJN4JIgnsm/NeW+qaa5lHq7rEuMj7ypZ4qZMR2zc6hd5261+Zrebvq
         r8IA+y9ilNgI4gCN/Qiy1bNC19xmiSSKNOD6QNsAokbwTPAm1qVFjCoQCd0PHR62AoWt
         HIzA==
X-Gm-Message-State: ANhLgQ2SrWE+IoMO9vJLzO4daqwOmIi7me0dCU6+p2e/dloaw5KZhEQD
        XVxjLgW6aeCS5W1K/UDQd52wfQ==
X-Google-Smtp-Source: ADFU+vtFO1P1ti9pC4GHPpqv/P5o9gR83oARQuqK/vl3mHn0NLf/EG76XzbmagOVQWV+0D9RO7eeeQ==
X-Received: by 2002:ac8:7c92:: with SMTP id y18mr9687720qtv.189.1585245405416;
        Thu, 26 Mar 2020 10:56:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 68sm1880572qkh.75.2020.03.26.10.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 10:56:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHWkG-0002Yj-45; Thu, 26 Mar 2020 14:56:44 -0300
Date:   Thu, 26 Mar 2020 14:56:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
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
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>
Subject: Re: [PATCH 1/8] mmap locking API: initial implementation as rwsem
 wrappers
Message-ID: <20200326175644.GN20941@ziepe.ca>
References: <20200326070236.235835-1-walken@google.com>
 <20200326070236.235835-2-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326070236.235835-2-walken@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 12:02:29AM -0700, Michel Lespinasse wrote:

> +static inline bool mmap_is_locked(struct mm_struct *mm)
> +{
> +	return rwsem_is_locked(&mm->mmap_sem) != 0;
> +}

I've been wondering if the various VM_BUG(rwsem_is_locked()) would be
better as lockdep expressions? Certainly when lockdep is enabled it
should be preferred, IMHO.

So, I think if inlines are to be introduced this should be something
similar to netdev's ASSERT_RTNL which seems to have worked well.

Maybe ASSERT_MMAP_SEM_READ/WRITE/HELD() and do the VM_BUG or
lockdep_is_held as appropriate?

Jason
