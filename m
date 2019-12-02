Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5909A10EC19
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 16:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfLBPMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 10:12:21 -0500
Received: from gentwo.org ([3.19.106.255]:39610 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfLBPMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:12:21 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 3EC1F3EF27; Mon,  2 Dec 2019 15:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 3BED73EC03;
        Mon,  2 Dec 2019 15:12:20 +0000 (UTC)
Date:   Mon, 2 Dec 2019 15:12:20 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Yu Zhao <yuzhao@google.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [FIX] slub: Remove kmalloc under list_lock from list_slab_objects()
 V2
In-Reply-To: <20191130150908.06b2646edfa7bdc12a943c25@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1912021511250.15780@www.lameter.com>
References: <20190914000743.182739-1-yuzhao@google.com> <20191108193958.205102-1-yuzhao@google.com> <20191108193958.205102-2-yuzhao@google.com> <alpine.DEB.2.21.1911092024560.9034@www.lameter.com> <20191109230147.GA75074@google.com>
 <alpine.DEB.2.21.1911092313460.32415@www.lameter.com> <20191110184721.GA171640@google.com> <alpine.DEB.2.21.1911111543420.10669@www.lameter.com> <alpine.DEB.2.21.1911111553020.15366@www.lameter.com>
 <20191130150908.06b2646edfa7bdc12a943c25@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Nov 2019, Andrew Morton wrote:

> > Perform the allocation in free_partial() before the list_lock is taken.
>
> No response here?  It looks a lot simpler than the originally proposed
> patch?

Yup. I prefer this one but its my own patch so I cannot Ack this.

