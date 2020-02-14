Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315A815D419
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 09:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgBNIvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 03:51:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40264 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgBNIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:51:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so9943083wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 00:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BiCGDfuoCYPdWxIW1M28/Zsd7aXsuFSeGUo4kNitdWo=;
        b=RhupYms3PsvP+sWa+tRS24x/L5K6ZKDy+IYZ7t9e+F5VajtUD+BArhm46zKt0e9gZH
         3iv54ypWFuaVN82Gi99uroO4f1j2O+xU36bFJY4UkHxVvOYEbEAp927A/hpff2MwVSdo
         k7dgUP+9WaHmesl8mXLeqSpXbuWrYMRvtx38dbTFfRdbgiNxyNeYV4TVJTfPxAQNksZz
         vIBboOkzUTchdXu+1RcPlMMcHqtDFUu/q5393xovWVjtKCgL/pAygnQoYSyouwTQJmJ+
         XmQXNlUiDoVPmrgSV4EbK8rt8msh1vJlpzuC0MzzGUSjOoiNn1Ia1VtHm6hzeZYAWJmn
         WhAw==
X-Gm-Message-State: APjAAAULpH6pjIju8lm39ygt11Ed0P6bPRbl+iJPZKOgYBNNjjwjTYBR
        T9Jt0pExwHO67y4jkguh/Hc=
X-Google-Smtp-Source: APXvYqzA8BgS5lHJJKqW69RsyTfykS+05eBAPXPTD5F3L1+d5ysjIYwBC/SDzJEN0tbseTPBZzm0Xg==
X-Received: by 2002:adf:9427:: with SMTP id 36mr2937924wrq.166.1581670275077;
        Fri, 14 Feb 2020 00:51:15 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id d22sm6323540wmd.39.2020.02.14.00.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 00:51:14 -0800 (PST)
Date:   Fri, 14 Feb 2020 09:51:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rientjes@google.com
Subject: Re: [PATCH v2] mm/vmscan.c: only adjust related kswapd cpu affinity
 when online cpu
Message-ID: <20200214085113.GP31689@dhcp22.suse.cz>
References: <20200214073320.28735-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214073320.28735-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-02-20 15:33:20, Wei Yang wrote:
> When onlining a cpu, kswapd_cpu_online() is called to adjust kswapd cpu
> affinity.
> 
> Current routine does like this:
> 
>   a) Iterate all the numa node
>   b) Adjust cpu affinity when node has an online cpu
> 
> For a) this is not necessary, since the particular online cpu belongs to
> a particular numa node. So it is not necessary to iterate on every nodes
> on the system. This new onlined cpu just affect kswapd cpu affinity of
> this particular node.
> 
> For b) several cpumask operation is used to check whether the node has
> an online CPU. Since at this point we are sure one of our CPU onlined,
> we can set the cpu affinity directly to current cpumask_of_node().
> 
> This patch simplifies the logic by set cpu affinity of the affected
> kswapd.

How have you tested this patch?

Also this is an old code and quite convoluted but does it still work as
inteded? I mean, I do not see any cpu offline callback to reduce the
cpu mask as all the CPUs for the given node go offline? Wouldn't the
scheduler simply go and fallback to no affinity if that happens?
In other words what is the value of kswapd_cpu_online in the first
place?
-- 
Michal Hocko
SUSE Labs
