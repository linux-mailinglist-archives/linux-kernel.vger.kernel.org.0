Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 361141227D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 10:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLQJoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 04:44:10 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42584 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfLQJoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:44:10 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ih9Oj-0005f7-9C; Tue, 17 Dec 2019 17:44:09 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ih9Od-0007In-7f; Tue, 17 Dec 2019 17:44:03 +0800
Date:   Tue, 17 Dec 2019 17:44:03 +0800
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
Message-ID: <20191217094403.xxefstm5gdamwdvp@gondor.apana.org.au>
References: <cover.1575438845.git.Rijo-john.Thomas@amd.com>
 <26cb9589-8774-897b-4d1e-919e7ad2200f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26cb9589-8774-897b-4d1e-919e7ad2200f@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas:

On Thu, Dec 12, 2019 at 06:03:20PM +0530, Thomas, Rijo-john wrote:
> 
> Please let me know if you have any comment for this patch series.
> Request you to consider these patches for next merge cycle.

They look fine to me.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
