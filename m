Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E049994B45
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 19:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfHSRHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 13:07:00 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:36826 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfHSRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:07:00 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 40225803D0;
        Mon, 19 Aug 2019 19:06:57 +0200 (CEST)
Date:   Mon, 19 Aug 2019 19:06:55 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm/drv: Use // for comments in example code
Message-ID: <20190819170655.GA27109@ravnborg.org>
References: <20190808163629.14280-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190808163629.14280-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=VVlED5B4AAAA:8
        a=FVAixOh6KRUHZqgu9kwA:9 a=wPNLvfGTeEIA:10 a=pHzHmUro8NiASowvMSCR:22
        a=Ew2E2A-JSTLzCXPT_086:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan.

Thanks for making this more readable in the html output.

On Thu, Aug 08, 2019 at 06:36:28PM +0200, Jonathan Neuschäfer wrote:
> This improves Sphinx output in two ways:
> 
> - It avoids an unmatched single-quote ('), about which Sphinx complained:
> 
>   /.../Documentation/gpu/drm-internals.rst:298:
>     WARNING: Could not lex literal_block as "c". Highlighting skipped.
> 
>   An alternative approach would be to replace "can't" with a word that
>   doesn't have a single-quote.
> 
> - It lets Sphinx format the comments in italics and grey, making the
>   code slightly easier to read.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

I got Acked-by from Daniel Vetter and has now applied this patch
to drm-misc-next.
It will show up in linux-next after the merge window.

	Sam
