Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E26914E7E3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 05:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgAaEbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 23:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbgAaEbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 23:31:02 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A9D2063A;
        Fri, 31 Jan 2020 04:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580445060;
        bh=uZiWpwqhJJIFoOh6oOyrVhIO6+ps2kiDc/pFktYcI74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g1ia/UUV3GOxmpxdGkHgkzKuoKrrAdkMFIURLpFGuzYyF29UdBvSL13o8lSLUd2ob
         Ud1vo4HGjgXitj5QOkXrx6ptgMfb7i0usRDdFRh+povAp9c09UyOLA0AUW4qNCc9Cq
         62jADYgFGn+av/WzqtOmTCEvRVYCnxBo/0jtooFU=
Date:   Thu, 30 Jan 2020 20:30:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: [PATCH v1 0/2] mm/page_alloc: memmap_init_zone() cleanups
Message-Id: <20200130203059.32b48bb73bf0c8e9ee8470db@linux-foundation.org>
In-Reply-To: <20200113144035.10848-1-david@redhat.com>
References: <20200113144035.10848-1-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020 15:40:33 +0100 David Hildenbrand <david@redhat.com> wrote:

> Two cleanups for "[PATCH] mm/page_alloc: Skip non present sections on zone
> initialization" [1], whereby one cleanup seems to also be a fix for a
> (theoretial?) kernelcore=mirror case - unless I am messing something up :)
> 

I'm not seeing any acks or reviewed-by's on these two?
