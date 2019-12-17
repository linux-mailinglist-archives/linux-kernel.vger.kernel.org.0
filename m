Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B57123575
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 20:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfLQTOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 14:14:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:55370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfLQTOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:14:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8A1FDADA1;
        Tue, 17 Dec 2019 19:14:34 +0000 (UTC)
Date:   Tue, 17 Dec 2019 11:08:03 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH v3] mm/hugetlb: Defer freeing of huge pages if in
 non-task context
Message-ID: <20191217190803.xs6xkmm4struzmru@linux-p48b>
Mail-Followup-To: Waiman Long <longman@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
References: <20191217170331.30893-1-longman@redhat.com>
 <20191217185557.tgtsvaad24j745gf@linux-p48b>
 <4f7b23c9-6e05-3b71-9a94-f8d494d8b0e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4f7b23c9-6e05-3b71-9a94-f8d494d8b0e1@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019, Waiman Long wrote:

>I could use this helper, but the statement is simple enough to understand.

Yes, but I'm mainly thinking for the sake of anyone looking through
llist users in the future, which can easily miss this when grepping
for example. Anyway, yes probably does not merit a v4 unless akpm wants
to fold it in or something.

Thanks,
Davidlohr
