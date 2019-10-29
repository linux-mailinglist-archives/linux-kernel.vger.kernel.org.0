Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C19E9051
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 20:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfJ2TvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 15:51:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43417 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfJ2TvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:51:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id a194so78605qkg.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cQkD4MvS0kKW1/ul+xB5LN/x1F0/sjmZ3GaEB4sIcXA=;
        b=UTgrs2sEctwlidoemzTmSe3mg08J8lodDl8CYJjVTOFTT+YNjsbAdL/GBeqMFfnB0l
         URtqgGALgtypK14/rZfHTviUq1QdHn+pD6y+O+SbVT+Ri9fp0oVJLCL30ZyW+ZV7GF/2
         YAKog5d4ob6JulurRIoW80FwREVYBbDEKVeKM/c/hCMBHh5QTy1doYCBSUG3M1H7uidE
         RU8VpQQPZm49g02i6f/9IgGaAP8yJsA5GqT/hGq96XsPzJuGWbltrYTTe/ncqPqIyBGe
         uxfsHVTkc181cbNhqYo7YcmffiBnz+Te8Kb9Nq3MsuE90VUkKzHADyLLt2yWtaWlz3aN
         IFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cQkD4MvS0kKW1/ul+xB5LN/x1F0/sjmZ3GaEB4sIcXA=;
        b=dlY0eUkioh+oug4AEbpAelLxo4KrY4gD9orEsfQAakaEv9XnU2xvuvZxGWdJ96DarM
         2Hfs0xITZp18+GHLm+1dIeV9JmXthhqA8EC/8QWHRSShIptkFYUrfjK38Th2Y4ay2Oov
         6inuA49UiCdw7wt2SFiLPCcHwFthvmi35FuAUz8Z78jqiS/B2/ap3UH2/zuHMhIvJN+l
         8F19DaFU0uWIh+ky/FFQ0F2Rx0OVfpznENovUvQduSozp8wzSDTVXLmPpSoybjlfNABU
         LbXKGJDF9WROW6wALKw0UjDugXNPmRcq+Ztzam5t5HcRor1BdRJM6mdf1tscgSnmZgjF
         lKqA==
X-Gm-Message-State: APjAAAWastKWG5UVKBMtyzKLiSHvYYMoz7WafvwRkKadjRU095O3Y0Xc
        bgGAmpV3DcH1zRYocx3RT/syEg==
X-Google-Smtp-Source: APXvYqwbJHyN8T+1UJD2wSYLRC6t1gVRWzQx3yuUuIdBzMtowjw0Nf3NT4k6ar6ntJVDgExf62sS1w==
X-Received: by 2002:a37:8046:: with SMTP id b67mr24024593qkd.437.1572378662716;
        Tue, 29 Oct 2019 12:51:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g45sm4240565qtb.48.2019.10.29.12.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 12:51:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPXW9-0000Rd-PJ; Tue, 29 Oct 2019 16:51:01 -0300
Date:   Tue, 29 Oct 2019 16:51:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dag Moxnes <dag.moxnes@oracle.com>
Cc:     dledford@redhat.com, leon@kernel.org, parav@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/cma: Use ACK timeout for RoCE
 packetLifeTime
Message-ID: <20191029195101.GA1654@ziepe.ca>
References: <1572003721-26368-1-git-send-email-dag.moxnes@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1572003721-26368-1-git-send-email-dag.moxnes@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 01:42:01PM +0200, Dag Moxnes wrote:
> The cma is currently using a hard-coded value, CMA_IBOE_PACKET_LIFETIME,
> for the PacketLifeTime, as it can not be determined from the network.
> This value might not be optimal for all networks.
> 
> The cma module supports the function rdma_set_ack_timeout to set the
> ACK timeout for a QP associated with a connection. As per IBTA 12.7.34
> local ACK timeout = (2 * PacketLifeTime + Local CA’s ACK delay).
> Assuming a negligible local ACK delay, we can use
> PacketLifeTime = local ACK timeout/2
> as a reasonable approximation for RoCE networks.
> 
> Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
> Change-Id: I200eda9d54829184e556c3c55d6a8869558d76b2

Please don't send Change-Id to the public lists. Run checkpatch before
sending.

Otherwise this seems reasonable to me..

Jason
