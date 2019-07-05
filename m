Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9FA5F259
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 07:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfGDFla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 01:41:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfGDFl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:41:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBB3921882;
        Thu,  4 Jul 2019 05:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562218889;
        bh=LCMwwVt5TusTWgMbSW4gSBduWo/IwMHqLUGooJtnrHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePyYw0uwGLbqVdD6/W7t1bHpdnMcTSunged9BFGXSYDFT/1ZFmhLMvO3QkOd9ktAW
         fUkwu0WAd8NqFzejnGYWhVwqscNDfX6hqFBg5wCcNF+1NNtGT2vkp7XkT16W7RoBX+
         9YJZkddWn9Id+k5afFYLyVgbfY3PhPvwKcp/SpVc=
Date:   Thu, 4 Jul 2019 07:41:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Muchun Song <smuchun@gmail.com>, rafael@kernel.org,
        prsood@codeaurora.org, mojha@codeaurora.org, gkohli@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 OPT1] driver core: Fix use-after-free and double free
 on glue directory
Message-ID: <20190704054126.GD347@kroah.com>
References: <20190626143823.7048-1-smuchun@gmail.com>
 <20190703193717.GB8452@kroah.com>
 <01ca95431a642133293534502975765dba993ada.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ca95431a642133293534502975765dba993ada.camel@kernel.crashing.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 08:57:53AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2019-07-03 at 21:37 +0200, Greg KH wrote:
> > Ok, I guess I have to take this patch, as the other one is so bad :)
> > 
> > But, I need a very large comment here saying why we are poking around in
> > a kref and why we need to do this, at the expense of anything else.
> > 
> > So can you respin this patch with a comment here to help explain it so
> > we have a chance to understand it when we run across this line in 10
> > years?
> 
> Also are we confident that an open dir on the glue dir from userspace
> won't keep the kref up ?

How do you "open" a directory which raises the kref?

thanks,

greg k-h
