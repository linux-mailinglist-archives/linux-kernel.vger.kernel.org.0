Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45816185C6F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 13:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgCOMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 08:49:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29908 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728410AbgCOMtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 08:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584276560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OSsonxsOiZNbFiJ3BbqH+iAht9WuD/N0Mu4OYGtQOMg=;
        b=QntT3aAgS0M1p9V7aTj/GTjXQdCO3EcNSmlJywNDUKvl17mR4ggOfa2F2f7Y1SyS293OpR
        NMPzlDp2n/ThdIU4ZXbPF1lyY8YcbOCAdTPzbWqoG7noDzSUHSa+fq532VtL5aApCmu0tp
        0bo2Qw76p55MNEIPHyso28eqcgXc+9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-RWYnoOrwMrql9SyLyLw4MQ-1; Sun, 15 Mar 2020 08:49:18 -0400
X-MC-Unique: RWYnoOrwMrql9SyLyLw4MQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 328D9107ACC7;
        Sun, 15 Mar 2020 12:49:17 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5735C10027AF;
        Sun, 15 Mar 2020 12:49:16 +0000 (UTC)
Date:   Sun, 15 Mar 2020 20:49:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        mhocko@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v2] x86/mm: Remove the redundant conditional check
Message-ID: <20200315124913.GA3486@MiWiFi-R3L-srv>
References: <20200311011823.27740-1-bhe@redhat.com>
 <20200314151006.gnkyf4xpqve6b3wx@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314151006.gnkyf4xpqve6b3wx@master>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/20 at 03:10pm, Wei Yang wrote:
> On Wed, Mar 11, 2020 at 09:18:23AM +0800, Baoquan He wrote:
> >In commit f70029bbaacb ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE"),
> >the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY. Before
> >commit f70029bbaacb, CONFIG_HIGHMEM && !CONFIG_MOVABLE_NODE could make
> >(N_MEMORY == N_NORMAL_MEMORY) be true. After commit f70029bbaacb, N_MEMORY
> >doesn't have any chance to be equal to N_NORMAL_MEMORY. So the conditional
> >check in paging_init() doesn't make sense any more. Let's remove it.
> >
> >Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> The change looks good. While I have one question, we set default value for
> N_HIGH_MEMORY. Why we don't clear this too?

This is for x86_64 only, there's no node_state for N_HIGH_MEMORY.

> 
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> 
> >---
> >v1->v2:
> >  Update patch log to make the description clearer per Michal's
> >  suggestion.
> >
> > arch/x86/mm/init_64.c | 3 +--
> > 1 file changed, 1 insertion(+), 2 deletions(-)
> >
> >diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> >index abbdecb75fad..0a14711d3a93 100644
> >--- a/arch/x86/mm/init_64.c
> >+++ b/arch/x86/mm/init_64.c
> >@@ -818,8 +818,7 @@ void __init paging_init(void)
> > 	 *	 will not set it back.
> > 	 */
> > 	node_clear_state(0, N_MEMORY);
> >-	if (N_MEMORY != N_NORMAL_MEMORY)
> >-		node_clear_state(0, N_NORMAL_MEMORY);
> >+	node_clear_state(0, N_NORMAL_MEMORY);
> > 
> > 	zone_sizes_init();
> > }
> >-- 
> >2.17.2
> 
> -- 
> Wei Yang
> Help you, Help me
> 

