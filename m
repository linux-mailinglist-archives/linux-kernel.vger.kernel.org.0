Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE1D0196DEF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 16:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgC2OgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 10:36:23 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41332 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgC2OgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 10:36:23 -0400
Received: by mail-qv1-f68.google.com with SMTP id t4so3359914qvz.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cKOBNOm+rZ4d9bR4WUxBUh48pKmpl3L3aadgBjJl+N8=;
        b=E4V7eq1ostoW8XvR/+TcPp3WLl+0AsNGFLPZolKW+6UAzuHq0nIwhJofnwf75MXvhx
         V5VFktaQ/RFJ7WLlRaYuosKbFpb/u2/+ftvTUeVT3WSUs5JMLFeMMdKcK5aGP/8wEnBX
         jrie7KaCbvO5vv+N4ampsWV62mSaqJ50zqUdRO09QM2UrGY3vmqlWjd44YHJxQJvMoyE
         vRkzwGHrkwt5hEqlQjsNOQOj99n7gHAe2pLxY5AaUnodVokOYtZ5N/wJR7Cj2tvNOiIJ
         3pbAB4p6UaIRd1qyu79XwptQkSA0kF5kBJFTqp3dfyBvY+fmmiVh24u6jUgQcWJVIsx/
         g1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cKOBNOm+rZ4d9bR4WUxBUh48pKmpl3L3aadgBjJl+N8=;
        b=mn0qiSYmrPWsVLEtkFxsoToRUAuXqZ0pr9QubszriaPjTI2bFjWj1RTuLFVcQnRp4W
         dUKUWu8huT94HScQAhRPI/NoDY/AFEA49c8mbXxqZScSH4B1Aqt1fvLUKigoUUpM5Mcm
         faFw2/fArnegpApjkEvmnqXWpChHRHmOWRJEgjkdeKG45TzLumgu56uNMDjmxAagrmwW
         qqBVi8UNYOh2WvYc3HQxwEI5zb8T0aCS5fkYw/EehxvHf5LimY61+H0Kgvop7pT00wkx
         r1UlN/JGpYNnuCXo8mUXFSQVNY8jzrTpwTzWS2nuWNjAKfzhCgdhjWVhALwC+tKKSWSM
         nm4w==
X-Gm-Message-State: ANhLgQ2HolR0gLlRi3kFR2GJ33Fy4lP3LZehFx6QGWCXTIzasVabw4HH
        lK51ZlQHheOM58yK7x93L2s+tA==
X-Google-Smtp-Source: ADFU+vv1Y8n2FMzImT66FeDLKS+HztLgbMDaezhyrCdeeCVde2jHORL6B8fuxvpM6NiRUgVO2VgkXg==
X-Received: by 2002:ad4:4847:: with SMTP id t7mr7798301qvy.237.1585492582171;
        Sun, 29 Mar 2020 07:36:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l7sm7982342qkb.47.2020.03.29.07.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 07:36:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIZ2z-0000k2-2n; Sun, 29 Mar 2020 11:36:21 -0300
Date:   Sun, 29 Mar 2020 11:36:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     George Spelvin <lkml@sdf.org>
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [RFC PATCH v1 42/50] drivers/ininiband: Use get_random_u32()
Message-ID: <20200329143621.GF20941@ziepe.ca>
References: <202003281643.02SGhN9T020186@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003281643.02SGhN9T020186@sdf.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 08:21:45PM -0400, George Spelvin wrote:
> There's no need to get_random_bytes() into a temporary buffer.
> 
> This is not a no-brainer change; get_random_u32() has slightly weaker
> security guarantees, but code like this is the classic example of when
> it's appropriate: the random value is stored in the kernel for as long
> as it's valuable.

The mechanical transformation looks OK, but can someone who knows the
RNG confirm this statement?

Many of these places are being used in network related contexts, I
suspect the value here is often less about secrecy, more about
unguessability.

Jason
