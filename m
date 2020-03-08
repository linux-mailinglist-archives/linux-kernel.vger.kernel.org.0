Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5BE17D0D4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 02:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCHB6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 20:58:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgCHB6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 20:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sC8gQrUqvjk77AMEkpgTPlQtp+KRWQyDZNoS30Hnuno=; b=h9XGTl4A3PG2USDSzqk1jmV9hw
        S3dWv/eoWLIN3LQSmbb185J+RQb0Xz1LALe6+x6V4QijpKN9mQnZiCjZac4rYimd9Di/8EBsp3s4j
        7D2DOjVI8/ceKBMQ1iFpa+QIliMDGYoEtOjainCuR3QbIKVqkDvsc9KiGXnQFrdTQostIR/BIUTgl
        Hua+b97LbJMvs7gpeZ3b5IgsfzDI+glTb978QRxgeN479eIhiqp6jdmZ3vEmpdky0bTQqN6ecypL9
        m+pljgV89DJUneUJHAgEXntsMzihisOGdesAzSZ3PXIHAj8g9XCqysz0N8Q/Agb/lMizY/5hBXqlN
        jZk7Kc3A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAlCc-0007Ik-NO; Sun, 08 Mar 2020 01:58:02 +0000
Date:   Sat, 7 Mar 2020 17:58:02 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, walken@google.com,
        bp@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com
Subject: Re: [PATCH] mm: mmap: show vm_unmapped_area error log
Message-ID: <20200308015802.GD31215@bombadil.infradead.org>
References: <CGME20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4@epcas1p4.samsung.com>
 <20200304030206.1706-1-jaewon31.kim@samsung.com>
 <5E605749.9050509@samsung.com>
 <20200305202443.8de3598558336b1d75afbba7@linux-foundation.org>
 <5E61EAB6.5080609@samsung.com>
 <20200307154744.acd523831b45efa8d0fc1dfa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307154744.acd523831b45efa8d0fc1dfa@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 03:47:44PM -0800, Andrew Morton wrote:
> On Fri, 6 Mar 2020 15:16:22 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> > Even on 64 bit kernel, the mmap failure can happen for a 32 bit task.
> > Virtual memory space shortage of a task on mmap is reported to userspace
> > as -ENOMEM. It can be confused as physical memory shortage of overall
> > system.

But userspace can trigger this printk.  We don't usually allow printks
under those circumstances, even ratelimited.

