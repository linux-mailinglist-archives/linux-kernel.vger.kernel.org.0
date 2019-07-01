Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 777D357C37
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfF0Gc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 02:32:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45529 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfF0GcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 02:32:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi6so697493plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 23:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CxcmhcduYl1f+p8Q6K2P2tN31Ue+lZEcvfx29yQXcTA=;
        b=m4qtlRsuSk58BwN1KjuVxv1OBILIvoJnLL/W5x8gKQGKClqscPAZtSz5HIvZkBZeaP
         3YNDZbTITdkT9d4NODS4YBRtUWymp+dc1Frl9vN52KgPgeSBy8PuVOd1wpDqdViUXGuU
         TaoL6w12s1LCWVE6nAVStEUf6ToOh2LrH0l4rAjW0YWcykR1wBUiW/kiHYkRyaFw/b+m
         5RKkHPbZrlfJtX/jysSBDiQyarjXby+MLOi6XZdFtLwkUxPqEd3s89nrZCy07o0cLs07
         /nNhohMH1gqtNbY5OQLkVy7sE3hn5AauPYz18DSUKOmknEkjo7985c+vomp74sOA3gvV
         PN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CxcmhcduYl1f+p8Q6K2P2tN31Ue+lZEcvfx29yQXcTA=;
        b=LSrHZC5Nk7wo7V5Bkz1/OM+OJSpZeD+jvQl1sR+6VRsiTtC0GAiZKuWJV9tsikoOOE
         wtosR+q5CYf+5TOS9w0X2fqKnhLCJrOPizOVqS0bF5NRQAhI+mSrMgaedF/udbdbS5gi
         osT6s3XfYu1xIGUJvhuRAX6rG0F7viH5ooPkzRXrW57VIFOPEmVeHybRLINmROkgDn6s
         m1twNixw1X4kYRxVEwqCwDkq/NVbfqCfIaZLO4O5Zctvx5LGGKj4AOKRxU+zJDaBMehO
         UCrTiiE7vpiuepI/V/RSKvIizG9XUUoYUu53e2hirpcX5iNS0kmD5J6P26YrS+V+z0OE
         zThw==
X-Gm-Message-State: APjAAAUm7XgJWBQaAsMr5oxz0LtDVNHmLLjqx73R3ja0/tqmrOHue2KO
        oFUInlnsui27IXz0a/LX50YpjQ==
X-Google-Smtp-Source: APXvYqwZ07G5863ndEAB+RksF+e+99jGlEHoSljL/kmhY9ivkki8aBvxOy/aBdnHgI3TPZQaVOsxJA==
X-Received: by 2002:a17:902:549:: with SMTP id 67mr2700794plf.86.1561617144785;
        Wed, 26 Jun 2019 23:32:24 -0700 (PDT)
Received: from ziepe.ca ([12.199.206.50])
        by smtp.gmail.com with ESMTPSA id k184sm1017237pgk.7.2019.06.26.23.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 23:32:24 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgNxH-00029V-At; Thu, 27 Jun 2019 03:32:23 -0300
Date:   Thu, 27 Jun 2019 03:32:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190627063223.GA7736@ziepe.ca>
References: <20190625072008.GB30350@lst.de>
 <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
 <20190625170115.GA9746@lst.de>
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
 <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
 <20190626202107.GA5850@ziepe.ca>
 <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com>
 <20190626210018.GB6392@ziepe.ca>
 <c25d3333-dcd5-3313-089b-7fbbd6fbd876@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25d3333-dcd5-3313-089b-7fbbd6fbd876@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:18:07PM -0600, Logan Gunthorpe wrote:
> > I don't think we should make drives do that. What if it got CMB memory
> > on some other device?
> 
> Huh? A driver submitting P2P requests finds appropriate memory to use
> based on the DMA device that will be doing the mapping. It *has* to. It
> doesn't necessarily have control over which P2P provider it might find
> (ie. it may get CMB memory from a random NVMe device), but it easily
> knows the NVMe device it got the CMB memory for. Look at the existing
> code in the nvme target.

No, this all thinking about things from the CMB perspective. With CMB
you don't care about the BAR location because it is just a temporary
buffer. That is a unique use model.

Every other case has data residing in BAR memory that can really only
reside in that one place (ie on a GPU/FPGA DRAM or something). When an IO
against that is run it should succeed, even if that means bounce
buffering the IO - as the user has really asked for this transfer to
happen.

We certainly don't get to generally pick where the data resides before
starting the IO, that luxury is only for CMB.

> > I think with some simple caching this will become negligible for cases
> > you care about
> 
> Well *maybe* it will be negligible performance wise, but it's also a lot
> more complicated, code wise. Tree lookups will always be a lot more
> expensive than just checking a flag.

Interval trees are pretty simple API wise, and if we only populate
them with P2P providers you probably find the tree depth is negligible
in current systems with one or two P2P providers.

Jason
