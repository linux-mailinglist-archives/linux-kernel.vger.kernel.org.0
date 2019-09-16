Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36DD1B34AD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 08:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfIPGW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 02:22:59 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17926 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728106AbfIPGW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 02:22:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568614966; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=q7cO6nl0+/+L5iKEuWg2kOdVW3GnIEu9TUY5Zn92WkZaL2CDV2tkAfIYRqnkZlTjSTRqHSCm8h3Lm5pIez32EtESfLxiGRyjxEbvX40S4lKSYgt8SFLKl/nhYHIfiyhQaV1HMeyYwHpKp0WDVP1reuUxD6wTxWnGi+IHtQFhn+Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1568614966; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=KFnu+vV3Emgd9lQvV4LU1uDFKh1nPCY+rE9r8UbqdJc=; 
        b=kN/vs5B8WKat/YTMyvNaGzUA4gL1qR3Pc4k6qKxy/rV0EEJ86lcBXuU5fdOG9myk/Yzg9BdCPxe07Dr2GUFiKg/uvSjvleruMgPbVKJCK/ZbgUseOjssA1FCsuuk7ZuaM0XexuVQWrvGQtHSyM0k720dxHyR1bg3CiTwMKMjAtE=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=euphon.net;
        spf=pass  smtp.mailfrom=fam@euphon.net;
        dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1568614966;
        s=zoho; d=euphon.net; i=fam@euphon.net;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=456; bh=KFnu+vV3Emgd9lQvV4LU1uDFKh1nPCY+rE9r8UbqdJc=;
        b=PLsaCF/ZNUaXdsuUfQT3RjukIynRsfmhNBSiKf8447Pu6MBrmXP5GYoIQG+u4vta
        /Ecmn1jKpIICFeiODXTk9uDSYEcNha4vDSUAv0HdTV++zTLfJvNXO9Ka3pz+em7fUDY
        DEr46E6GelXjTAaSmgAfyiZ9tI3z109JX4JpxaPA=
Received: from localhost (120.52.147.46 [120.52.147.46]) by mx.zoho.com.cn
        with SMTPS id 156861496368045.56814894994807; Mon, 16 Sep 2019 14:22:43 +0800 (CST)
Date:   Mon, 16 Sep 2019 14:22:42 +0800
From:   Fam Zheng <fam@euphon.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bfq: Fix bfq linkage error
Message-ID: <20190916062242.GA25284@magic>
References: <9afc7a2cd013344290096d9dfe9355bcb57b3bbd.1568482098.git.asml.silence@gmail.com>
 <333de59c-d4ca-3bc2-fffa-35d60bd14126@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <333de59c-d4ca-3bc2-fffa-35d60bd14126@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ZohoCNMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09/14 11:32, Jens Axboe wrote:
> On 9/14/19 11:31 AM, Pavel Begunkov (Silence) wrote:
> > From: Pavel Begunkov <asml.silence@gmail.com>
> > 
> > Since commit 795fe54c2a828099e ("bfq: Add per-device weight"), bfq uses
> > blkg_conf_prep() and blkg_conf_finish(), which are not exported. So, it
> > causes linkage error if bfq compiled as a module.
> 
> Thanks, I'll apply and add the Fixes tag.

Thanks!  This is indeed my oversight.

Fam

