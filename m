Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B88C113589F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 12:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgAIL4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 06:56:36 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:37136 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgAIL4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:56:36 -0500
Received: by mail-wm1-f48.google.com with SMTP id f129so2533181wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 03:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AVu7sF9AqXnzaqXtf2hGbb5ay0l2XqpGGLIFiXxAyIY=;
        b=fGZJxz5ZZdsDuPnNzI72vKCQwSJQbH6gxtSVEEfzzIR/S/nfAsKEJY6r331Kz3IrYb
         J0qV8WqnTX7spe5sbsuLyFtR133sbhE71IPcWfOM2md1jbvB1EsSmoUYk6dC/Kk9BOU3
         UQ6FjEkF0HIigGqTTeiq+jaqAhlik9r47SXQTSwidB7TktS0N16xWORqYHCEZjdIRk6w
         QZhpv5nfDeuAFKfebpzwaI0pG4f5sQQVuDAK+sB7F2EFUrLJc4jDYR3b/gXPF7e97pjg
         mw+sS14vpzGOuCrVK/MrJu/wxsM6Kf2DIiAo58B/O5EHlmd/aZauDcK2QfoBChFNDVwR
         0tRQ==
X-Gm-Message-State: APjAAAVHGbHfHgT5aX9H+zgmHI5o/wipK4XHVqthZilSSa5IjVJ6lR+0
        bMpfoiDxjicTA5/HeluwoRvIJw8P
X-Google-Smtp-Source: APXvYqw6vYZl9SKle2x6bZtbsHTReXL6R/DJcOKD9zX3l4RkFkT5xL6AG5K5K9yWMNfMDqwgRFGQeA==
X-Received: by 2002:a1c:1dd7:: with SMTP id d206mr4326511wmd.5.1578570994379;
        Thu, 09 Jan 2020 03:56:34 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id g21sm2573710wmh.17.2020.01.09.03.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 03:56:33 -0800 (PST)
Date:   Thu, 9 Jan 2020 12:56:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: OOM killer not nearly agressive enough?
Message-ID: <20200109115633.GR4951@dhcp22.suse.cz>
References: <20200107204412.GA29562@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107204412.GA29562@amd>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-01-20 21:44:12, Pavel Machek wrote:
> Hi!
> 
> I updated my userspace to x86-64, and now chromium likes to eat all
> the memory and bring the system to standstill.
> 
> Unfortunately, OOM killer does not react:
> 
> I'm now running "ps aux", and it prints one line every 20 seconds or
> more. Do we agree that is "unusable" system? I attempted to do kill
> from other session.

Does sysrq+f help?

> Do we agree that OOM killer should have reacted way sooner?

This is impossible to answer without knowing what was going on at the
time. Was the system threshing over page cache/swap? In other words, is
the system completely out of memory or refaulting the working set all
the time because it doesn't fit into memory?

> Is there something I can tweak to make it behave more reasonably?

PSI based early OOM killing might help. See https://github.com/facebookincubator/oomd
-- 
Michal Hocko
SUSE Labs
