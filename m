Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA2C634DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 13:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfGILXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 07:23:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39066 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfGILXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:23:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so2815177wma.4;
        Tue, 09 Jul 2019 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d2taC3QgifzieCbNOeD8WIYakWWkzbMMzcY17sx+0KQ=;
        b=ijkCSQ0t/VtNgNSWsflY4vgO5RjASUZL914JxrBWBnBp/yjwl6tk937qj4TT5ZMkpW
         9nrRbBXh/A7n68SxVzLirpcOVPwv1PahPZAwtyWvzrRlxPZUPGMFhrZqdwVo9RH1TyiC
         J4AYsdAtg1OtC3VUvSVETP7LBE9MAVvw/DPpGU8dLFhqKX9VDj1mn0pLR9WojmBurEls
         HdR0NcM90qTJsTQIRrfXoyfUwR3CLflyFY7FxSewrD8zeLxAzWxmnd7cZcVIcB8Cq5zV
         LfVS9QG9Fz0k8pnv5axSWGPN6DlUT7m2xbZq/1Tt6SkwEabSnuHOFjNM3YGjatcV4Ffh
         XMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=d2taC3QgifzieCbNOeD8WIYakWWkzbMMzcY17sx+0KQ=;
        b=KN9WI4qKO/Ih93HVso4mR4COPiHZ22hpf/CfuXwtXLMUpDh3NyUa961mdLN5W205Cp
         VaVjDEXX42zQNOz/dczpt9dfbJtZnFivADtN0TEozxO7QdBLrrkUOE6ujDImrTndULd0
         dqkzbgcOD+Gjo5po4ybyvH07PHnyHUzi87jGx9HML0TLs+dSsIqtYjRGI5l5BQecvloA
         gOsmMAul5xomP1KcpUbSH+DaNr3U6BqbYcVPEg7sLT0H5hZfHtf9sRjOLSKeEH1sQ6pe
         tNTuFksrmdtKp4MgYIQRZMg7Bd//vWCbt5gNA+GR6RIVhwTAJpR+aoBqXFdy0ew6e0vF
         qUvw==
X-Gm-Message-State: APjAAAU02dcst/JzYmqyX/eSx7Fdo8gNY+SDtpyeplTyL4PQYL3zQegB
        7xymg9njwZYkpsDsGaRiADE=
X-Google-Smtp-Source: APXvYqwfWy4VQAracAx8IC/ISCqvAGRw/JXDbr01yZdYjpyh94j/kRK1cFiEusGxQsgXXGcY3pgOMg==
X-Received: by 2002:a7b:c1da:: with SMTP id a26mr22241378wmj.128.1562671397881;
        Tue, 09 Jul 2019 04:23:17 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o20sm44379982wrh.8.2019.07.09.04.23.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 04:23:17 -0700 (PDT)
Date:   Tue, 9 Jul 2019 13:23:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        David Carrillo Cisneros <davidca@fb.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>, Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/8] perf/urgent fixes
Message-ID: <20190709112314.GA110831@gmail.com>
References: <20190708154207.11403-1-acme@kernel.org>
 <20190708215057.GA7455@kernel.org>
 <20190708215420.GB7455@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708215420.GB7455@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Jul 08, 2019 at 06:50:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Jul 08, 2019 at 12:41:59PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Hi Ingo,
> > > 
> > > 	Please consider pulling, I did a git merge with torvalds/master
> > > late last week to fixup some kernel headers ABI sync warnings, but I had
> > > to cherry pick some csets from my perf/core branch to get the container
> > > builds to all work, so ended up slipping past v5.2, oh well, but here it
> > > is, all containers building ok, I'll now test perf/core to then push
> > > that too.
> > 
> > Hi Ingo,
> > 
> > 	As requested I merged tip/perf/core with this branch and now its
> > available as the perf-urgent-for-mingo-5.3-20190708-2 signed tag, that
> > has only one extra cset:
> > 
> >   commit 686cbe9e5d88ad639bbe26d963e7d5dafa1c1c28 (HEAD -> perf/urgent, tag: perf-urgent-for-mingo-5.3-20190708-2, acme/perf/urgent, acme.korg/perf/urgent)
> >   Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> >   Date:   Mon Jul 8 13:47:14 2019 -0300
> >   
> >       tools arch x86: Sync asm/cpufeatures.h with the with the kernel
> 
> BTW, I ran all the tests as before, same results.

Pulled, thanks a lot Arnaldo!

	Ingo
