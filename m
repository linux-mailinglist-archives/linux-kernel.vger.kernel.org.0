Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE69475EE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 18:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfFPQ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 12:29:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35065 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfFPQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:29:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so7023047ljh.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ROe9l7rmNkgoXM5ZdfPpWNA4ZJ7+sjLyBm3rIg5S9KA=;
        b=h/sR59wJK+fRC3mRDJUs7YbyyNEHv8XpFqQto+pIOpDJRMFMGXKdTxTZAireTGxWI7
         FiwYLSr2JON5mEQW2DXWE7T8sKIn1R0ReRXD5pwqAVNuRR8sz89cbggeLHCju6kvpUAD
         1ja4b8jol2zMk/o5ykuyNrTYJOMC4nQs3gM6GOvIuLdZHdSfereMItNivftbGHTijBQP
         0UcvIB9QCMSfYiXgJIMozMimRf/z2poqJKiEzgAm8hX4YL94zxvC5YVcufmTAcrCx7mm
         109jh1L0ci4SmEfT27NtHD5LOcG1rXp2M0z8qHkzSJ1Oy6lmw/MYZAwE2vQpbf4O1+ma
         ziJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ROe9l7rmNkgoXM5ZdfPpWNA4ZJ7+sjLyBm3rIg5S9KA=;
        b=ZD141AfCsjAHZNGq7BDWIGJvYIw353KOviROseAuj7cVuq+SauY9si0av2AJmX9RLL
         qaXIydGGY3ZzDawLjOTwWUGQBrQtMSJ2PqQDlzAL+aPaRAUNKCGvPQMZfTbg1QK8mfQq
         Jo7YIJl33KIefD5OZtcCYeHEBjYsaoGS3OJdAdWTvMs25MRpkV+4kWPJF+f005T+nI7I
         ZuXMaoemL2jHB/uJBBdunFk8aJtwI6FfVJG/PkkkHQU7xsZoFfhoc8aUaFwuOgMTngP0
         mECkIGPUPMQwh9dCrEjQzSvJJJXRbdK56qyAlJRvwIL78u/HtCQJ1OqcsgPYqYLbD7gp
         0D2Q==
X-Gm-Message-State: APjAAAUXbcy9OwMi3G3TnVHqcB1INcUSn2pwf6Xdb63LvdfSUiLuDgF7
        L98rjD9vtwcH1exvY42CG/E=
X-Google-Smtp-Source: APXvYqz3gJlQxLnmSB1YMDld8wbounFH1DdB5g8n3krY1uyci2h9hWjnE9Hq3gAA/X85j5ZNacy3cg==
X-Received: by 2002:a2e:93c5:: with SMTP id p5mr22338427ljh.79.1560702583227;
        Sun, 16 Jun 2019 09:29:43 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id 25sm1660372ljv.40.2019.06.16.09.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Jun 2019 09:29:42 -0700 (PDT)
Date:   Sun, 16 Jun 2019 19:29:41 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v7 10/10] mm: reparent memcg kmem_caches on cgroup removal
Message-ID: <20190616162941.aqa4ae5j63nmjlp6@esperanza>
References: <20190611231813.3148843-1-guro@fb.com>
 <20190611231813.3148843-11-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611231813.3148843-11-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:18:13PM -0700, Roman Gushchin wrote:
> Let's reparent non-root kmem_caches on memcg offlining. This allows us
> to release the memory cgroup without waiting for the last outstanding
> kernel object (e.g. dentry used by another application).
> 
> Since the parent cgroup is already charged, everything we need to do
> is to splice the list of kmem_caches to the parent's kmem_caches list,
> swap the memcg pointer, drop the css refcounter for each kmem_cache
> and adjust the parent's css refcounter.
> 
> Please, note that kmem_cache->memcg_params.memcg isn't a stable
> pointer anymore. It's safe to read it under rcu_read_lock(),
> cgroup_mutex held, or any other way that protects the memory cgroup
> from being released.
> 
> We can race with the slab allocation and deallocation paths. It's not
> a big problem: parent's charge and slab global stats are always
> correct, and we don't care anymore about the child usage and global
> stats. The child cgroup is already offline, so we don't use or show it
> anywhere.
> 
> Local slab stats (NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE)
> aren't used anywhere except count_shadow_nodes(). But even there it
> won't break anything: after reparenting "nodes" will be 0 on child
> level (because we're already reparenting shrinker lists), and on
> parent level page stats always were 0, and this patch won't change
> anything.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
