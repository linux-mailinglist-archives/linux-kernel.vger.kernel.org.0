Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C475CF53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 14:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGBMXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 08:23:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfGBMXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qKrxyQJ9SgUXm99WAZTTjGGR42eLnd0bh+xx2k6emyg=; b=PI/krrONm2KN5eB0OOM3DxRy7
        VHoHinvVWugAGktCautlN02o/iJrv07CmHH6iiZih8czIKOr14F7lsDpPeB9w9gs7bI47+ad0LLlx
        3XnSTfZ33d49SWRbklND4Xg9O8uVy9IuOisojt/5DZ/VyzKXtZcPqHhpadtBCoB2dmI/PpQJo2LGp
        lK+v7InYtRaACYTvrXQOxFwwN2uL1OfhD70KvgaTM9fFJhd0vjtgHh+oBArZt5c3oiRuyGxKDe1sv
        8kbE/axYsg+jcG9ERYzEyAApM5UeDHbPFpxKI1Xp9NtghLmDkUnLHnhUuX3wOiODrlhmxxUCk2SCL
        pOxr7lrPw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hiHof-0000yN-MT; Tue, 02 Jul 2019 12:23:21 +0000
Date:   Tue, 2 Jul 2019 05:23:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com,
        rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm/vmalloc.c: Rename function __find_vmap_area() for
 readability
Message-ID: <20190702122321.GC1729@bombadil.infradead.org>
References: <20190630075650.8516-1-lpf.vector@gmail.com>
 <20190630075650.8516-4-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630075650.8516-4-lpf.vector@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 30, 2019 at 03:56:48PM +0800, Pengfei Li wrote:
> Rename function __find_vmap_area to __search_va_from_busy_tree to
> indicate that it is searching in the *BUSY* tree.

Wrong preposition; you search _in_ a tree, not _from_ a tree.
