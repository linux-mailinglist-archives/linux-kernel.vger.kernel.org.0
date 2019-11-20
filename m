Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16002104195
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 17:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfKTQzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 11:55:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfKTQzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:55:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F40E62071F;
        Wed, 20 Nov 2019 16:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574268935;
        bh=8FrHjGta+6jwWJXLwHTgBvG6rHWnBmFRWE1CWfOKi2I=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=GuaUCGXRy69UGMILRhEiXMQht7KknaeqSwn+pkg/GnFmDDi44IhBbx08jJcgAkU5O
         JKaj0sp6QY8rmyw6QWibarbtgNwmXj76E/oNNTaTytyuju0eZnU6EensCUxr+w/3tG
         vlm6pFo8SE7DrAHPxscB+DzfIitfTsBVG8quudHE=
Date:   Wed, 20 Nov 2019 17:55:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] staging: fbtft: Fix Kconfig indentation
Message-ID: <20191120165533.GA3027865@kroah.com>
References: <20191120133911.13539-1-krzk@kernel.org>
 <20191120164155.GR30416@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120164155.GR30416@phenom.ffwll.local>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 05:41:55PM +0100, Daniel Vetter wrote:
> On Wed, Nov 20, 2019 at 09:39:11PM +0800, Krzysztof Kozlowski wrote:
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> > 	$ sed -e 's/^        /\t/' -i */Kconfig
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I expect Greg will pick this up.

Already picked up :)

thanks for the review,

greg k-h
