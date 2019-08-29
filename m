Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE91AA299E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 00:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfH2WUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 18:20:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42636 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbfH2WUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:20:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so2330256pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GVOqYmM2Y9fBLs59pkcO9sFEhdR0n+gm/H+kyKc15XE=;
        b=wHVCvNK39KHNNY4HF3wY3NkJLZfOQdCUJiXGoeP3T/UDxPop1ECLnAFxcV0rEx8o+V
         JII5v6i7ZKHZbB05yBaZWYkEkvtpXIxCOQ9/Ngr78cCBrGPq2H9YRnlZLgd1JgeB7TzQ
         Mg/ABGmKuMRLYkfv48QYdY2hw5qmbwl+S0vr1J9xwOT8koG0uEqPixqdHtw13NjbG5BJ
         DaUulH0se+pqYeKc75oa4Nn2nZUfEypOub+1sR5ZzZAf8fLFoJFDE8gDt8ujD6W9+ucV
         6UbeWaISsva/vvH4dDm5VeQ30cP4V3iK4XVKpqdzdjq89ujQQl02u4rinAEi2ei8MXW5
         e5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GVOqYmM2Y9fBLs59pkcO9sFEhdR0n+gm/H+kyKc15XE=;
        b=hfNUEcajRKWe4Kq5d4yk3+MzkZLinqD2JiAnroncAvIox1XMBvUbMLLRq8hUVqCDvu
         LGqeqP3ZqauIiuDQN9eckRGZnCBUqjQZdoKYZB34hozVD5XRYi3wGQOSoaA525VDNV9x
         gUvZQPEhkpu3ZoFQ6megvewzpq3sJGs0G858n86BP2J4Kevi4KQGspO46Wdg/TslQ5KQ
         9i7jVQ7c/aRhla9sATx8Y5fpNvF1QxbdsUUnzLMRTzOUcGXF51JWFNifFwkgbphxDBCZ
         eBzhmj292vQwUE5vuiRrAbmmZiQNf9NWG8cop8aD4Pm4QeUhh0c07vUpEeXtcQA9IHMQ
         rOZQ==
X-Gm-Message-State: APjAAAWhJzkV1BRZTs1f22kaw7Q3lWSWdRYAfUONEMVpuwQ8SvtMceuv
        Hf7k932qIRXfXlr49flWI+L0Ew==
X-Google-Smtp-Source: APXvYqxgGNtSETr5KkzHixZs4r45yt16y5jHxbUeBtQDByzuSiKUcb6Zwakv3bXp3jdYqS+grlvf1Q==
X-Received: by 2002:a17:90a:22c9:: with SMTP id s67mr12304024pjc.22.1567117217328;
        Thu, 29 Aug 2019 15:20:17 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e189sm3157869pgc.15.2019.08.29.15.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 15:20:16 -0700 (PDT)
Date:   Thu, 29 Aug 2019 15:20:16 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm, oom: consider present pages for the node size
In-Reply-To: <20190829163443.899-1-mhocko@kernel.org>
Message-ID: <alpine.DEB.2.21.1908291519580.54347@chino.kir.corp.google.com>
References: <20190829163443.899-1-mhocko@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> constrained_alloc calculates the size of the oom domain by using
> node_spanned_pages which is incorrect because this is the full range of
> the physical memory range that the numa node occupies rather than the
> memory that backs that range which is represented by node_present_pages.
> 
> Sparsely populated nodes (e.g. after memory hot remove or simply sparse
> due to memory layout) can have really a large difference between the
> two. This shouldn't really cause any real user observable problems
> because the oom calculates a ratio against totalpages and used memory
> cannot exceed present pages but it is confusing and wrong from code
> point of view.
> 
> Noticed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: David Rientjes <rientjes@google.com>
