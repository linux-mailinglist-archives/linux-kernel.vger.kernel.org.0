Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B65B21FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 23:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfEQVuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 17:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfEQVuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:50:51 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AACD2166E;
        Fri, 17 May 2019 21:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558129851;
        bh=XAnihnyM8tPVIS0duJIIenhFswdE2ITYujhIk4/YYXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tztgk972S74ZcA0fIcYynWU2LA6EGW/8HyY1lB7Z8Q+uZTYmr5mdXyxHJCz53nGPN
         0LRMAq2ZvAahbXimeMA4ojr8ed3jGYLdSUCeY8iDqMbVa2nQtEjkF+MxliNjSgYj93
         QqElp0UTIeYT/VIePfTOf4ZQv7nK+VAlzZryhb1c=
Date:   Fri, 17 May 2019 14:50:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, jglisse@redhat.com,
        ldufour@linux.vnet.ibm.com
Subject: Re: [PATCH] mm/dev_pfn: Exclude MEMORY_DEVICE_PRIVATE while
 computing virtual address
Message-Id: <20190517145050.2b6b0afdaab5c3c69a4b153e@linux-foundation.org>
In-Reply-To: <1558089514-25067-1-git-send-email-anshuman.khandual@arm.com>
References: <1558089514-25067-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 16:08:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> The presence of struct page does not guarantee linear mapping for the pfn
> physical range. Device private memory which is non-coherent is excluded
> from linear mapping during devm_memremap_pages() though they will still
> have struct page coverage. Just check for device private memory before
> giving out virtual address for a given pfn.

I was going to give my standard "what are the user-visible runtime
effects of this change?", but...

> All these helper functions are all pfn_t related but could not figure out
> another way of determining a private pfn without looking into it's struct
> page. pfn_t_to_virt() is not getting used any where in mainline kernel.Is
> it used by out of tree drivers ? Should we then drop it completely ?

Yeah, let's kill it.

But first, let's fix it so that if someone brings it back, they bring
back a non-buggy version.

So...  what (would be) the user-visible runtime effects of this change?
