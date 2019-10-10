Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A9D2558
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 11:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbfJJI6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 04:58:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389237AbfJJIqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:46:04 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CFE1796EE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:46:04 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r21so1471723wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 01:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tR/b93II6w98Y1JcW5QoZrFBl2Ih7JvmORnV8m5CDsk=;
        b=DOrZ8wYqi+0zPaLCJQvgap/jXVgPclrIrxQz3hVXmi7Qdmnazkfpyhy7tDTv0Hnb9K
         V0SJVn1hVZRyNbgjX4ls3JBcd6Amtsw+X6GfuDyP1aNVRYRLjl9wHL3bxnSzZlb+R74+
         11MxRZ9WJecuN9lQUHIms/i6mOrn+CGk4EWJplZwgXYDrCuAvpR7KzeCYjPs0trCoasn
         VLUpxK/1vTisBGyHwLsZoU/5pXspkK4+8BKLXWgEHZTOA+u9/PmaTvvQV9A89TAOszZT
         jyX1aadSpAwtuRzM04OWqDBPDAp3ITvI8jCIE/TGEwGmcaN24vKd8bf3jyr8zpdnA6J+
         1ZKg==
X-Gm-Message-State: APjAAAX1a6fx0f5dotvkWapDA5diTCdNHnvxI3aiYIEUgY2PMmI+VGHq
        lHmv8bLu2TnB8YsRf7l7kN2bug5TskiUd01X4i4+LVT/BR9lP+Qi9fac5mtYM0q3eVrynbNF7Wy
        7/JzVoJfV2XqZSS4hCQr0lR0r
X-Received: by 2002:adf:e401:: with SMTP id g1mr5700484wrm.211.1570697162834;
        Thu, 10 Oct 2019 01:46:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyrGXBfAqLL3DSANixqvzd6znc5l0D4LZnBiMcWibn1Ag6PBFlGAQzLidI7EwNDBrIbfhWgrA==
X-Received: by 2002:adf:e401:: with SMTP id g1mr5700471wrm.211.1570697162619;
        Thu, 10 Oct 2019 01:46:02 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id q124sm8324726wma.5.2019.10.10.01.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 01:46:01 -0700 (PDT)
Date:   Thu, 10 Oct 2019 10:45:59 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [RFC PATCH 00/13] vsock: add multi-transports support
Message-ID: <20191010084559.a4t6v7dopeqffn55@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
 <20191009132952.GO5747@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009132952.GO5747@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:29:52PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 27, 2019 at 01:26:50PM +0200, Stefano Garzarella wrote:
> > Hi all,
> > this series adds the multi-transports support to vsock, following
> > this proposal:
> > https://www.spinics.net/lists/netdev/msg575792.html
> 
> Nice series!  I have left a few comments but overall it looks promising.

Thank you very much for the comments!

I'll follow them and respin.

Cheers,
Stefano
