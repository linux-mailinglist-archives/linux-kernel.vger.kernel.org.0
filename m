Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB18AE248
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 04:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392684AbfIJCQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 22:16:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34971 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392427AbfIJCQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 22:16:06 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so33190504ion.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 19:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s0zjoo9SPbyn3mwdviPBzOKNzAEbtRRkUdJYEIlsrM8=;
        b=QMvvyOIfmJ8b72UgqfZt+USf5rJhMBxGxpXY31hltr/3Z1sUpbI4yCYBzFvxLinfta
         N766ptEWkXUde2Yf4CiM8hW/ksvxTrsaQZk06jljXmIFBS9WiUv6Y8iE7jVzl909rVZh
         EYHuH4oLMBPNgaCalq9NbS5Uxdx1pQi23IOqcqksnRFTcZkYHQHb2TXrnWlwtl4VDXy0
         0jQ50ujM5J1t6jdfqTj4FeJjCFS1fBwc9InXgufcIZ6/dReeNDNy6XZPUfQMU/niYTeR
         6Hrxwf/IRkOlmFPjCP6FwayaYvtZX3Gzm87t13pvPx4tY1mb3wnKa4NWQcvihsrra6J5
         Uyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s0zjoo9SPbyn3mwdviPBzOKNzAEbtRRkUdJYEIlsrM8=;
        b=HspxZQ3Ev4NdRzh4oypuPF/dKZXVAuvLg+m2cM4mdmGUKD6sTTpJl18qYXf//eRT14
         q26kvPxH81c2MV7VI+KvHm19wHSOIx5d0XTNx9gjY4lqXcOiYgpqbxqcHXtIr3U50Kpn
         RikTDEw/NGP8CiuYlwlbAZ9CTyXlCp3SDDwHQtcJ/o/sX6peE3CPSivt2vGpZP541M7M
         dXitlmFMnC9bLWFaCXugCWFqryoZ+b0TqLi3Jqrdr4oKMMGgjpvi7FJ2tu1Mt3EfywVz
         rOY0pbw4fakbsXeamCYX8e2nL71mkk/XCyiWZJgiNWukrP2SdGqYXZ0u+IeKoElJJUoX
         imtw==
X-Gm-Message-State: APjAAAUZZaBopnxKyRINuCm3OBiCO8MPjE2YFDFc0W8bBBb6vslpvySy
        UvWQPRuKLZWwyZTZ7fJW/Vhagw==
X-Google-Smtp-Source: APXvYqy1bTR2h5IQgYy9MmFm5wRWpSShFSHEK6QI4hje5LSBnukLQ2sJCXKpmJnByre9fpYnDPgkzw==
X-Received: by 2002:a02:c546:: with SMTP id g6mr3736142jaj.59.1568081764686;
        Mon, 09 Sep 2019 19:16:04 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:9f3b:444a:4649:ca05])
        by smtp.gmail.com with ESMTPSA id f7sm13892189ioj.66.2019.09.09.19.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 19:16:04 -0700 (PDT)
Date:   Mon, 9 Sep 2019 20:16:00 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: avoid slub allocation while holding list_lock
Message-ID: <20190910021600.GA28048@google.com>
References: <e5e25aa3-651d-92b4-ac82-c5011c66a7cb@I-love.SAKURA.ne.jp>
 <20190909213938.GA53078@google.com>
 <201909100141.x8A1fVdu048305@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909100141.x8A1fVdu048305@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 10:41:31AM +0900, Tetsuo Handa wrote:
> Yu Zhao wrote:
> > I think we can safely assume PAGE_SIZE is unsigned long aligned and
> > page->objects is non-zero. But if you don't feel comfortable with these
> > assumptions, I'd be happy to ensure them explicitly.
> 
> I know PAGE_SIZE is unsigned long aligned. If someone by chance happens to
> change from "dynamic allocation" to "on stack", get_order() will no longer
> be called and the bug will show up.
> 
> I don't know whether __get_free_page(GFP_ATOMIC) can temporarily consume more
> than 4096 bytes, but if it can, we might want to avoid "dynamic allocation".

With GFP_ATOMIC and ~~__GFP_HIGHMEM, it shouldn't.

> By the way, if "struct kmem_cache_node" is object which won't have many thousands
> of instances, can't we embed that buffer into "struct kmem_cache_node" because
> max size of that buffer is only 4096 bytes?

It seems to me allocation in error path is better than always keeping
a page around. But the latter may still be acceptable given it's done
only when debug is on and, of course, on a per-node scale.
