Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0947DA7C48
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 09:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfIDHGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 03:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDHGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:06:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 925A522CED;
        Wed,  4 Sep 2019 07:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567580779;
        bh=I9K0yVNmIk+nMrBPinuHZHyseMt4wDZjOkz5NPzTJv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqbkUEYehaSrXbrA77i42/6XFJo9F+Dqfm/CQnrDDYaD2gGZzyzUnJfRcN6URz0Co
         YGZQ1WWRXiph8QDsFxN1ZC5FV8yq3qxSm8w4oh4JDYDVdg5842W7zk2nXE+dk0+W2t
         6kNAYre3X3PEGz3+sZHv1MRneJ5lokv0sRkJS3x4=
Date:   Wed, 4 Sep 2019 09:06:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7]  add support USB for MT8183
Message-ID: <20190904070616.GC18791@kroah.com>
References: <1567150854-30033-1-git-send-email-chunfeng.yun@mediatek.com>
 <1567562067.7317.52.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567562067.7317.52.camel@mhfsdcap03>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 09:54:27AM +0800, Chunfeng Yun wrote:
> Hi Greg,
> 
> 
>   Please don't try to pick up this series, the dependent ones are still
> under public review, I'll fix build warning and send out new version
> after the dependent ones are applied
>   Sorry for inconvenience

No problem, now dropped from my review queue.

greg k-h
