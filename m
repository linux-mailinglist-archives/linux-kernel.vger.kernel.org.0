Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D6726726
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfEVPs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 11:48:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44335 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfEVPs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:48:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id w13so2852210wru.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oucC8M3nZCcEbyMW2+s60vcv+usbO9AOXsL/5EkWU+s=;
        b=KNnxG+9UdfArtLGjhxfLQyQbRBbcZqyz7xsk+XEAzHZTtQRvp0fElhyJjevhcLT9l9
         iArpc3ll/0902ERfuDg9borY5t6L/qsbpTPWGVUn20smnvKCtwfN6lAad1LvBzX+ID9O
         7dpPjMy5igrMK7Yc8G1X/azBJiGLiPUDBHWYuNRrg+rkAVDtfnv5sDbQRG1nfnNz+QFR
         xuyXGDLrWUrTO9gsSzOwQcAyRjdTym+JZGQFeCryofMDsah/PSN8lejM8Pgpwh8e94w6
         GkVufsnlcj84ZiPD4gfpERImVkWPuBBvAuD5dmRafM9yDNb+XknITApanmBGJ8qgiDyd
         XpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oucC8M3nZCcEbyMW2+s60vcv+usbO9AOXsL/5EkWU+s=;
        b=EHMO9LfABO0nJY/fJ1kA45bsdAna6nY/7d7T99nPBPBqvinCKXrkmw2QcK2p8ZJq0x
         5dyOTHFdSbv4tqniBVSWAuyWbOu+yQDTnXrAzZBAKjENR4sOyXByJHDHDzl4wg5x7Okv
         TMMLzjVKxwZ2uHwMal5Ld6imnXOLfRmRj0y7HscGXfJ3krzyDXp4T7knSYsYpp3BU7KR
         WgrRD3iXOQNSdWMMi0rRjCbq8RLz7yXI24Aj9FxfwdPTO5bcQiur61IK3SwE3DZUMOTA
         +GRrR2ngvQWKb8PXvvNUY3bC3ar1WFK97bVOBCP1N3CSuP6vg7ZHXXV2A8M7gd1WhH6e
         JjZQ==
X-Gm-Message-State: APjAAAXBV2HVTZpOCCmLNMpBR8rzyqfDQIs5nr3/LKcaOOhuZ4chTeZ6
        WjTF9ugRhUlwxS098rNxhwXDTQ==
X-Google-Smtp-Source: APXvYqzyz5WGn5HyF+nsXwQJs/jSb8LE75/f4KRMw/vmZSIjK+0u7kRcaFAsumgBY4JF7bUFPaLVjw==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr3781938wrw.134.1558540107031;
        Wed, 22 May 2019 08:48:27 -0700 (PDT)
Received: from brauner.io ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id m206sm8191293wmf.21.2019.05.22.08.48.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 08:48:26 -0700 (PDT)
Date:   Wed, 22 May 2019 17:48:25 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
Message-ID: <20190522154823.hu77qbjho5weado5@brauner.io>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190521084158.s5wwjgewexjzrsm6@brauner.io>
 <20190521110552.GG219653@google.com>
 <20190521113029.76iopljdicymghvq@brauner.io>
 <20190521113911.2rypoh7uniuri2bj@brauner.io>
 <CAKOZuesjDcD3EM4PS7aO7yTa3KZ=FEzMP63MR0aEph4iW1NCYQ@mail.gmail.com>
 <CAHrFyr6iuoZ-r6e57zp1rz7b=Ee0Vko+syuUKW2an+TkAEz_iA@mail.gmail.com>
 <CAKOZueupb10vmm-bmL0j_b__qsC9ZrzhzHgpGhwPVUrfX0X-Og@mail.gmail.com>
 <20190522145216.jkimuudoxi6pder2@brauner.io>
 <CAKOZueu837QGDAGat-tdA9J1qtKaeuQ5rg0tDyEjyvd_hjVc6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZueu837QGDAGat-tdA9J1qtKaeuQ5rg0tDyEjyvd_hjVc6g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 08:17:23AM -0700, Daniel Colascione wrote:
> On Wed, May 22, 2019 at 7:52 AM Christian Brauner <christian@brauner.io> wrote:
> > I'm not going to go into yet another long argument. I prefer pidfd_*.
> 
> Ok. We're each allowed our opinion.
> 
> > It's tied to the api, transparent for userspace, and disambiguates it
> > from process_vm_{read,write}v that both take a pid_t.
> 
> Speaking of process_vm_readv and process_vm_writev: both have a
> currently-unused flags argument. Both should grow a flag that tells
> them to interpret the pid argument as a pidfd. Or do you support
> adding pidfd_vm_readv and pidfd_vm_writev system calls? If not, why
> should process_madvise be called pidfd_madvise while process_vm_readv
> isn't called pidfd_vm_readv?

Actually, you should then do the same with process_madvise() and give it
a flag for that too if that's not too crazy.

Christian
