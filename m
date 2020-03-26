Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3BE1947BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 20:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgCZTov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 15:44:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44097 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:44:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id j4so8156559qkc.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 12:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vz8M+WY12BuCsCLe/S9A2YcP2dqH4GItbGgYzpSKVks=;
        b=Wvi8sFDy3Xelku+ev0Z+8Z88gUwLdh49TKjzgpvENdRnjLybfJv52p2eJGWj4Po7mX
         9ZiDd3dnWbFl0RVSEDSIc7JcCinAuAswL3ehy/VJRT+S+Z294BqheymwNr9VaspjVkRw
         jDTamd/KQWz5bhF0xB8oGvoDFbXtqoH/LflMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vz8M+WY12BuCsCLe/S9A2YcP2dqH4GItbGgYzpSKVks=;
        b=QMevjwzosaw4DTQ3V/eYYR/TfhcACjDwFjPd/1DilnVZ2G1Wv3jjGxOlgSHeSLQXbH
         b034UuuUvqz2HQ1iS02pwl9mqhUcDBQG/ecF4J1UuHi0+w6DDZAWcSXr5HKvQt5V5nKS
         CfF1jTUkWVmfMMvclgVHWURPXt4CeJJkthjdVNQDOBueDt/en0cXMzvNTL7cWCqmU5oL
         qLRTkvQgL3KNM4tZbH2PLddZ/caCcVJ/uOHFJAeQaabMA+V4oGZK90iBb/eXJ+1zrmOl
         CPJM99T3Wfsdg45NQAZSWSoVdDy+hooVXyO9S+FhMO2KmDmt5g8BV8PkqGdxdv+S9Pth
         7qfA==
X-Gm-Message-State: ANhLgQ32oGUGA5/xAdi9PAus2BqKpIdcYmM/9wJ15WXHonnA9rZhvCM8
        Pg/guPCM5KwLxZBKxg8NRs897rM6I3o=
X-Google-Smtp-Source: ADFU+vv4Ed+8fGkonegfzDlU+QiZdHa5jyfFN+G7H65B9V9e/l32Mev8DSAqceTHpeLqzZ3Vgffnmw==
X-Received: by 2002:a37:9ec8:: with SMTP id h191mr10060075qke.260.1585251889761;
        Thu, 26 Mar 2020 12:44:49 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s36sm2246621qtb.28.2020.03.26.12.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:44:49 -0700 (PDT)
Date:   Thu, 26 Mar 2020 15:44:48 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com,
        jsbarnes@google.com, sonnyrao@google.com, vpillai@digitalocean.com,
        peterz@infradead.org, Guenter Roeck <groeck@chromium.org>,
        Waiman Long <longman@redhat.com>,
        Greg Kerr <kerrnel@google.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
Message-ID: <20200326194448.GA133524@google.com>
References: <20200326191623.129285-1-joel@joelfernandes.org>
 <20200326192035.GO162390@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326192035.GO162390@mtj.duckdns.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Thu, Mar 26, 2020 at 03:20:35PM -0400, Tejun Heo wrote:
> On Thu, Mar 26, 2020 at 03:16:23PM -0400, Joel Fernandes (Google) wrote:
> > This deliberately changes the behavior of the per-cpuset
> > cpus file to not be effected by hotplug. When a cpu is offlined,
> > it will be removed from the cpuset/cpus file. When a cpu is onlined,
> > if the cpuset originally requested that that cpu was part of the cpuset,
> > that cpu will be restored to the cpuset. The cpus files still
> > have to be hierachical, but the ranges no longer have to be out of
> > the currently online cpus, just the physically present cpus.
> 
> This is already the behavior on cgroup2 and I don't think we want to
> introduce this big a behavior change to cgroup1 cpuset at this point.

It is not really that big a change. Please go over the patch, we are not
changing anything with how ->cpus_allowed works and interacts with the rest
of the system and the scheduler. We have just introduced a new mask to keep
track of which CPUs were requested without them being affected by hotplug. On
CPU onlining, we restore the state of ->cpus_allowed as not be affected by
hotplug.

There's 3 companies that have this issue so that should tell you something.
We don't want to carry this patch forever. Many people consider the hotplug
behavior to be completely broken.

thanks,

 - Joel

