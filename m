Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D93B15BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 23:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfILVLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 17:11:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43652 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfILVLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:11:20 -0400
Received: by mail-io1-f68.google.com with SMTP id r8so33287701iol.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 14:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=62srlE3SBeqwLg3Pd9NJw2uOwPxjT0FuUEa1NpcJ1xg=;
        b=qWhIUGIbwLqnA77UZ14TIIf9D+cAZjHYn+mhylpeFjNYM7MeVdl9l3Q8gNgt9vowCE
         usvkwZg92ge3+m2sG9Zovwsf5Jdji//d4DgCkyxOA37bKPnG0mwy5iOZ/CbIq1g5hKyp
         tGIbkUstgAac+ynlhNq6+chmBgnlhYfCILlbgnV1xtiLpn7Ppkjsnq7KV9IL5/eh8KqU
         7PfS91T8+D93qqW85sKaeA/+wfgNGB3MYnMzluyNMvQSIu1CwGVlBZxL0iUBGoglKpDQ
         P4aqRniuu1HnlZqcTcF8VQed492BC1B5qlaCgP9krPjUwQRetrnZObRHpo+4DUPI4wy8
         5BqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=62srlE3SBeqwLg3Pd9NJw2uOwPxjT0FuUEa1NpcJ1xg=;
        b=DD2wXnfmT6cOFMalIYIe3u/AkWmXBXf2nL4X6Hi/ihQQDkAbfFdCBPisbBZM/jj/eP
         sDNirO2+aFFau0057x2ItbYrmhE31KFtZJuqeu0s26wFTW1ByYawpLq/XBbKUJ1fcAt+
         nYjGEzrFUfD+lakfFBc6tYL2Rz/TeXOk0jXzkVh/AMwyYjvGd6ecPDMbcF/Sw7TMgRrI
         gEVYvBrphOQEHLElfbRQ23KDJahbNJgh/I8iaG5XwGxdFaAToQWHNBI03VZCeimzZkAG
         FnEJTVqU3M6SCfRAuLEQ02kFAq5nz3+ZhdZqcKn+U+G6nqDiLjQqO22Q2IFkw4+Rrg5b
         A9gg==
X-Gm-Message-State: APjAAAWi6dOpefdw+EeaJuTIoYFeaBrVEiAnWh0XQyN69vkLY9GIXXyU
        beTthUGRc1/14TfswPA1gZkpJg==
X-Google-Smtp-Source: APXvYqxn+KCXBrBfZnrJIz4+Qc8lvkyqM8DtjXHGEMowE6lpWAOAuV9+fPmtupBmcM6xQSJ5JfKnhA==
X-Received: by 2002:a6b:f717:: with SMTP id k23mr6875020iog.210.1568322679426;
        Thu, 12 Sep 2019 14:11:19 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:9f3b:444a:4649:ca05])
        by smtp.gmail.com with ESMTPSA id c15sm22432089ioi.74.2019.09.12.14.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 14:11:18 -0700 (PDT)
Date:   Thu, 12 Sep 2019 15:11:14 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm: correct mask size for slub page->objects
Message-ID: <20190912211114.GA146974@google.com>
References: <20190912004401.jdemtajrspetk3fh@box>
 <20190912023111.219636-1-yuzhao@google.com>
 <20190912094035.vkqnj24bwh33yvia@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912094035.vkqnj24bwh33yvia@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 12:40:35PM +0300, Kirill A. Shutemov wrote:
> On Wed, Sep 11, 2019 at 08:31:08PM -0600, Yu Zhao wrote:
> > Mask of slub objects per page shouldn't be larger than what
> > page->objects can hold.
> > 
> > It requires more than 2^15 objects to hit the problem, and I don't
> > think anybody would. It'd be nice to have the mask fixed, but not
> > really worth cc'ing the stable.
> > 
> > Fixes: 50d5c41cd151 ("slub: Do not use frozen page flag but a bit in the page counters")
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> 
> I don't think the patch fixes anything.

Technically it does. It makes no sense for a mask to have more bits
than the variable that holds the masked value. I had to look up the
commit history to find out why and go through the code to make sure
it doesn't actually cause any problem.

My hope is that nobody else would have to go through the same trouble.

> Yes, we have one spare bit between order and number of object that is not
> used and always zero. So what?
> 
> I can imagine for some microarchitecures accessing higher 16 bits of int
> is cheaper than shifting by 15.

Well, I highly doubt the inconsistency is intended for such
optimization, even it existed.
