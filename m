Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7304732F6E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 14:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfFCMUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 08:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfFCMUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:20:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 619DE25F14;
        Mon,  3 Jun 2019 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559564448;
        bh=TWs8GbjLZEVnwhh8cISnycPPa+/IgUhH2+EwwAMLpWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VU31btN3lBLtca7FKNKKtNOd9bMvSoo6k6FnivDNO6JRBr4lvyAcPhZG1+9Dv0gHc
         ftbln7arKRGD1qJ4pcGOugQGLczprn8K36smipnKAPqYGG7dQkTRioiqcbSHXstJ+H
         3r6o+uq+qnMhI5GjQKz3ESlN+pGk2nR1gWntvjOg=
Date:   Mon, 3 Jun 2019 14:20:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        straube.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Change _SUCCESS/_FAIL to 0/-ENOMEM
Message-ID: <20190603122046.GA27037@kroah.com>
References: <20190530210638.30343-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530210638.30343-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 02:36:38AM +0530, Nishka Dasgupta wrote:
> Change return values _SUCCESS and _FAIL to 0 and -ENOMEM respectively,
> to match the convention in the drivers (and also because the return
> value of this changed function is never checked anyway).
> Change return type of the function to int (from u8) to allow the return
> of -ENOMEM.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_cmd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Also does not apply to my tree :(
