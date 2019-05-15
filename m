Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2959F1F687
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 16:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfEOO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 10:28:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53169 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfEOO2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:28:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 139C88553A;
        Wed, 15 May 2019 14:28:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 147181001DD7;
        Wed, 15 May 2019 14:28:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 15 May 2019 16:28:30 +0200 (CEST)
Date:   Wed, 15 May 2019 16:28:28 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use down_read_killable for locking mmap_sem in
 access_remote_vm
Message-ID: <20190515142828.GA18892@redhat.com>
References: <155790847881.2798.7160461383704600177.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155790847881.2798.7160461383704600177.stgit@buzz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 15 May 2019 14:28:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -4348,7 +4348,9 @@ int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
>  	void *old_buf = buf;
>  	int write = gup_flags & FOLL_WRITE;
>  
> -	down_read(&mm->mmap_sem);
> +	if (down_read_killable(&mm->mmap_sem))
> +		return 0;
> +

I too think that "return 0" looks a bit strange even if correct, to me
"return -EINTR" would look better.

But I won't insist, this is cosmetic.

Acked-by: Oleg Nesterov <oleg@redhat.com>

