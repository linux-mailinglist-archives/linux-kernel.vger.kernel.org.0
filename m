Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDAF25C80B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 06:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfGBEJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 00:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbfGBEJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 00:09:33 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F91F21479;
        Tue,  2 Jul 2019 04:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562040572;
        bh=QHIKQYd0C1vDCIQWiTD/imqiXd5i87wp/Cn6DiqKHsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmU7CB9r0vkCCK+CQFBkbfh2n1inubA0uIQiTnPKL4/pDFHEuOe0BpXEunNcBV1RR
         SlwE9ZIAaLZX6f7oKMkKSlVrbbNonA8Eho8FU7fWbxFJRw7v43JwmO2qSl/RUhbu3x
         ByeLZBValp11EBI0QCESzQMOvGCH99TZ+l9sH1pc=
Date:   Tue, 2 Jul 2019 07:09:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Saeed Mahameed <saeedm@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mlx5-next tree
Message-ID: <20190702040924.GP4727@mtr-leonro.mtl.com>
References: <20190702100533.206ea0df@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702100533.206ea0df@canb.auug.org.au>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 10:05:33AM +1000, Stephen Rothwell wrote:
> Hi all,
>
> In commit
>
>   16fff98a7e82 ("net/mlx5: E-Switch, Reg/unreg function changed event at correct stage")
>
> Fixes tag
>
>   Fixes: 61fc880839e6 ("net/mlx5: E-Switch, Handle representors creation in handler context")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Did you mean
>
> Fixes: ac35dcd6e4bd ("net/mlx5: E-Switch, Handle representors creation in handler context")

Right, unfortunately this commit was already merged.

Thanks

>
> --
> Cheers,
> Stephen Rothwell


