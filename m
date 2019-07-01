Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 396BA55E14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 04:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfFZCC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 22:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFZCC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:02:59 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E0A2147A;
        Wed, 26 Jun 2019 02:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561514578;
        bh=tVTDgsYdLLiYUPWFr4QnZca7y3KHBSyDW0AllHKh8mY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NpPO1yNjEl/psxr/tziNJ1y49UDBtgI4SVsr0FaSb1mJ9g4XnnY9bGtWMuGLCOHD+
         KOjUxxcsTOhNrPP7+iiz11RyWN3JWgPATOtoShGFEYyuEw8RoibdAO7Or8VdOce0J9
         6K/zIiKU2Z181B5gUOpv8V38QkEZpQeoj8NgmMhM=
Date:   Wed, 26 Jun 2019 09:53:01 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?M=FCller?= <muellerch-privat@web.de>
Cc:     devel@driverdev.osuosl.org, felix.trommer@hotmail.de,
        linux-kernel@i4.cs.fau.de, linux-kernel@vger.kernel.org,
        johnfwhitmore@gmail.com
Subject: Re: [PATCH 1/2] drivers/staging/rtl8192u: adjust block comments
Message-ID: <20190626015301.GA30966@kroah.com>
References: <20190620113308.GA16195@kroah.com>
 <20190624094640.5459-1-muellerch-privat@web.de>
 <20190624094640.5459-2-muellerch-privat@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624094640.5459-2-muellerch-privat@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 11:46:39AM +0200, Christian M�ller wrote:
> As stated in coding-styles.rst multiline comments should be structured in a way,
> that the actual comment starts on the second line of the commented portion. E.g:

<snip>

You sent 2 patches that did different things, yet have the identical
subject line :(

Please fix up and resend the series.

thanks,

greg k-h
