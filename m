Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF8D471BB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2019 20:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfFOSwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jun 2019 14:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfFOSwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 14:52:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 374B821841;
        Sat, 15 Jun 2019 18:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560624756;
        bh=M99q4/HQ+4Y/74fnc/bD3P3M1u3ivtN+4HrYjppkzAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MR90KTxqd2IppmmAO3/oulKkVOC4tLchGohQ7VIOQVtw4+rGYTo14eJvgueeoCN/A
         Gs/wHIJQM+UbsSVFlFjqr0hwRwIVPsWZHvGKuud+C9YP8qC3zjTruWaj50JD3Pphek
         661SnPj8GVZqbTLVsxR6xh3yU7oqp8i2Fwrc2WPY=
Date:   Sat, 15 Jun 2019 20:52:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Josenivaldo Benito Jr <jrbenito@benito.qsl.br>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: hal: Remove return type of
 initrecvbuf
Message-ID: <20190615185234.GB10201@kroah.com>
References: <20190615172220.GA6344@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615172220.GA6344@hari-Inspiron-1545>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 10:52:20PM +0530, Hariprasad Kelam wrote:
> change return of initrecvbuf from s32 to void. As this function always
> returns SUCCESS .
> 
> fix checkpatch warning "Comparison to false is error prone"

That is doing multiple things in the same patch, please break this up :(
