Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7836169857
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 17:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbfGOPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 11:25:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730650AbfGOPZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:25:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C825C8666A;
        Mon, 15 Jul 2019 15:25:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0060E1992C;
        Mon, 15 Jul 2019 15:25:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 15 Jul 2019 17:25:16 +0200 (CEST)
Date:   Mon, 15 Jul 2019 17:25:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        matthew.wilcox@oracle.com, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, rostedt@goodmis.org, kernel-team@fb.com,
        william.kucharski@oracle.com
Subject: Re: [PATCH v7 2/4] uprobe: use original page when all uprobes are
 removed
Message-ID: <20190715152513.GD1222@redhat.com>
References: <20190625235325.2096441-1-songliubraving@fb.com>
 <20190625235325.2096441-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625235325.2096441-3-songliubraving@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 15 Jul 2019 15:25:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25, Song Liu wrote:
>
> This patch allows uprobe to use original page when possible (all uprobes
> on the page are already removed).

I can't review. I do not understand vm enough.

> +	if (!is_register) {
> +		struct page *orig_page;
> +		pgoff_t index;
> +
> +		index = vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
> +		orig_page = find_get_page(vma->vm_file->f_inode->i_mapping,
> +					  index);
> +
> +		if (orig_page) {
> +			if (pages_identical(new_page, orig_page)) {

Shouldn't we at least check PageUptodate?


and I am a bit surprised there is no simple way to unmap the old page
in this case... 

Oleg.

