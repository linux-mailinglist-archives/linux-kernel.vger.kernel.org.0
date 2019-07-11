Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73AC465953
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 16:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfGKOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 10:47:49 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34976 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbfGKOrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:47:49 -0400
Received: by mail-vs1-f67.google.com with SMTP id u124so4367991vsu.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rUmlGY6yas6VrdYZGOaSdQwWGQVgRyYlGBxMRjwXy+U=;
        b=KvUJNONAi7UUgCR2G0iyP9dC+TEMlGB52UsU1vpEIE5VUni18sfejiXR6iDDWn9v+L
         DRT+7FMtOVb1Q5RVg/FNfJrxVYnjZ8hPBBJS3BgXxC8s+n22dFw04/QfQE/PzafV70Ux
         yuO1IbahQooVuS+EAWoBqL1hRsJC012tPEX+7IwdPyb6Sc5P57LB6iGNOhObv3pivyMG
         qit8V+zMIOigBTnd9LMt57Oty1F4rJVj6Pf6gsrZPQ7bDgZ+ma+hixUViT2TEmzDyLL8
         q+MKCCA14cL/H81tWsOac2m2U5Ot90z2OirelMMAk6qnpIFHP4rxO/tfP0F2dHPgqOza
         CtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rUmlGY6yas6VrdYZGOaSdQwWGQVgRyYlGBxMRjwXy+U=;
        b=mvw1Riy60eeA9T8tLZwvk15fegDtT4zRHIheTvKDG2MEopFFH+mu8AzXXS5/xJH0eF
         Rrc0Yubis7Tb6n9gw+oo1SDt+JfeRXVoynbvQOewHLgYRL4FyunzG5123jOAqOjtukAr
         X5xkAhLXdbTMGc2V65tI30R/tDQeP83hsF34lnUmnHOYm2eOWhBHOuhUvyAPP23t5ZQU
         m0Cs7ZmaX/dMJ8eOi393f36CJEAB9cYZF/u5/HPgx2imli9EC3DF3oW4jVLvzzvz94jI
         nW4dfx/8BmXF9ZbffHwcbZGPTjW27/xXBswRnwML8Izl50/NRor7A2HPXqgBW5aVON4d
         gK2A==
X-Gm-Message-State: APjAAAUWs8szNCJm1Ys0Cf8KaJ22B0fmzKpBNmemQsIWoDaQbS5LR3yJ
        qhkj+eoRQHRvhCon9FnJ5HaAcQ==
X-Google-Smtp-Source: APXvYqweUoGqYduacnXihqjruL1/rYGti5hbwSoZmr/KlGD77Gaa/f8FIBkxNmOTelMEisrTtqxYMg==
X-Received: by 2002:a67:2586:: with SMTP id l128mr4867052vsl.52.1562856467869;
        Thu, 11 Jul 2019 07:47:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z10sm1661564vsn.23.2019.07.11.07.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 07:47:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlaMM-0003UA-NL; Thu, 11 Jul 2019 11:47:46 -0300
Date:   Thu, 11 Jul 2019 11:47:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] rdma/siw: remove set but not used variable 's'
Message-ID: <20190711144746.GA13376@ziepe.ca>
References: <20190711071213.57880-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711071213.57880-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 03:12:13PM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/infiniband/sw/siw/siw_cm.c: In function siw_cm_llp_state_change:
> drivers/infiniband/sw/siw/siw_cm.c:1278:17: warning: variable s set but not used [-Wunused-but-set-variable]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied to for-next, thanks

Jason
