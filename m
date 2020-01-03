Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD812FD0E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 20:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgACTar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 14:30:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40050 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgACTaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:30:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id c77so14403126oib.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 11:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+A1yNa9EKEJAvf7mT00hIXluvZccqZJ7nsuzns/AIw8=;
        b=QcqFB30MvhWgAdAzPCflfRmMETbH1hoaJBG7MjYnvbJcTSSYFCqw7gCztL7VDsBjEQ
         bft3HLIHqI3AG32tRCL397/3D+LE5eZUjbGrWZoUGjgrKYA3BuQJ7UwTUoalWAZm+esn
         8VdrudiYMzMuJ2ZlhI0/GyrZnfkMedu++29oggEnKOE7bVGp9DPbnOW7whKKa8O3My1v
         HoCi+cbEXmbmUDIWSPp3CDf36DG9rMFaaQTalTxHrlD/PJvxiwpEn0B+nR3yasZOwDky
         JzxMuv+w316sqBBqiR96737ifpKGaWFGzriRnlgq4zDPQgbOkNVzn1ruNr2LzpuIl1yv
         O9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+A1yNa9EKEJAvf7mT00hIXluvZccqZJ7nsuzns/AIw8=;
        b=aaBI4utQ7CzEwWCtGoTxrGzQl8jhE1tyGVev8rMwgvu+BZy59+VISV7D7/9nx7KMr2
         sOnXa3J+i90jHMElItd0195yEc4KIJAHh2aUATlCrX5J+/Clq9aJRFUGirvZEqEOHKWe
         lb6HT1TZFbma1ZZ5+GDD43rwL3UIAek5Vp85LgtSS9qN3+H+RUkE1I1eUsP3cJCoyhyj
         bmMm6VCNTLyMCIvExVSA0lid8sAvB1J4dwZvl9M3fB3EdWKfUKttVavuPFfQ4twsnsk+
         RWfme/PWgwMMkbR5HYJpKsgobkkWBm0ipH0aPipJbspeipwp4P9LYoMEzkFJSlbeBUlR
         1UpQ==
X-Gm-Message-State: APjAAAU3j+nkWMtCpFYNF9FDM7K5aQkfb51crnvSWtDJ0Sjqf28Y9ZXV
        TlNei+SjcdsZSj95BB2qTeg5DqU0x7f0y47IJIXv7g==
X-Google-Smtp-Source: APXvYqyU0RUmJHbu8sFP1etbSHj6m5ri0lKObr59npnVW1CLsV3/SdCgQXzjKK3OOe298BMpuBxbd4JwwIlerJ4Wg8c=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr4434705oia.73.1578079845934;
 Fri, 03 Jan 2020 11:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20190821175720.25901-1-vgoyal@redhat.com> <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org> <20190826203326.GB13860@redhat.com>
 <20190826205829.GC13860@redhat.com> <20200103141235.GA13350@redhat.com>
 <CAPcyv4hr-KXUAT_tVy-GuTOq1GvVGHKsHwAPih60wcW3DGmqRg@mail.gmail.com>
 <CAPcyv4jM8s8T5ifv0c2eyqaBu3f2bd_j+fQHmJttZAajZ-we=g@mail.gmail.com> <20200103183307.GB13350@redhat.com>
In-Reply-To: <20200103183307.GB13350@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Jan 2020 11:30:35 -0800
Message-ID: <CAPcyv4geobjz_FZpfow7CKYDHHPe=65=tYV65E0901OzPszpww@mail.gmail.com>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 10:33 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Jan 03, 2020 at 10:18:22AM -0800, Dan Williams wrote:
> > On Fri, Jan 3, 2020 at 10:12 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Fri, Jan 3, 2020 at 6:12 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > [..]
> > > > Hi Dan,
> > > >
> > > > Ping for this patch. I see christoph and Jan acked it. Can we take it. Not
> > > > sure how to get ack from ext4 developers.
> > >
> > > Jan counts for ext4, I just missed this. Now merged.
> >
> > Oh, this now collides with:
> >
> >    30fa529e3b2e xfs: add a xfs_inode_buftarg helper
> >
> > Care to rebase? I'll also circle back to your question about
> > partitions on patch1.
>
> Hi Dan,
>
> Here is the updated patch.
>
> Thanks
> Vivek
>
> Subject: dax: Pass dax_dev instead of bdev to dax_writeback_mapping_range()

Looks good, applied.
