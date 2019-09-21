Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD113B9F16
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 19:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407853AbfIURHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Sep 2019 13:07:02 -0400
Received: from gentwo.org ([3.19.106.255]:54060 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731103AbfIURHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:07:02 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Sep 2019 13:07:02 EDT
Received: by gentwo.org (Postfix, from userid 1002)
        id 546873EEB4; Sat, 21 Sep 2019 17:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 5325B3E86F;
        Sat, 21 Sep 2019 17:00:51 +0000 (UTC)
Date:   Sat, 21 Sep 2019 17:00:51 +0000 (UTC)
From:   cl@linux.com
X-X-Sender: cl@ip-172-31-20-140.us-east-2.compute.internal
To:     David Rientjes <rientjes@google.com>
cc:     Miles Chen <miles.chen@mediatek.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] mm: slub: print_hex_dump() with DUMP_PREFIX_OFFSET
In-Reply-To: <alpine.DEB.2.21.1909210207240.259613@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1909211659470.27404@ip-172-31-20-140.us-east-2.compute.internal>
References: <20190920104849.32504-1-miles.chen@mediatek.com> <alpine.DEB.2.21.1909210207240.259613@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2019, David Rientjes wrote:

> I agree it looks nicer for poisoning, I'm not sure that every caller of
> print_section() is the same, however.  For example trace() seems better
> off as DUMP_PREFIX_ADDRESS since it already specifies the address of the
> object being allocated or freed and offset here wouldn't really be useful,
> no?

The address is printed earlier before the object dump. Maybe that is
sufficient and we could even reduce the number of digits further to have
the display more compact? In this case two hex digits would do the trick.

