Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B5F190FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 14:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgCXNX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 09:23:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37461 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbgCXNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:23:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id d1so3449097wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=16WGU3cNB1gezVOdWiJDOY/jwLM7wxW+VZ4bxA/PHPk=;
        b=bWlSVSaAkOrITpOQwvrWt1U9KbT9mbpxsTyfS70Bdu05BJ1bpQu2yaT81q91QdmG8m
         b2iC6Eyj1qy/xakWe9eSTS+HImwFRVl0AESSqhQrw9NqXo0VwH0qp2T3zTae9TqhsZf/
         n/Lgm424ZcP3W7ZZ2bRqCxOKpCo5Nk/adFez4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=16WGU3cNB1gezVOdWiJDOY/jwLM7wxW+VZ4bxA/PHPk=;
        b=h5IUmrm9yUvf2Z5JcSGn5HBcTe2m9inEUZvQgJg17TJnLT6ZBFN1YukUzMr0ugOJPl
         kFphUqRG9g4dUCGW/1FSE5QEe9Wu0diWaKON9QYnPuCeG5igd+jW4Zc72WlhyLcDsi6V
         WTAjTtJrwmBCy8bGXSjDrpvT6MpIyQeoUfowKyK05m4bhg1Q99kOQb6jKdE+ZYo5yHJJ
         IYSxOcHdcz2oHqyd1lg95x8jOJPeVRAzkMAGkVeEGkk8ByQviH7jpRBfhKPR65XsIxOA
         sNccfd6ECE3DbpbMiIU3zm1WTYUEhkAQTLlURXVlA82h84a3NnWGnfHfQFBdCT5kIMMI
         u4jA==
X-Gm-Message-State: ANhLgQ1BA6C8G36mlAyJ+rh65fta/FtV2Of9ZoMif2JXcWEhWTRW8aJB
        nXQzIDHZS7Q3AOqfFnYWM0DMSg==
X-Google-Smtp-Source: ADFU+vsRXGhBNDWactdLbIMseJKjnvylYAlIoBTm5ZCXj70sl98tC5w95ZPI7DAjbM3/oddQVqqJtA==
X-Received: by 2002:a05:600c:280b:: with SMTP id m11mr5309390wmb.99.1585056231630;
        Tue, 24 Mar 2020 06:23:51 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:8734])
        by smtp.gmail.com with ESMTPSA id w7sm29792149wrr.60.2020.03.24.06.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 06:23:51 -0700 (PDT)
Date:   Tue, 24 Mar 2020 13:23:50 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Hui Zhu <teawater@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, hughd@google.com,
        yang.shi@linux.alibaba.com, kirill@shutemov.name,
        dan.j.williams@intel.com, aneesh.kumar@linux.ibm.com,
        sean.j.christopherson@intel.com, thellstrom@vmware.com,
        guro@fb.com, shakeelb@google.com, tj@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH] mm, memcg: Add memory.transparent_hugepage_disabled
Message-ID: <20200324132350.GA7528@chrisdown.name>
References: <1585045916-27339-1-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1585045916-27339-1-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hui Zhu writes:
>/sys/kernel/mm/transparent_hugepage/enabled is the only interface to
>control if the application can use THP in system level.
>Sometime, we would not want an application use THP even if
>transparent_hugepage/enabled is set to "always" or "madvise" because
>thp may need more cpu and memory resources in some cases.
>
>This commit add a new interface memory.transparent_hugepage_disabled
>in memcg.
>When it set to 1, the application inside the cgroup cannot use THP
>except dax.

I'm against this patch even in the abstract -- this adds an extremely niche use 
case to a general interface, and there are plenty of ways to already indicate 
THP preference.

Perhaps there is some new interface desirable for your use case, but adding a 
new global file to memcg certainly isn't it.
