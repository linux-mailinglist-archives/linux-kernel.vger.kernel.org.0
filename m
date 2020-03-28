Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C2C1965DA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 12:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgC1Lu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 07:50:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43879 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1Lu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:50:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id o10so13739042qki.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 04:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PXOaWkf6K2Whqr4tczFKE+1Lhm0x7YcGQ6GGzYXABXQ=;
        b=wruyawcvW8FYxDeUaH/b3sR9f8qVFJNMds5GXrlnCIL4b4t3MHPibhHne7Za5AesWp
         +oZnYwJyHBF7rLaEj3+xRg7T5fJxnvcgCaXvzW/j0ZoW8S8LGz7HY/9cmXGJaWBhgnkX
         3ev0sjOfZuxAiXphJs4iPsEiSx26FWby11+kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PXOaWkf6K2Whqr4tczFKE+1Lhm0x7YcGQ6GGzYXABXQ=;
        b=kc/3WGMAw27ASTkCxb6tLOAszH9GBoXO5zPaLZG5XgrU87HAUQh89bM9XYVoBsmu/6
         aupO7ZnuUYn3qjIiuONE3o/Be9fpzV0JKbFV8BdRdC88jqTuehr55v2P6qT6HunjH5AJ
         wbk7lJRO6RVZFQzI8oGynVeiRcZhnnIgb0ObxvfNvIoasEOoLI0RgB9x/uMtE3Jkbe0K
         R9Fe+bLocZUJP035ghfZYPCW/d/f7fnVdHaCkewYSCt76MfultunJkdJpoNghs4ox7V/
         ZS3OsyCS1wNa8fK016x8MSUkBMkTSmykwky3UuuzG782QdjIVMbi9xq1LLgbcVEAxQMF
         dvTQ==
X-Gm-Message-State: ANhLgQ20X+aRxybXACmG5aAIDumu57uu2JuJYicVRcvigdtGcRSdyrVj
        FADjM3nFIhxrB4lS8zsaWCrnIQ==
X-Google-Smtp-Source: ADFU+vuJZg9x4i3uIawWWwhUP6qOTLg47eTiVN4Q7Bu5YZJWAls9LsVdqiTybdkCsbmFuWW5s7NtMg==
X-Received: by 2002:a37:4d88:: with SMTP id a130mr1086530qkb.443.1585396227212;
        Sat, 28 Mar 2020 04:50:27 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q1sm6610470qtn.69.2020.03.28.04.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 04:50:26 -0700 (PDT)
Date:   Sat, 28 Mar 2020 07:50:26 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Sonny Rao <sonnyrao@google.com>
Subject: Re: [PATCH] docs: cgroup-v1: Document the cpuset_v2_mode mount option
Message-ID: <20200328115026.GA135587@google.com>
References: <20200328014748.24140-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328014748.24140-1-longman@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:47:48PM -0400, Waiman Long wrote:
> The cpuset in cgroup v1 accepts a special "cpuset_v2_mode" mount
> option that make cpuset.cpus and cpuset.mems behave more like those in
> cgroup v2.  Document it to make other people more aware of this feature
> that can be useful in some circumstances.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> ---
>  Documentation/admin-guide/cgroup-v1/cpusets.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> index 86a6ae995d54..7ade3abd342a 100644
> --- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
> +++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> @@ -223,6 +223,17 @@ cpu_online_mask using a CPU hotplug notifier, and the mems file
>  automatically tracks the value of node_states[N_MEMORY]--i.e.,
>  nodes with memory--using the cpuset_track_online_nodes() hook.
>  
> +The cpuset.effective_cpus and cpuset.effective_mems files are
> +normally read-only copies of cpuset.cpus and cpuset.mems files
> +respectively.  If the cpuset cgroup filesystem is mounted with the
> +special "cpuset_v2_mode" option, the behavior of these files will become
> +similar to the corresponding files in cpuset v2.  In other words, hotplug
> +events will not change cpuset.cpus and cpuset.mems.  Those events will
> +only affect cpuset.effective_cpus and cpuset.effective_mems which show
> +the actual cpus and memory nodes that are currently used by this cpuset.
> +See Documentation/admin-guide/cgroup-v2.rst for more information about
> +cpuset v2 behavior.
> +
>  
>  1.4 What are exclusive cpusets ?
>  --------------------------------
> -- 
> 2.18.1
> 
