Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC5D1919C0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 20:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCXTRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 15:17:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40110 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCXTRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:17:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so7809065plk.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Rh4HBg/agEMeOOZna2pzZhd8r6lKpuw8m53EKKUPZHc=;
        b=tIMOfdTlHbbOdLWgQGt6oJeQvoMFtQVTFpy2pLi7nTYBlhcgtjoQBFLNrAmUCFix+T
         Wp/wocBxPQTXgY7/RgRBxViOlX3qvt4qAYEk/YW1KHupUy3P9tp2KaMOzrX0R6sTFgf6
         PliVP2qUb/uLXnzP8BjH8l1c4dAaUAh3rFpjd7ig+b66BRc+pgAFmsMRdIB6fEqjczvQ
         yQTmo6/rDRuUJ5/DZl7UmqTf1BXpa/ALNbK4+wuduHiTGxYnqbqiVNJ6K3EZFv9wHg8E
         xLxeTBC5Y9IaRg2G++TFA5LGhvZDI2ZYBb4si3IViJ1w3uXfMxd2yLIR9+XuIcNGFgWl
         9f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Rh4HBg/agEMeOOZna2pzZhd8r6lKpuw8m53EKKUPZHc=;
        b=kHwvnMUc3Cxy/fNLSgkVWgjq89BfEm8Es9fMSRTDjejuCA3rLpzL+dDbfiIjmZSdRN
         NAhaakblB+uwZSdYVSfEi6Tn1m4CxhDNbKR04aXh3nbQVUJ7zK/USbnz5m5Q+Z7xKd8P
         vMcu9+slNcs3hXVgRfIGPcrJRW8ns0YcxjDQdy83R9ww7yiZQlk12nejtTsL1n9wYbJc
         GbEwBHxnYYZnAFrjynDqypKdmEp7wdLp7VmfDyNNvEJ1rKnRFVWpBbHz1FdQfWzXtGbn
         HmGDLJhyVRpvucOUhSj66SSfZHpPkDzGEO/y16YUUPHk5+KVGE8h30JXPGQcHdwwz24m
         Pyyg==
X-Gm-Message-State: ANhLgQ2Uj76t3bRgt50hfodSykaNAPtUeMhyOdNuLeIi55dH2ELWZBs+
        lfMU6zwLwVxXjddCaU2OvHtdQg==
X-Google-Smtp-Source: ADFU+vupg7MB8LHNKMkljbJFFhiE3/MiCNtH+/LIaDpRYt4jhcqCLjd6AEqV1lRYWFM6fJ38Oue/Bw==
X-Received: by 2002:a17:902:8ec3:: with SMTP id x3mr22947183plo.137.1585077433211;
        Tue, 24 Mar 2020 12:17:13 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id k17sm16391918pfp.194.2020.03.24.12.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 12:17:12 -0700 (PDT)
Date:   Tue, 24 Mar 2020 12:17:11 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hui Zhu <teawater@gmail.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, hughd@google.com,
        yang.shi@linux.alibaba.com, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, sean.j.christopherson@intel.com,
        thellstrom@vmware.com, guro@fb.com, shakeelb@google.com,
        chris@chrisdown.name, tj@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH] mm, memcg: Add memory.transparent_hugepage_disabled
In-Reply-To: <20200324121758.paxxthsi2f4hngfa@box>
Message-ID: <alpine.DEB.2.21.2003241215580.34058@chino.kir.corp.google.com>
References: <1585045916-27339-1-git-send-email-teawater@gmail.com> <20200324121758.paxxthsi2f4hngfa@box>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Kirill A. Shutemov wrote:

> On Tue, Mar 24, 2020 at 06:31:56PM +0800, Hui Zhu wrote:
> > /sys/kernel/mm/transparent_hugepage/enabled is the only interface to
> > control if the application can use THP in system level.
> 
> No. We have prctl(PR_SET_THP_DISABLE) too.
> 

Yeah, I think this is the key point since this can be inherited across 
fork and thus you already have the ability to disable thp for a process 
where you cannot even modify the binary to do MADV_NOHUGEPAGE.
