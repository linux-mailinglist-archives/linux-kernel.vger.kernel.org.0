Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B411E12B0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 03:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfL0Cnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 21:43:32 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51000 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfL0Cnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 21:43:31 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ikfb8-0002mH-HC; Fri, 27 Dec 2019 10:43:30 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ikfb5-0003If-K7; Fri, 27 Dec 2019 10:43:27 +0800
Date:   Fri, 27 Dec 2019 10:43:27 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH v3 0/6] Add TEE interface support to AMD Secure
 Processor driver
Message-ID: <20191227024327.eoa4vhxcfs7qdwe7@gondor.apana.org.au>
References: <cover.1575438845.git.Rijo-john.Thomas@amd.com>
 <20191220070439.etvk73fedrijsrgm@gondor.apana.org.au>
 <a0c7cbd0-2195-195b-d753-7cbadfd4a272@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0c7cbd0-2195-195b-d753-7cbadfd4a272@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 04:25:55PM +0530, Thomas, Rijo-john wrote:
>
> Thank you for pulling in the changes!
> Can you also pull in the patch series titled - TEE driver for AMD APUs? It is
> related to this patch series.
> 
> Jens who is the TEE subsystem maintainer has given an Acked-by for the
> patch series. Please refer link: https://lkml.org/lkml/2019/12/16/608

Please resubmit the patches with the acks attached to linux-crypto.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
