Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA78173D51
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 17:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgB1QoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 11:44:07 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:33340 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgB1QoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:44:07 -0500
Received: by mail-qk1-f170.google.com with SMTP id p62so827689qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 08:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CCtY0Qacs9wOnWXud8i9ge7LpLEsLeAVVMXg1sWOnyw=;
        b=D2rlkH59BNrsno4OCSGNHcrjEAEc9dr5OL5Qxmrk0mGVZ34lYCzS5cZTjosC6ZnVAT
         3BFQdQ19TdF4h2LaE8zjalI05AhcG72NHec77qPlHBWRH//SFAx+6Y/5MFykyexwMyTo
         5ehmgBUpXVcOXVyQgB5zYxYRnNPB6qnk1vakhcOAqTDTvuXJORKyj4s7iPsaF7Z9mVvs
         OaLgkjs4jNzhJFyKOy3/54RTg4d+xhP9DVLc9uuRZTvbJuwUXwufSD53LmnE6z252pdA
         kwSOVwoTuMXfzH/TqkKMKz3g/PF439oIoM+KPEmqOG89ccSKJctElfIZLiEFLhjwSLFB
         V6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CCtY0Qacs9wOnWXud8i9ge7LpLEsLeAVVMXg1sWOnyw=;
        b=XSBb2+z3j88w2+onjmq0fWO8HVqhi0c71cfln0NO9D34h/YWS3IwYD02Vay3BY9rwa
         OCTsh3DqKPoNtx92PkRqQM8217LeXyoe6abJHcz6FibCJRaNENzwWQEexnCsK5mU6Umq
         dBNi0WY4VNq54Hi0BPdYWAqwFgk4gR8z+mTdc7s5mir1DdbZkp4T1L5XVXNdkbMzjrF6
         PBEpIOHrFX7oyfwi+8KOYxymYHRLsabP6rKyigoVsKimqS6B7O/FtJoGhFpwJHYuPiuz
         YJjqdAUd/oV6p4GfulnC6o57D0SBvdg+Bb2oO8rA4ne00lkLw1xEtOy4TWLhosotOECG
         TmCQ==
X-Gm-Message-State: APjAAAVnwn3J1ocyGVomfXkrEJHlkh5STDrwTN5tKYQS6hU3SslMnseh
        J2ZlILitFmYAueNnBQ5p/nQyfw==
X-Google-Smtp-Source: APXvYqxfCTu7tTgRtENnzEaKttDXe85vEF0rcY8Ey+zJZn71YPOTRBCqwgqrX+uZgpau/Nsyi1/g3A==
X-Received: by 2002:a37:4d10:: with SMTP id a16mr5155052qkb.325.1582908246112;
        Fri, 28 Feb 2020 08:44:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id r10sm5110838qkm.23.2020.02.28.08.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 08:44:05 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7ik9-0001sw-BL; Fri, 28 Feb 2020 12:44:05 -0400
Date:   Fri, 28 Feb 2020 12:44:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/bnxt_re: Remove set but not used variables
 'pg' and 'idx'
Message-ID: <20200228164405.GC7181@ziepe.ca>
References: <20200227064900.92255-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227064900.92255-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 06:49:00AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c: In function '__send_message':
> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:101:10: warning:
>  variable 'idx' set but not used [-Wunused-but-set-variable]
> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:101:6: warning:
>  variable 'pg' set but not used [-Wunused-but-set-variable]
> 
> commit cee0c7bba486 ("RDMA/bnxt_re: Refactor command queue management code")
> involved this, but not used.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 4 ----
>  1 file changed, 4 deletions(-)

Applied to for-next, thanks

Jason
