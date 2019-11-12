Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18247F8945
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 08:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKLHDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 02:03:14 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:40831 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfKLHDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:03:14 -0500
Received: by mail-wm1-f45.google.com with SMTP id f3so1695323wmc.5;
        Mon, 11 Nov 2019 23:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yTR9SpBETxhgAVOiN0j4Rh91KHn3K/Qcw71sv13EcbY=;
        b=p0RHmG6yAijKKxnWizQhJ4V63eZhn1njPOyKlPsvetXBs82tKA3ErPZPccBVL2LyzM
         tDs8XlfXmSrQGa1Y9jUwfRphyZGfieol2StuFK7l1HtlxUrtM7TSjfb0kzuKhWcIYFok
         QMbCUShFhdkeKSumCk7kOCjHShI7d5SkqIKkKUlgxpt/rzTasCLEKAC54lL/KCO9rWTD
         1Cr0U/8o+JbdXKAzqyBt3np81hnob7ismNM2/ads1GSqZQwIBMEHSHq4/6PHzvzwyJV8
         fOYBQqXcNoJY7Nkayo4v90A0LE1bW/EGPSRCzyq790b7ZnzHd0kyx1RDd2c6a6VeICnJ
         fdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yTR9SpBETxhgAVOiN0j4Rh91KHn3K/Qcw71sv13EcbY=;
        b=THIy5uPmO34xxFjPT0A3//S172CQs17a3OicsdyPFhCa+olrRy32rxvxm9y+onyO0s
         1hefml9UY6UzkPtzIckMzIsRevWZVQeG7tNwVxAisZiUpg4M6gxqofD+se8w8vc6UAK7
         +5m85MPltG5dkH/K9M9tCQTV79XplwldTlie1Dqr/KmdQ3Fktg+MrWu+4RtJYtXzkL4F
         nfFGAcEi2LNusbWqwgcham6qvpew/AVIdpGrRgrt2U/V+5cMz4nJKJusCwpNsxJZZ8Wx
         AQpkzz6igRiIyLVIdTW65XqHCKnzaJLQiKXKbPDuEWshBuRAYga5uEIa34dmpaD0IlzS
         fCaQ==
X-Gm-Message-State: APjAAAXeq7PYMo9KLT2uRGvADzLeAT2vstWroAWG1t4VALICUJ2VjIDP
        X6B7CzRtrv+SRY1nq0wZ6Oy8PKl7
X-Google-Smtp-Source: APXvYqzGzN3OrxY4U+oStPBlfyGr9UT5SCvqRPCXsmMdPu0Tl40a7Q5VFOOBMC/wiYvMdyqnhSGhOA==
X-Received: by 2002:a7b:cd86:: with SMTP id y6mr2355744wmj.163.1573542192369;
        Mon, 11 Nov 2019 23:03:12 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id s11sm1252875wrr.43.2019.11.11.23.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 23:03:11 -0800 (PST)
Date:   Tue, 12 Nov 2019 08:03:09 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] crypto: sun8i-ss - Fix memdup.cocci warnings
Message-ID: <20191112070309.GA18647@Red>
References: <20191109024403.47106-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109024403.47106-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2019 at 02:44:03AM +0000, YueHaibing wrote:
> Use kmemdup rather than duplicating its implementation
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Hello

Thanks but the patch was already sent by kbuild robot and merged.

Regards
