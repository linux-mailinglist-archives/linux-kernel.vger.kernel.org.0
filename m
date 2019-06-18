Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7375349F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 13:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfFRLgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 07:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbfFRLgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:36:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 802482082C;
        Tue, 18 Jun 2019 11:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560857805;
        bh=4Csz7V4opGGGjr3vsDq4pMOrwAbvBsNm1qYoqg8KG5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b83FcHFDni8GqA04zUbRP3dtFLU8K9H3zo9Yke8HSvCAAe7W1qIA7P0kzHEIR1RFE
         sUjA+HNT0UDCqhlpnJx/W6wEF5sHGihO5A/AQ+8lK57OzesXdgdsQ7oVWBnjlxz/eu
         aS65Fb0tBHPqLDzgAyoMjk+W9b+bIuVK+UI73b9c=
Date:   Tue, 18 Jun 2019 13:36:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Varadarajan, Kiruthika" <Kiruthika.Varadarajan@harman.com>
Cc:     Felipe Balbi <balbi@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kiruthikanv@gmail.com" <kiruthikanv@gmail.com>
Subject: Re: [EXTERNAL] Re: Kernel patch  in USB 4.4.138 Version
Message-ID: <20190618113642.GA2283@kroah.com>
References: <6e521b173bd24197930c764dc5fe9ad1@HICGWSMB01.ad.harman.com>
 <20190607135853.GB14665@kroah.com>
 <61ab2bb8e87e4c6a967722a4ae757a4a@HICGWSMB01.ad.harman.com>
 <20190618094737.GB10451@kroah.com>
 <07d0eff017c84006a87aa46af54e1ded@HICGWSMB01.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d0eff017c84006a87aa46af54e1ded@HICGWSMB01.ad.harman.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:34:32AM +0000, Varadarajan, Kiruthika wrote:
> Hi Greg,
>  Now I ran checkpatch and this patch is against kernel version 5.1.
>  Checkpatch run is clean. Could you check my patch now.

Nope, please submit it in the correct format (i.e. not as an attachment,
but as a proper full email, like evertything else on the mailing lists
and as the documentation says to do.)

thanks,

greg k-h
