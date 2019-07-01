Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6EB229DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 20:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfEXSB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 14:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfEXSB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:01:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A6872133D;
        Fri, 24 May 2019 18:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558720885;
        bh=hmSLAfBO3B9Og9aItR4btdT06y7xyGsHU8gyrdSeqt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CXtj/7Od54AwnGkCQeboo2JY4mfMa22TS+bCHWQk+HNmeJUqiqSfrIeyMKlGzD1Ue
         0Zg+wqMhey54mk//qwwlK9uZB/NU+L/Y33gohUs3tn3EoAHzuRl96Q/wWQQfi3Tle5
         5iQneSg6gm1LK4va9VTGxMoWXRWSbfxcpTVVwlA0=
Date:   Fri, 24 May 2019 20:01:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.2-rc2/3
Message-ID: <20190524180122.GA27745@kroah.com>
References: <20190524175324.GA3024@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524175324.GA3024@ogabbay-VM>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 08:53:24PM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This is the pull request containing fixes for 5.2-rc2/3.
> 
> It supersedes the pull request from 12/5, so you can discard that pull
> request, as I see you didn't merge it anyway.
> 
> It contains 3 fixes and 1 change to a new IOCTL that was introduced to
> kernel 5.2 in the previous pull requests.
> 
> See the tag comment for more details.
> 
> Thanks,
> Oded
> 
> The following changes since commit b0576f9ecb5c51e9932531d23c447b2739261841:
> 
>   misc: sgi-xp: Properly initialize buf in xpc_get_rsvd_page_pa (2019-05-24 19:00:54 +0200)

Wait, that is my char-misc-testing branch, which moves to char-misc-next, not char-misc-linus.

Please rebase this series on char-misc-linus, as the patches in
char-misc-testing are NOT for 5.2-final.

thanks,

greg k-h
