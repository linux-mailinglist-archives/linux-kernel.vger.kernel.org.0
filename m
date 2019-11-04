Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765F1EEAB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 22:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfKDVDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 16:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbfKDVDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:03:44 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 321E720717;
        Mon,  4 Nov 2019 21:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572901423;
        bh=n3I/GXodjAc2ailEgazvTeiRrg2euShf1ziuoKHX/wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgl8ivGyx0ARu3aabpW+8Rb3YzpsH5Fs2BJItwTpzwpxlkxki2CsCMa/DmmEorEDO
         oqUno/dMmbRiHIst7H3QXmDufjlqNKZda+PVz9o09Zza4J+dMDI0P7ixXFiLb7UWWp
         TaUnj+I5rrNmBODqwzF8zdswHqJD89mG2oVKFUv4=
Date:   Mon, 4 Nov 2019 22:03:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] coresight: next v5.4-rc6
Message-ID: <20191104210325.GA2454533@kroah.com>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 11:12:37AM -0700, Mathieu Poirier wrote:
> Hi Greg,
> 
> I collected the following for inclusion in the v5.5 kernel cycle.  Please have a
> have a look when time permits.

Time permits now, looks good, all queued up, thanks.

greg k-h
