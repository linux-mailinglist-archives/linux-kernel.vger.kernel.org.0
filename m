Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 655D481FDA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfHEPLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 11:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEPLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:11:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F24221734;
        Mon,  5 Aug 2019 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565017890;
        bh=h6ddiNuKrnZ94s6swCUNGAiEpj4t8uRpUWPS6gppxxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1ebBBgQjjxEoAQUMgojCEmWiEU4KWKz+dXhXQnfUzsxgr2r6TkJUEXecJKaOEPwG
         8LlAesDvobAOZZBITQbda3PMLgrxyrj6/UdVDy72GfjdyzLmrZA99oHrTO1F5X+vC4
         K05Bankr4LlTLBtUIU3c9I1cRa4Ienm2hdi5uSf4=
Date:   Mon, 5 Aug 2019 17:11:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: Add NULL check post kzalloc
Message-ID: <20190805151128.GA16140@kroah.com>
References: <20190804034904.GA16513@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190804034904.GA16513@hari-Inspiron-1545>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 09:19:05AM +0530, Hariprasad Kelam wrote:
> Collect returns status of kzalloc.
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Does not apply to my tree :(
