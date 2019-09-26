Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC1BEE49
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 11:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfIZJS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 05:18:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39200 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbfIZJS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:18:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id a15so1300009edt.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CDj4POLTtLONQOD1mW6qh/tKEDe8bqQ8HYY1swpGKfE=;
        b=mRe5YO4G8ZWDs72D7P3u6F7Lv6nP8HCGl/hZF9xGi0h/w5kli/ohalzTK3vhgQ85Ta
         FmLjSKeXP8SLhWkG3reRO5UE0CYk07FGD7NH4qxlzBG4KSDgvKJwx9w2XnXnXzvOxWy0
         umBDJ0hikAw8jYnaWU3eYfotpDrcN8tfSDlIYEcFLHUwjdkHFtPbCo87P1VYK5YxhIa6
         5KfWua0WnJXtv2HkoUmo9vV1gIW1ZLWaTz5gvz2nINMwW2O7/NkdcHduKtJq9HO7jA+h
         3n+loYyFVKGAwS8GJYJqjf9dQlffXr96tN/O/ZIt0AQ6eyCzubpL7Ie//tkLR4SWJbEA
         KHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CDj4POLTtLONQOD1mW6qh/tKEDe8bqQ8HYY1swpGKfE=;
        b=aDv4rTkY+p5tLZFpe6O1vpkqmvf8j06oLSjifC5jxuMyn9K7DMaht2KW9uLc8GPKdu
         Z2kpv3kxK+JpSpR/9wHaU6Gnx0aZ9kDYvW5RwD6qtP6uczCWQoNXzzzBggTrELmPcP+V
         gKbJY/lQmb2EIlWz8G45vbkIhTjoqoK7avy2gHKV9P3qniu8wZO46ZohWK4+DculgjW+
         6LXwof5O3yBJcQ/KFq1C8sqmYUABvhuiWmEsCmU6NRaCNWp0Nv24Tc3H1xFTC7aQLXAs
         gg9j2qVBjMsfvJxz1vwkMoXc/sBjw82seRdMXb+BebgtFrCnsc4XxecrcVmHAOup+waV
         d3Xw==
X-Gm-Message-State: APjAAAULW+B+4LlK87rtJTSVQm/N+wbhLeR7xtCEeGb59EarBOGPVGkc
        MSm/xzpSvxtgYLSHdZlsviaj8A==
X-Google-Smtp-Source: APXvYqzgllIB6Jnz0BG7fCN17jh9uiP0bMTC7aGkz2PTwEuXyvrijxfgLibrCfQmbfgWv82zBzVvQQ==
X-Received: by 2002:a17:906:79ca:: with SMTP id m10mr2114613ejo.292.1569489534839;
        Thu, 26 Sep 2019 02:18:54 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f21sm350556edt.52.2019.09.26.02.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 02:18:54 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3E923102322; Thu, 26 Sep 2019 12:18:55 +0300 (+03)
Date:   Thu, 26 Sep 2019 12:18:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Qian Cai <cai@lca.pw>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 3/3] mm, page_owner: rename flag indicating that page is
 allocated
Message-ID: <20190926091855.z3wuhk3mnzx57ljf@box>
References: <20190925143056.25853-1-vbabka@suse.cz>
 <20190925143056.25853-4-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925143056.25853-4-vbabka@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 04:30:52PM +0200, Vlastimil Babka wrote:
> Commit 37389167a281 ("mm, page_owner: keep owner info when freeing the page")
> has introduced a flag PAGE_EXT_OWNER_ACTIVE to indicate that page is tracked as
> being allocated.  Kirril suggested naming it PAGE_EXT_OWNER_ALLOCED to make it
		    ^ typo

And PAGE_EXT_OWNER_ALLOCED is my typo. I meant PAGE_EXT_OWNER_ALLOCATED :P

-- 
 Kirill A. Shutemov
