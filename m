Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0C6188955
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 16:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCQPnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 11:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgCQPnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:43:50 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 098E120714;
        Tue, 17 Mar 2020 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584459829;
        bh=3M6KQ+x/xS3b9actzvjEtiSqxHD+FssQ/SJMBjO96DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z4RDNg/j8xNMU4GKgnD8q+wVtufDQchEqw5q4MftWja5Hh2cyJd0f3SxKXwfi7W6C
         S/6v7whedviS9T5cTpBV2mEa7gjORKGgiWKkkQAv31wlSg9H/RzLPRnqqvMpIVbQAk
         k/EYSilHOaA3qM3fojeBHgV8yaX0YxUWwmDYcW44=
Date:   Wed, 18 Mar 2020 00:43:43 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     masahiro31.yamada@kioxia.com
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] nvme: Add compat_ioctl handler for
 NVME_IOCTL_SUBMIT_IO
Message-ID: <20200317154343.GA29084@redsun51.ssa.fujisawa.hgst.com>
References: <92c670379c264775b8bb28a2bd3b380b@TGXML281.toshiba.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92c670379c264775b8bb28a2bd3b380b@TGXML281.toshiba.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 11:13:29AM +0000, masahiro31.yamada@kioxia.com wrote:
> Currently 32 bit application gets ENOTTY when it calls
> compat_ioctl with NVME_IOCTL_SUBMIT_IO in 64 bit kernel.
> 
> The cause is that the results of sizeof(struct nvme_user_io),
> which is used to define NVME_IOCTL_SUBMIT_IO,
> are not same between 32 bit compiler and 64 bit compiler.
> 
> * 32 bit: the result of sizeof nvme_user_io is 44.
> * 64 bit: the result of sizeof nvme_user_io is 48.
> 
> 64 bit compiler seems to add 32 bit padding for multiple of 8 bytes.
> 
> This patch adds a compat_ioctl handler.
> The handler replaces NVME_IOCTL_SUBMIT_IO32 with NVME_IOCTL_SUBMIT_IO
> in case 32 bit application calls compat_ioctl for submit in 64 bit kernel.
> Then, it calls nvme_ioctl as usual.
> 
> Signed-off-by: Masahiro Yamada (KIOXIA) <masahiro31.yamada@kioxia.com>

Thank you, applied for 5.7.
