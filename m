Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4293D1362F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 23:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAIWAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 17:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgAIWAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:00:05 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5B9020656;
        Thu,  9 Jan 2020 22:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578607205;
        bh=q2xLvaGoyKJySIfa5H/56/Txq2IoQyySUYKwsDkm/t4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xFu2sFgSng3Oh5L/QhhdSaFswmLd5QFevFtpMGRKLCTm888o7PTfP8maChh21vsC7
         DpRGSg7PI9jlVTfPXmlCmyH35i3X50uBnufWmH8DhLI1RfSPV40DYz9j6jLSnilPKw
         1aV77MFDW0xD7mz2qoB1WKrrA668O9U9abCx/ug8=
Date:   Thu, 9 Jan 2020 14:00:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Scott Cheloha <cheloha@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>, nathanl@linux.ibm.com,
        ricklind@linux.vnet.ibm.com, mhocko@suse.com,
        Scott Cheloha <cheloha@linux.ibm.com>
Subject: Re: [PATCH v4] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-Id: <20200109140004.d5e6dc581b62d6e078dcca4c@linux-foundation.org>
In-Reply-To: <20200109212516.17849-1-cheloha@linux.vnet.ibm.com>
References: <20191217193238-1-cheloha@linux.vnet.ibm.com>
        <20200109212516.17849-1-cheloha@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Jan 2020 15:25:16 -0600 Scott Cheloha <cheloha@linux.vnet.ibm.com> wrote:

> Searching for a particular memory block by id is an O(n) operation
> because each memory block's underlying device is kept in an unsorted
> linked list on the subsystem bus.
> 
> We can cut the lookup cost to O(log n) if we cache the memory blocks in
> a radix tree.  With a radix tree cache in place both memory subsystem
> initialization and memory hotplug run palpably faster on systems with a
> large number of memory blocks.
> 
> ...
>
> @@ -56,6 +57,13 @@ static struct bus_type memory_subsys = {
>  	.offline = memory_subsys_offline,
>  };
>  
> +/*
> + * Memory blocks are cached in a local radix tree to avoid
> + * a costly linear search for the corresponding device on
> + * the subsystem bus.
> + */
> +static RADIX_TREE(memory_blocks, GFP_KERNEL);

What protects this tree from racy accesses?
