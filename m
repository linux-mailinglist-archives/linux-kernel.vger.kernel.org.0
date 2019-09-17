Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E49B56B0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 22:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfIQUIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 16:08:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44815 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfIQUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:08:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so2557100pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3rykt/1KJ5ehZkESnXZf1dXhmnmIju1zBiNgI4nTTZY=;
        b=TSdkOPQ3dnS7XsEBM4T8FLGSJbblBcQ8CqeHpDRJRWz6kGM9Y/BwnlNO5Cnbeqz5kr
         mhDWfTq/aVmkEiyNfxDKdk/EFBPhLuI3Yw3H/t/AvVYIcfNULTN1DlX3YV5a2mxQOz9g
         AzAnfV3SBZx4x93pTefjHnmpefg8ZIBHmgiLEJMArI8P3rGC0XMlPj3iaQEyZ66SibQH
         hlDls4klP/AOVVUD0VH3q/Ovn0EgyXG7F2CuT0JnAr1iylPEfFyo0LwW8vxbXDKLwXKW
         hN3XLeKaAOUQvQScru+RI1YpJNtFzOSDEPZ+HkIN0in29GnIRKwT1ldIHrFR8Tjf6VGT
         XSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3rykt/1KJ5ehZkESnXZf1dXhmnmIju1zBiNgI4nTTZY=;
        b=VXOqx39p3wkCZveomltcE8+Hk2rnKIkbhpL14G262huCPQfdAd5UWTwYMXDCP8ahbb
         +LCRNFI2AAFaL14Kxzu+VjlskhUK6L5O9Go22Mn/vE1bDINbeOfRZ+mJA5aPZ9ZTj2CO
         52zIxmMaWxI5B2pFW8Zaa4sqOhVGdyBRwj/4SPC96S9rqnmGOOpxlzuzhkkiCQRLCDL4
         YLjXkBxVa0rHH7LhZHQqxIwqEbTODqAULlKJ43Dz+hdP2AoMW6+Cn4jIDWN32w7Wx+yJ
         dbbOWo91KRVZdWDIiAN39iXk31lgA/WI2nV+yetA6Lg/gG8nu0BcVYfFX7b+f16GFyJ9
         brKA==
X-Gm-Message-State: APjAAAV8TzC+H+i2r21EAReKj4a1grg+58Q6hzcqNHbgBgCT1xwiwFzv
        DWiLIgn2m5w9Vp+5SJBN3d4Y1Q==
X-Google-Smtp-Source: APXvYqw0iQ01weHB0V+XE0PsNIiJpkwp5Eu2QPcBhYaQn2v9FppqNME4WfMGjuvWDaoJGBtZ8ksTng==
X-Received: by 2002:a17:90a:154f:: with SMTP id y15mr6896302pja.73.1568750916333;
        Tue, 17 Sep 2019 13:08:36 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id w187sm2875155pgw.88.2019.09.17.13.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 13:08:35 -0700 (PDT)
Date:   Tue, 17 Sep 2019 13:08:34 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Qian Cai <cai@lca.pw>
cc:     Pengfei Li <lpf.vector@gmail.com>, cl@linux.com,
        penberg@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/slub: remove left-over debugging code
In-Reply-To: <1568727601.5576.160.camel@lca.pw>
Message-ID: <alpine.DEB.2.21.1909171305260.161860@chino.kir.corp.google.com>
References: <1568650294-8579-1-git-send-email-cai@lca.pw> <alpine.DEB.2.21.1909161128480.105847@chino.kir.corp.google.com> <1568727601.5576.160.camel@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019, Qian Cai wrote:

> > The cmpxchg failures could likely be more generalized beyond SLUB since 
> > there will be other dependencies in the kernel than just this allocator.
> 
> OK, SLUB_RESILIENCY_TEST is fine to keep around and maybe be turned into a
> Kconfig option to make it more visible.
> 
> Is it fine to remove SLUB_DEBUG_CMPXCHG? If somebody later want to generalize it
> beyond SLUB, he/she can always find the old code somewhere anyway.
> 

Beyond the fact that your patch doesn't compile, slub is the most notable 
(only?) user of double cmpxchg in the kernel so generalizing it would only 
serve to add more indirection at the moment.  If/when it becomes more 
widely used, we can have a discussion about generalizing it so that we can 
detect failures even when SLUB is not used.

Note that the primary purpose of the option is to diagnose issues when the 
CMPXCHG_DOUBLE_FAIL is observed.  If we encounter that, we wouldn't have 
any diagnostic tools to look deeper without adding this code back.  So I 
don't think anything around cmpxchg failure notifications needs to be 
changed right now.
