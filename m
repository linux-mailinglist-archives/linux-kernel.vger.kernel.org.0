Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F77A8D97
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbfIDRSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 13:18:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40417 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfIDRSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:18:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id y39so11348334ota.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWAo+cPvJp3pRuv/EjTjzujk+3Lx4B3tuClNVfFzxqE=;
        b=Rlc1qhvZ/ZQZfeXisjWKvvbzrb0mPj0GtsVSCztE1V6gBxbgVkBtlwBpQfC2Ws0iBt
         j4bJSkCe2TVLeJe5NK/C6H5I6WMPrjn2HB/p4HGS4lLapqisnUcpYcsHcOvLEXufOiOS
         /Rxvb97yf7u2LLniuekAdg3DDYKhLMQQEx4l4CR7VYkoEEETOko7EYgS9GpF9q0C/2r2
         dvVVNg9ufoLzzbx/qnE1LgO1GRYro3b/T25vZuduFuyj1S3ATJ9kKptK/TWQwnUUnEId
         EIySB20LH9efVW3/EMHOaxC/bSdaLLY2mfjzFeoqVQWPb5Tyj8/Q733yJqVbiiK1ODNC
         HxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWAo+cPvJp3pRuv/EjTjzujk+3Lx4B3tuClNVfFzxqE=;
        b=UnrrnY/Kn1GmM2ESqh0JcAfkbUX57+8jxSzNpW893vr0wi9r7q868bJWnhcQNOJoa1
         4F2X0WnKxIZq191qURCYf81J8zKQmjOzXyqiClCru9n7Vmo1aPxiP6DTokH7kIP6Hy7a
         uFEI1MiGk5ZnF4B05fGYzCrIpI9Ele9k0GISOoHiFFO0fNN6YmiUMJggk9bCe8SEgwye
         O/z3fK4XUbiZEFPzZjDm+Kg8c8he/pzyJcXtaO6UyTwRw4y9EDpQcfQ0Y8O1uUZYQo6h
         2ufODeQbYhtY6o/8FPZgNsdKyvwJJi62gNlhhkdRQvjxHZE06oGhvVTzXnQsniMtZFO0
         USIA==
X-Gm-Message-State: APjAAAUEQldszyC+ZunmrtSb/x0KKpXvfqWhPfu869mR+bcwJjMvg+SK
        +qGCKSZHkpK92oTY78zmRaAI3jcD70KOVArSXlONMw==
X-Google-Smtp-Source: APXvYqxB6/QFXnZ/bEnS1j2lA+AClqCX06L5cZV7XAFcGub2RVPZyKFEhbHeaZgG1pDQGqQfQ9P+zjb+4LI/qsUMqOE=
X-Received: by 2002:a9d:30c2:: with SMTP id r2mr17813816otg.186.1567617491603;
 Wed, 04 Sep 2019 10:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <20190904084508.GL3838@dhcp22.suse.cz> <20190904153258.GH240514@google.com> <20190904153759.GC3838@dhcp22.suse.cz>
In-Reply-To: <20190904153759.GC3838@dhcp22.suse.cz>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 4 Sep 2019 10:17:33 -0700
Message-ID: <CAKOZueuGML_ZX8Pk5csLK7TWEVwqGj=KZTh2TELNsLytkrHCTQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Carmen Jackson <carmenjackson@google.com>,
        Mayank Gupta <mayankgupta@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 8:38 AM Michal Hocko <mhocko@kernel.org> wrote:
> > but also for reducing
> > tracing noise. Flooding the traces makes it less useful for long traces and
> > post-processing of traces. IOW, the overhead reduction is a bonus.
>
> This is not really anything special for this tracepoint though.
> Basically any tracepoint in a hot path is in the same situation and I do
> not see a point why each of them should really invent its own way to
> throttle. Maybe there is some way to do that in the tracing subsystem
> directly.

I agree. I'd rather not special-case RSS in this way, especially not
with a hardcoded aggregation and thresholding configuration. It should
be possible to handle high-frequency trace data point aggregation in a
general way. Why shouldn't we be able to get a time series for, say,
dirty pages? Or various slab counts? IMHO, any counter on the system
ought to be observable in a uniform way.
