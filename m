Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D85D17D3BA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 13:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgCHMgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 08:36:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgCHMgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 08:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=IiyxS/rAQGOWd77kOuqz3QJtfeBB9AA2GpRhunGswrk=; b=EoELTO+UvK8cEeBI7Bq1jfWu3d
        ywOUjGWPVgdIUwlDwHNvAnz7A7jt7sRZESaRxJJYcCovlaqfDMi9D93ABJuzkCf9AawCJ5Y9F+smq
        yrc63tEYVdVPxNUB1bfT9mf+TLYlM83dgg3cnJWkX0hjFFFxhwkB+pfz1epXPfgu6Ml7mHXqS9Spg
        mAyYIkU7fVneJVUfeA3xN04kctD3HoRFMK3LF3RJ0ZMD8+woUpJnSRpOYiblMsuK5kks28grkLnQh
        U0W/z1MxHkm84qjJmknzYr8BtNuqQ0PDIFo+eGZvlKB8nF1zpYsBp3Xpq/1/IuN4aM84T0CuQEm92
        /DgQQZtQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAvAG-0001S6-TK; Sun, 08 Mar 2020 12:36:16 +0000
Date:   Sun, 8 Mar 2020 05:36:16 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, walken@google.com,
        bp@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com
Subject: Re: [PATCH] mm: mmap: show vm_unmapped_area error log
Message-ID: <20200308123616.GH31215@bombadil.infradead.org>
References: <CGME20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4@epcas1p4.samsung.com>
 <20200304030206.1706-1-jaewon31.kim@samsung.com>
 <5E605749.9050509@samsung.com>
 <20200305202443.8de3598558336b1d75afbba7@linux-foundation.org>
 <5E61EAB6.5080609@samsung.com>
 <20200307154744.acd523831b45efa8d0fc1dfa@linux-foundation.org>
 <20200308015802.GD31215@bombadil.infradead.org>
 <5E64C1D7.3000208@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5E64C1D7.3000208@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 06:58:47PM +0900, Jaewon Kim wrote:
> On 2020년 03월 08일 10:58, Matthew Wilcox wrote:
> > On Sat, Mar 07, 2020 at 03:47:44PM -0800, Andrew Morton wrote:
> >> On Fri, 6 Mar 2020 15:16:22 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> >>> Even on 64 bit kernel, the mmap failure can happen for a 32 bit task.
> >>> Virtual memory space shortage of a task on mmap is reported to userspace
> >>> as -ENOMEM. It can be confused as physical memory shortage of overall
> >>> system.
> > But userspace can trigger this printk.  We don't usually allow printks
> > under those circumstances, even ratelimited.
> Hello thank you your comment.
> 
> Yes, userspace can trigger printk, but this was useful for to know why
> a userspace task was crashed. There seems to be still many userspace
> applications which did not check error of mmap and access invalid address.
> 
> Additionally in my AARCH64 Android environment, display driver tries to
> get userspace address to map its display memory. The display driver
> report -ENOMEM from vm_unmapped_area and but also from GPU related
> address space.
> 
> Please let me know your comment again if this debug is now allowed
> in that userspace triggered perspective.

The scenario that worries us is an attacker being able to fill the log
files and so also fill (eg) the /var partition.  Once it's full, future
kernel messages cannot be stored anywhere and so there will be no traces
of their privilege escalation.

Maybe a tracepoint would be a better idea?  Usually they are disabled,
but they can be enabled by a sysadmin to gain insight into why an
application is crashing.
